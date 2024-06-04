import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marsvpn/views/about.dart';
import 'package:marsvpn/views/account.dart';
import 'package:marsvpn/views/privacy_policy.dart';
import 'package:marsvpn/views/redeem.dart';
import 'package:marsvpn/views/servers.dart';
import 'package:marsvpn/views/settings.dart';
import 'package:marsvpn/views/share.dart';
import 'package:marsvpn/views/term_of_service.dart';
import 'package:marsvpn/views/vip.dart';
import 'views/home.dart';
import 'themes/colors.dart';
import 'themes/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: CustomColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mars VPN',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(
          name: '/vip',
          page: () => Vip(),
        ),
        GetPage(name: '/settings', page: () => Settings()),
        GetPage(
          name: '/about',
          page: () => About(),
        ),
        GetPage(name: '/servers', page: () => Servers()),
        GetPage(name: '/redeem', page: () => Redeem()),
        GetPage(name: '/share', page: () => Share()),
        GetPage(name: '/account', page: () => Account()),
        GetPage(name: '/settings/termsOfService', page: () => TermOfService()),
        GetPage(name: '/settings/privacyPolicy', page: () => PrivacyPolicy()),
        GetPage(name: '/settings/about', page: () => About()),
      ],
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: CustomColors.background,
          primary: CustomColors.primary,
          secondary: CustomColors.secondary,
        ),
        textTheme: textTheme,
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
