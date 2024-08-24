import 'package:flutter_test/flutter_test.dart';
import 'package:app_extensions/app_extensions_platform_interface.dart';
import 'package:app_extensions/app_extensions_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppExtensionsPlatform
    with MockPlatformInterfaceMixin
    implements AppExtensionsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppExtensionsPlatform initialPlatform = AppExtensionsPlatform.instance;

  test('$MethodChannelAppExtensions is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppExtensions>());
  });

  test('getPlatformVersion', () async {
    // AppExtensions appExtensionsPlugin = AppExtensions();
    MockAppExtensionsPlatform fakePlatform = MockAppExtensionsPlatform();
    AppExtensionsPlatform.instance = fakePlatform;

    // expect(await appExtensionsPlugin.getPlatformVersion(), '42');
  });
}
