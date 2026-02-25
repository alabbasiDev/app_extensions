import 'package:flutter/material.dart';

import 'platform_checker.dart';

/// BuildContext extension for platform checks.
///
/// Provides convenient access to [PlatformChecker] when a [BuildContext]
/// is available. Delegates to [PlatformChecker] for all platform detection.
///
/// Usage:
/// ```dart
/// if (context.isWeb) { ... }
/// if (context.isAndroid) { ... }
/// if (context.isMobile) { ... }
/// ```
extension BuildContextPlatformExtensions on BuildContext {
  /// Returns true when running on web (browser).
  bool get isWeb => PlatformChecker.isWeb;

  /// Returns true when running on Android (native, not web).
  bool get isAndroid => PlatformChecker.isAndroid;

  /// Returns true when running on iOS (native, not web).
  bool get isIOS => PlatformChecker.isIOS;

  /// Returns true when running on Windows (native, not web).
  bool get isWindows => PlatformChecker.isWindows;

  /// Returns true when running on macOS (native, not web).
  bool get isMacOS => PlatformChecker.isMacOS;

  /// Returns true when running on Linux (native, not web).
  bool get isLinux => PlatformChecker.isLinux;

  /// Returns true when running on Fuchsia (native, not web).
  bool get isFuchsia => PlatformChecker.isFuchsia;

  /// Returns true when running on mobile (Android or iOS).
  bool get isMobile => PlatformChecker.isMobile;

  /// Returns true when running on desktop (Windows, macOS, or Linux).
  bool get isDesktop => PlatformChecker.isDesktop;

  /// Returns the operating system name as a string.
  String get operatingSystem => PlatformChecker.operatingSystem;

  /// Returns true when running on a platform that supports native
  /// Platform API (dart:io).
  bool get supportsDartIo => PlatformChecker.supportsDartIo;
}
