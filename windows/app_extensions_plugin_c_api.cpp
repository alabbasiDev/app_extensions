#include "include/app_extensions/app_extensions_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "app_extensions_plugin.h"

void AppExtensionsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  app_extensions::AppExtensionsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
