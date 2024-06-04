//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <smart_auth/smart_auth_plugin.h>
#include <wireguard_flutter/wireguard_flutter_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  SmartAuthPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SmartAuthPlugin"));
  WireguardFlutterPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WireguardFlutterPluginCApi"));
}
