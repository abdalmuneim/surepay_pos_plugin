#include "include/surepay_pos_plugin/surepay_pos_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "surepay_pos_plugin.h"

void SurepayPosPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  surepay_pos_plugin::SurepayPosPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
