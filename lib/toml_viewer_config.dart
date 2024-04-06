import 'dart:math';
import 'package:flutter/material.dart';

class TomlViewerConfig {
  final bool expandMode;
  final Color valueColor;
  final Color typeTextColor;
  final Color symbolColor;
  final Color nonRootKeyColor;
  final Color rootKeyColor;
  final Color keyColor;

  TomlViewerConfig({
    this.expandMode = true,
    this.valueColor = const Color.fromRGBO(255, 68, 68, 1.0), // Red shade 800
    this.typeTextColor = Colors.grey,
    this.symbolColor = Colors.grey,
    this.nonRootKeyColor =
        const Color.fromRGBO(0, 51, 153, 1.0), // Blue shade 900
    this.rootKeyColor =
        const Color.fromRGBO(0, 51, 153, 1.0), // Purple shade 900
    this.keyColor = const Color.fromRGBO(0, 128, 128, 1.0), // Teal shade 700
  });

  /// Creates a copy of this configuration with optionally updated fields.
  factory TomlViewerConfig.copyWith({
    bool? expandMode,
    Color? valueColor,
    Color? typeTextColor,
    Color? symbolColor,
    Color? nonRootKeyColor,
    Color? rootKeyColor,
    Color? keyColor,
  }) {
    return TomlViewerConfig(
      expandMode: expandMode ?? true,
      valueColor: valueColor ?? const Color.fromRGBO(255, 68, 68, 1.0),
      typeTextColor: typeTextColor ?? Colors.grey,
      symbolColor: symbolColor ?? Colors.grey,
      nonRootKeyColor: nonRootKeyColor ?? const Color.fromRGBO(0, 51, 153, 1.0),
      rootKeyColor: rootKeyColor ?? const Color.fromRGBO(0, 51, 153, 1.0),
      keyColor: keyColor ?? const Color.fromRGBO(0, 128, 128, 1.0),
    );
  }

  /// Creates a copy of this configuration with some random or confused properties.
  TomlViewerConfig createConfusedCopy() {
    final random = Random();

    return TomlViewerConfig(
      expandMode: random.nextBool(),
      valueColor: _randomizeColor(valueColor, random),
      typeTextColor: _randomizeColor(typeTextColor, random),
      symbolColor: _randomizeColor(symbolColor, random),
      nonRootKeyColor: _randomizeColor(nonRootKeyColor, random),
      rootKeyColor: _randomizeColor(rootKeyColor, random),
      keyColor: _randomizeColor(keyColor, random),
    );
  }

  Color _randomizeColor(Color baseColor, Random random) {
    final r = _randomizeChannel(baseColor.red, random);
    final g = _randomizeChannel(baseColor.green, random);
    final b = _randomizeChannel(baseColor.blue, random);
    return Color.fromARGB(255, r, g, b);
  }

  int _randomizeChannel(int channel, Random random) {
    final delta = random.nextInt(51) - 25;
    return (channel + delta).clamp(0, 255);
  }
}
