import 'package:flutter/material.dart';

//
// extension AppColorExtension on Color {
//   String toHexColorFromColor({bool leadingHashSign = true}) {
//     return '${leadingHashSign ? '#' : ''}'
//         '${red.toRadixString(16).padLeft(2, '0')}'
//         '${green.toRadixString(16).padLeft(2, '0')}'
//         '${blue.toRadixString(16).padLeft(2, '0')}';
//   }
// }

extension AppColorExtension on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? fromHex(String? hexString) {
    final buffer = StringBuffer();
    if (hexString == null) {
      return null;
    }
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';



  /// Returns [Colors.black] if the [backgroundColor] is light,
  /// otherwise returns [Colors.white].
  Color get getContrastingColor {
    // computeLuminance() returns a value between 0.0 (dark) and 1.0 (light)
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  /// Returns a darker variant of the given [color] by reducing its lightness.
  /// The [amount] parameter defines how much to darken the color (default is 10%).
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    // Convert the color to HSL
    final hslColor = HSLColor.fromColor(this);

    // Decrease the lightness by [amount], ensuring it doesn't go below 0.
    final darkenedHsl = hslColor.withLightness(
      (hslColor.lightness - amount).clamp(0.0, 1.0),
    );

    // Convert back to Color
    return darkenedHsl.toColor();
  }

  /// Returns a variant of [color] with a burn effect applied.
  ///
  /// The [burnFactor] (between 0 and 1) controls the intensity:
  /// - It reduces lightness by that factor.
  /// - Increases saturation slightly (up to a factor of burnFactor * 0.5).
  /// - Shifts the hue toward warmer tones (subtracting burnFactor * 30 degrees).
  Color burnEffect([double burnFactor = 0.2]) {
    assert(burnFactor >= 0 && burnFactor <= 1,
    'burnFactor must be between 0 and 1');

    // Convert the color to HSL.
    final hsl = HSLColor.fromColor(this);

    // Darken: Reduce the lightness.
    final double newLightness = (hsl.lightness - burnFactor).clamp(0.0, 1.0);

    // Increase saturation a bit to make the effect more pronounced.
    final double newSaturation =
    (hsl.saturation + burnFactor * 0.5).clamp(0.0, 1.0);

    // Shift the hue toward a warmer color.
    // For example, subtracting up to 30 degrees based on burnFactor.
    final double newHue = (hsl.hue - burnFactor * 30) % 360;

    // Create a new HSL color with the adjusted values.
    final burnedHSL =
    HSLColor.fromAHSL(hsl.alpha, newHue, newSaturation, newLightness);

    // Convert back to a Color.
    return burnedHSL.toColor();
  }
}

