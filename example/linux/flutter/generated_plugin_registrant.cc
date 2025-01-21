//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <surepay_pos_plugin/surepay_pos_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) surepay_pos_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SurepayPosPlugin");
  surepay_pos_plugin_register_with_registrar(surepay_pos_plugin_registrar);
}
