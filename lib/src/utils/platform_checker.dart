import 'package:flutter/foundation.dart';

/// Cross-platform platform checker that works on all platforms including web.
///
/// Uses [kIsWeb] and [defaultTargetPlatform] from Flutter foundation,
/// avoiding [dart:io] which is not available on web.
///
/// Usage:
/// ```dart
/// if (PlatformChecker.isWeb) { ... }
/// if (PlatformChecker.isAndroid) { ... }
/// if (PlatformChecker.isIOS) { ... }
/// ```
class PlatformChecker {
  PlatformChecker._();

  /// Returns true when running on web (browser).
  static bool get isWeb => kIsWeb;

  /// Returns true when running on Android (native, not web).
  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Returns true when running on iOS (native, not web).
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Returns true when running on Windows (native, not web).
  static bool get isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Returns true when running on macOS (native, not web).
  static bool get isMacOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Returns true when running on Linux (native, not web).
  static bool get isLinux =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Returns true when running on Fuchsia (native, not web).
  static bool get isFuchsia =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Returns true when running on mobile (Android or iOS).
  static bool get isMobile => isAndroid || isIOS;

  /// Returns true when running on desktop (Windows, macOS, or Linux).
  static bool get isDesktop => isWindows || isMacOS || isLinux;

  /// Returns the operating system name as a string.
  /// Useful for analytics, logging, or API payloads.
  static String get operatingSystem {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }

  /// Returns true when running on a platform that supports native
  /// Platform API (dart:io). Use this before using Platform.* from dart:io.
  static bool get supportsDartIo => !kIsWeb;
}

