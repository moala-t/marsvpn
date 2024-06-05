import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/connecting_time.dart';
import 'package:marsvpn/components/toast.dart';
import 'package:marsvpn/data/pricing_plans.dart';
import 'package:marsvpn/data/restricted_countries.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';
import '../api/auth_api_service.dart';
import '../api/pub_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var vpnStatus = ''.obs;
  var freeServers = [].obs;
  var premiumServers = [].obs;
  var pricingPlans = [].obs;
  var user = Rxn<Map>();
  var selectedServer = Rxn<Map>();
  var selectedPricingPlan = Rxn<Map>();
  var isLogin = false.obs;
  var loginTimer = Rxn<int>();
  var isAnonymouStatistics = true.obs;
  var connectWhenAppStarts = false.obs;
  var showNotification = true.obs;
  var improveConncetionStability = true.obs;
  final vpnTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  var ipLocation = Rxn<Map>();

  final wireguard = WireGuardFlutter.instance;
  final String interfaceName = 'mars_vpn_wg';
  late DeviceInfoService dis;
  late PubApiService pubApi;
  late AuthApiService authApi;
  late UUIDService uuid;
  late FToast fToast;

  @override
  void onInit() async {
    super.onInit();
    dis = DeviceInfoService();
    uuid = UUIDService();
    pubApi = PubApiService();
    authApi = AuthApiService();
    vpnListener();
    pingPong();
    dis.getOrStoreDeviceDetails();
    uuid.getOrStoreUUID();
    fetchPricingPlans();
    initializeVpn();
    fToast = FToast();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fToast.init(Get.overlayContext!);
    });
    await fetchFreeServers();
    await checkLogin();
    if (isLogin.value == true) {
      fetchUser();
      await fetchPremiumServers();
    }
    await getVpnStatus();
    if (vpnStatus.value == "connected") {
      final serverId_ = await loadInteger('lastConnectedServerId');
      print(serverId_);
      selectedServer.value =
          findServerById([...premiumServers, ...freeServers], serverId_);
      final lastConnectionTime = await loadDateTime('lastConnectionTime');
      startTimer(vpnTimer,
          presetSeconds:
              DateTime.now().difference(lastConnectionTime!).inSeconds);
    }
    selectedServer.value ??= premiumServers.isNotEmpty
        ? chooseSmartLocations(premiumServers)[0]
        : chooseSmartLocations(freeServers)?[0];

    // await fetchLocationInfo();
    debugPrint("Controller Initialized");
  }

  void setSelectedServer(Map server) {
    selectedServer.value = server;
  }

  void onLoginIntitialize() {
    fetchFreeServers();
    fetchPremiumServers();
    fetchUser();
  }

  void onLogoutIntitialize() {
    fetchFreeServers();
    premiumServers.value = [];
    user.value = {};
    selectedServer.value = null;
  }

  void setSelectedPricingPlan(Map? pricingPlan) {
    selectedPricingPlan.value = pricingPlan;
  }

  Map<String, List> getGroupedServers(List servers) {
    var groupedServers = <String, List>{};

    for (var server in servers) {
      if (groupedServers.containsKey(server['country'])) {
        groupedServers[server['country']]?.add(server);
      } else {
        groupedServers[server['country']] = [server];
      }
    }

    return groupedServers;
  }

  chooseSmartLocations(servers, {maximum = 5}) {
    final smartServers = [];
    servers.sort((a, b) {
      double ratioA = (a['max_connections'] == 0)
          ? 0
          : a['active_connections'] / a['max_connections'];
      double ratioB = (b['max_connections'] == 0)
          ? 0
          : b['active_connections'] / b['max_connections'];
      return ratioA.compareTo(ratioB); // Sort in descending order
    });

    for (var server in servers) {
      bool countryExists =
          smartServers.any((s) => s['country'] == server['country']);
      if (!countryExists) {
        smartServers.add(server);
        if (smartServers.length >= maximum) {
          break; // Stop if we've reached the maximum number of servers
        }
      }
    }
    return smartServers;
  }

  filterWireguardRestricted(List servers) {
    // if user location is wireguard restricted
    final validServers = [];
    if (ipLocation.value?['country'] != null &&
        wireguardRestrictedCountries.contains(ipLocation.value?['country'])) {
      for (var server in servers) {
        if (
            // server['protocols'].length == 1 &&
            //   server['protocols'][0]['vpn']['name'] == 'wireguard' &&
            wireguardRestrictedCountries.contains(server['country']) &&
                server['next_server'] != null) {
          validServers.add(server);
        }
      }
      return validServers;
      // if user location is not a wireguard restricted country
    } else if (ipLocation.value?['country'] != null &&
        !wireguardRestrictedCountries.contains(ipLocation.value?['country'])) {
      for (var server in servers) {
        if (server['next_server'] == null) {
          validServers.add(server);
        }
      }
      return validServers;
      // if couldn't determine user location
    } else {
      return servers;
    }
  }

  fetchLocationInfo() async {
    final response = await http.get(Uri.parse('https://api.country.is/'));
    if (response.statusCode == 200) {
      ipLocation.value = json.decode(response.body);
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  fetchUser() async {
    final user_ = await authApi.fetchUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user_ != null) {
      user.value = user_;
      String userJson = jsonEncode(user_);
      await prefs.setString('user', userJson);
    } else {
      String? storedJsonUser = prefs.getString('user');
      if (storedJsonUser != null) {
        Map<String, dynamic> storedDecodedUser = jsonDecode(storedJsonUser);
        user.value = storedDecodedUser;
      } else {}
    }
    return user.value;
  }

  fetchFreeServers() async {
    final servers_ = await pubApi.fetchFreeServers();
    if (servers_ != null) {
      freeServers.value = servers_;
    }
  }

  updateConfigIsConnected(id, isConnected) async {
    print("id $id updated to $isConnected");
    final isConnectedData =
        await pubApi.updateConfigIsConnected(id, isConnected);
    if (isConnectedData != null) {
      return true;
    }
    return false;
  }

  fetchPremiumServers() async {
    final servers_ = await authApi.fetchPremiumServers();
    if (servers_ != null) {
      premiumServers.value = servers_;
    }
  }

  fetchPricingPlans() async {
    final pricingPlans_ = await pubApi.fetchPricingPlans();
    if (pricingPlans_ == null) {
      pricingPlans.value = pricingPlansData;
    } else {
      pricingPlans.value = pricingPlans_;
    }
    setSelectedPricingPlan(pricingPlans[1]);
  }

  void toggleVpnStatus() async {
    var stage = await getVpnStatus();
    if (stage == 'connecting' || stage == 'connected') {
      disconnectVpn();
    } else if (stage == "disconnected" || stage == "no_connection") {
      startVpn();
    }
  }

  findServerById(servers, id) {
    for (var server in servers) {
      print(server['id']);
      if (server['id'] == id) {
        return server;
      }
    }
    return null;
  }

  void vpnListener() {
    wireguard.vpnStageSnapshot.listen((event) async {
      final status = event.code;
      vpnStatus.value = status;
      if (status == 'connected') {
        saveDateTime('lastConnectionTime', DateTime.now());
        saveInteger('lastConnectedServerId', selectedServer.value?['id']);
        startTimer(vpnTimer);
      } else if (status == 'disconnected') {
        stopTimer(vpnTimer);
      }
    });
  }

  Future<void> initializeVpn() async {
    try {
      await wireguard.initialize(interfaceName: interfaceName);
      debugPrint("initialize success $interfaceName");
    } catch (error, stack) {
      debugPrint("failed to initialize: $error\n$stack");
    }
  }

  selectProperConfig(Map server) async {
    for (var config in server['configs']) {
      if (config['is_connected'] == false &&
          config['is_server_config'] == false) {
        final confFile = await downloadAndReadFile(config['file']);
        final ipAddress = server['ip_address'];
        final port = config['protocol']['port'];
        return {
          'config': config,
          'confFile': confFile,
          'ip_address': '$ipAddress:$port'
        };
      }
    }
    return null;
  }

  void startVpn() async {
    var server_ = selectedServer.value;

    if (server_ == null) {
      if (premiumServers.isNotEmpty) {
        server_ = chooseSmartLocations(premiumServers)[0];
      } else if (freeServers.isNotEmpty) {
        server_ = chooseSmartLocations(freeServers)[0];
      } else {
        return;
      }
    }

    final config = await selectProperConfig(server_!);
    // pingPong();
    if (config != null) {
      print(config['confFile']);
      await saveInteger('lastConnectedConfigId', config['config']['id']);
      await updateConfigIsConnected(config['config']['id'], true);
      try {
        await wireguard.startVpn(
          serverAddress: config['ip_address'],
          wgQuickConfig: config['confFile'],
          providerBundleIdentifier: 'com.moallatakhtdar.marsvpn',
        );
      } catch (error, stack) {
        debugPrint("failed to start $error\n$stack");
      }
    }
  }

  void disconnectVpn() async {
    try {
      await wireguard.stopVpn();
      updateConfigIsConnected(
          await loadInteger('lastConnectedConfigId'), false);
    } catch (e, str) {
      debugPrint('Failed to disconnect $e\n$str');
    }
  }

  getVpnStatus() async {
    final stage = await wireguard.stage();
    vpnStatus.value = stage.code;
    return stage.code;
  }

  // Method to check if refresh token exists and is not expired (auth)
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null || refreshToken == '') {
      isLogin.value = false;
      return false;
    }

    // Decode the JWT to check its expiration
    if (JwtDecoder.isExpired(refreshToken)) {
      isLogin.value = false;
      return false;
    }
    isLogin.value = true;
    return true;
  }

  // Method to login and clear tokens
  Future<bool> login(String code) async {
    final tokens = await pubApi.login(code);
    if (tokens is int) {
      loginTimer.value = tokens;
      showToast('Redeem Failed.\nPlease try again.', 'failure', fToast);
      return false;
    } else if (tokens == null) {
      showToast('Redeem Failed.\nPlease try again.', 'failure', fToast);
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (tokens['access']!.length > 1 && tokens['refresh']!.length > 1) {
        await prefs.setString('access_token', tokens['access'] ?? '');
        await prefs.setString('refresh_token', tokens['refresh'] ?? '');
      }
      isLogin.value = true;
      onLoginIntitialize();
      showToast('Redeem\nSuccessful', 'success', fToast);
      return true;
    }
  }

  // Method to logout and clear tokens
  Future<void> logout() async {
    final logout_ = await authApi.logout();
    if (logout_) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      isLogin.value = false;
      onLogoutIntitialize();
    } else {
      showToast('Logout Failed.\nPlease try again.', 'failure', fToast);
    }
  }

  Future<bool> pingPong() async {
    final pingpong = await pubApi.pingPong();
    if (!pingpong) {
      showToast('No Internet\nConnection', 'noInternet', fToast);
      return false;
    } else {
      return true;
    }
  }
}
