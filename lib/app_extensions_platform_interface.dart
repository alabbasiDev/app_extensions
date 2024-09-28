// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// import 'app_extensions_method_channel.dart';
//
// abstract class AppExtensionsPlatform extends PlatformInterface {
//   /// Constructs a AppExtensionsPlatform.
//   AppExtensionsPlatform() : super(token: _token);
//
//   static final Object _token = Object();
//
//   static AppExtensionsPlatform _instance = MethodChannelAppExtensions();
//
//   /// The default instance of [AppExtensionsPlatform] to use.
//   /// Defaults to [MethodChannelAppExtensions].
//   static AppExtensionsPlatform get instance => _instance;
//
//   /// Platform-specific implementations should set this with their own
//   /// platform-specific class that extends [AppExtensionsPlatform] when
//   /// they register themselves.
//   static set instance(AppExtensionsPlatform instance) {
//     PlatformInterface.verifyToken(instance, _token);
//     _instance = instance;
//   }
//
//   Future<String?> getPlatformVersion() {
//     throw UnimplementedError('platformVersion() has not been implemented.');
//   }
// }
