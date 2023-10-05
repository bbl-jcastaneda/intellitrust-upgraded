#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(IntellitrustPlugin, "Intellitrust",
           CAP_PLUGIN_METHOD(echo, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(createNewSoftTokenIdentity, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getOTP, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(deleteIdentity, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(parseNotification, CAPPluginReturnPromise);
)
