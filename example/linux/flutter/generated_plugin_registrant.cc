//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <app_extensions/app_extensions_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) app_extensions_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AppExtensionsPlugin");
  app_extensions_plugin_register_with_registrar(app_extensions_registrar);
}
