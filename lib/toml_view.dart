import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toml/toml.dart';
import 'package:toml_viewer/toml_object_veiwer.dart';

class TomlView extends StatelessWidget {
  const TomlView({super.key, this.assetFilePath, this.content});

  final String? assetFilePath;
  final String? content;

  @override
  Widget build(BuildContext context) {
    if (assetFilePath != null) {
      return FutureBuilder<String>(
          future: rootBundle.loadString(assetFilePath!),
          builder: (context, snapshot) {
            final text = snapshot.data;
            if (text == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = TomlDocument.parse(text).toMap();
            return SingleChildScrollView(
              child: TomlObjectViewer(
                documents,
                notRoot: false,
              ),
            );
          });
    }
    if (content != null) {
      final documents = TomlDocument.parse(content!).toMap();
      return SingleChildScrollView(
        child: TomlObjectViewer(
          documents,
          notRoot: false,
        ),
      );
    }
    return const Text("Invalid Option");
  }
}
