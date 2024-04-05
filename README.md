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


# Bugs or Requests

If you come across any difficulties, don't hesitate to open an [issue](https://github.com/sudhi001/toml_viewer/issues) on GitHub. If you believe that the library lacks a particular feature, please create a [ticket](https://github.com/sudhi001/toml_viewer/issues) on GitHub, and I'll investigate it. Additionally, I welcome pull requests if you would like to contribute to the project.

# Developer Information

## Project Contributors

This project is actively developed and maintained by a dedicated team of contributors. If you have any questions, suggestions, or issues related to the project, feel free to reach out to any of our team members listed below.

### Lead Developer

- **Name:** Sudhi S
- **GitHub:** [sudhi001](https://github.com/sudhi001)
- **Email:** devsudhi@icloud.com


### Contributors

We'd like to extend our gratitude to all the open-source contributors who have helped improve this project. Your contributions are greatly appreciated.

## How to Contribute

We welcome contributions from the community to help improve this project. If you're interested in contributing, please follow these guidelines:

Before submitting a Pull Request, please make sure to:

- Follow the project's coding style and guidelines.
- Write clear and concise commit messages.
- Test your changes thoroughly.
- Update documentation if necessary.

## Bug Reports and Feature Requests

If you encounter any bugs or have ideas for new features, please feel free to open an issue on GitHub. We appreciate your feedback and will do our best to address any concerns promptly.

