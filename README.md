# TOML Viewer

A TOML viewer in Flutter is a user interface component that displays the contents of a TOML (Tom's Obvious, Minimal Language) file in a structured and readable format. This viewer typically parses the TOML file and presents its key-value pairs, tables, arrays, and nested structures in a visually appealing manner.

Key features of a TOML viewer in Flutter may include:

1. **Parsing TOML**: The viewer should be capable of parsing TOML files to extract their data for display.

2. **Structured Display**: It organizes the data from the TOML file in a structured manner, preserving hierarchy and relationships between keys and values.

3. **Key-Value Presentation**: Key-value pairs are displayed clearly, with keys and their corresponding values presented together.

4. **Support for Tables and Arrays**: If the TOML file contains tables or arrays, the viewer should appropriately display these structures, allowing users to expand and collapse them as needed.

5. **Color Coding**: Use of color coding to distinguish between different types of data (e.g., strings, integers, booleans) and to improve readability.

6. **Interactive Features**: Ability to interact with the displayed data, such as expanding or collapsing sections, tapping on entries for more information, or performing actions based on user input.

7. **Customization**: Options for customization, such as adjusting font sizes, colors, and themes to suit user preferences.

8. **Error Handling**: Graceful handling of errors in parsing the TOML file, with informative messages or indicators to alert users of any issues.

Overall, a TOML viewer in Flutter aims to provide users with a convenient way to visualize and explore the contents of TOML files directly within their Flutter applications.

```dart

import 'package:flutter/material.dart';
import 'package:toml_viewer/toml_viewer.dart';

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
# Screeshots

<img src="https://github.com/sudhi001/toml_viewer/blob/main/screens/screen1.png?raw=true" width="450">