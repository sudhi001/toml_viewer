# TOML Viewer

TOML viewr is to show the TOML file on Flutter UI.


```dart

import 'package:flutter/material.dart';
import 'package:toml_viewer/toml_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: TomlView(assetFilePath: 'assets/test.toml'),
          ),
        ),
      ),
    );
  }
}

```