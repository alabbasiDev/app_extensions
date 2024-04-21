#ifndef FLUTTER_PLUGIN_APP_EXTENSIONS_PLUGIN_H_
#define FLUTTER_PLUGIN_APP_EXTENSIONS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace app_extensions {

class AppExtensionsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AppExtensionsPlugin();

  virtual ~AppExtensionsPlugin();

  // Disallow copy and assign.
  AppExtensionsPlugin(const AppExtensionsPlugin&) = delete;
  AppExtensionsPlugin& operator=(const AppExtensionsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace app_extensions

#endif  // FLUTTER_PLUGIN_APP_EXTENSIONS_PLUGIN_H_
