import 'package:flutter/material.dart';
import 'package:toml_viewer/toml_viewer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: TomlView(
                assetFilePath: 'assets/test.toml',
                config: TomlViewerConfig.copyWith(expandMode: false)),
          ),
        ),
      ),
    );
  }
}
