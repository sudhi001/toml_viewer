import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toml/toml.dart';
import 'package:toml_viewer/toml_object_veiwer.dart';
import 'package:toml_viewer/toml_viewer_config.dart';

/// A widget for displaying TOML (Tom's Obvious, Minimal Language) content.
///
/// This widget can be used to display TOML content either from an asset file
/// or directly from a string. It parses the TOML content and presents it using
/// the [TomlObjectViewer] widget.
class TomlView extends StatelessWidget {
  /// Creates a [TomlView] widget.
  ///
  /// Either [assetFilePath] or [content] should be provided. If both are provided,
  /// [assetFilePath] will take precedence.
  const TomlView({super.key, this.assetFilePath, this.content, this.config});

  /// The path of the asset file containing the TOML content.
  ///
  /// If this is provided, TOML content will be read from the asset file.
  final String? assetFilePath;

  /// The TOML content as a string.
  ///
  /// If this is provided, TOML content will be read from the provided string.
  final String? content;

  final TomlViewerConfig? config;

  @override
  Widget build(BuildContext context) {
    final effectiveConfig = config ?? TomlViewerConfig();
    if (assetFilePath != null) {
      // If asset file path is provided, read TOML content from the asset file.
      return FutureBuilder<String>(
        future: rootBundle.loadString(assetFilePath!),
        builder: (context, snapshot) {
          final text = snapshot.data;
          if (text == null) {
            // Display a loading indicator if content is not yet loaded.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = TomlDocument.parse(text).toMap();
          // Display TOML content using TomlObjectViewer widget.
          return SingleChildScrollView(
            child: TomlObjectViewer(
              documents,
              notRoot: false,
              config: effectiveConfig,
            ),
          );
        },
      );
    } else if (content != null) {
      // If content is provided directly, parse and display it.
      final documents = TomlDocument.parse(content!).toMap();
      // Display TOML content using TomlObjectViewer widget.
      return SingleChildScrollView(
        child: TomlObjectViewer(
          documents,
          notRoot: false,
          config: effectiveConfig,
        ),
      );
    } else {
      // If neither assetFilePath nor content is provided, display an error message.
      return const Center(
        child: Text("Invalid Option"),
      );
    }
  }
}
