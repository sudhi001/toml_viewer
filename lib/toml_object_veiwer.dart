import 'package:flutter/material.dart';
import 'package:toml/toml.dart';

import 'toml_array_viewer.dart';

/// A StatefulWidget for viewing TOML (Tom's Obvious, Minimal Language) objects.
///
/// This widget is used to display TOML objects in a structured manner. It can display
/// key-value pairs, arrays, and nested tables. It recursively renders nested TOML objects.
class TomlObjectViewer extends StatefulWidget {
  /// The TOML data to be displayed.
  final Map<String, dynamic> data;

  /// A flag indicating whether the object is not the root object.
  ///
  /// If set to true, it adds padding to align nested objects properly.
  final bool notRoot;

  /// Creates a [TomlObjectViewer] widget.
  ///
  /// The [data] parameter contains the TOML data to be displayed.
  /// The [notRoot] parameter indicates whether the object is not the root object.
  const TomlObjectViewer(this.data, {super.key, this.notRoot = false});

  @override
  State<StatefulWidget> createState() => TomlObjectViewerState();
}

/// The state class for [TomlObjectViewer].
class TomlObjectViewerState extends State<TomlObjectViewer> {
  late Map<String, bool> openFlag;

  @override
  void initState() {
    super.initState();
    // Initializes the open flags for expandable entries.
    openFlag = {
      for (final entry in widget.data.entries)
        if (isExpandable(entry.value)) entry.key: true
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notRoot) {
      // If this object is not the root object, add padding for alignment.
      return Container(
        padding: const EdgeInsets.only(left: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getList(),
        ),
      );
    }
    // Otherwise, just render the list.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getList(),
    );
  }

  /// Builds the list of widgets to display the TOML object.
  List<Widget> _getList() {
    return [
      for (final entry in widget.data.entries) ...[
        Padding(
          padding: EdgeInsets.only(left: widget.notRoot ? 14.0 : 0),
          child: InkWell(
            onTap: isExpandable(entry.value)
                ? () {
                    setState(() {
                      openFlag[entry.key] = !(openFlag[entry.key] ?? false);
                    });
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry.key,
                    style: TextStyle(
                      color: entry.value is Map
                          ? Colors.teal.shade700
                          : widget.notRoot
                              ? Colors.blue.shade900
                              : Colors.purple.shade900,
                    ),
                  ),
                  const Text(
                    ' = ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 3),
                  Expanded(child: getValueWidget(entry.value)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (openFlag[entry.key] ?? false)
          getContentWidget(entry.key, entry.value),
      ],
    ];
  }

  /// Determines the appropriate widget to display the value based on its type.
  static Widget getValueWidget(dynamic content) {
    // Determine the style based on the value's type.
    var style = TextStyle(color: Colors.red.shade800);
    if (content == null) {
      return Expanded(
        child: Text(
          'undefined',
          style: style,
        ),
      );
    } else if (content is int ||
        content is String ||
        content is bool ||
        content is double ||
        content is TomlLocalDate ||
        content is TomlLocalDateTime ||
        content is TomlDateTime) {
      return Expanded(
        child: Text(
          content.toString(),
          style: style,
        ),
      );
    } else if (content is List) {
      if (content.isEmpty) {
        return const Text(
          'Array[0]',
          style: TextStyle(color: Colors.grey),
        );
      } else {
        return Text(
          'Array of ${getTypeName(content)}[${content.length}]',
          style: const TextStyle(color: Colors.grey),
        );
      }
    }
    return const Text(
      'Table',
      style: TextStyle(color: Colors.grey),
    );
  }

  /// Determines if the value should be wrapped in an InkWell for expanding/collapsing.
  static bool isInkWell(dynamic content) {
    return content is Map || (content is List && content.isNotEmpty);
  }

  /// Determines if the value is expandable.
  static bool isExpandable(dynamic value) {
    return isExtensible(value) || _isList(value);
  }

  /// Determines if the value is extensible (i.e., a table).
  static bool isExtensible(dynamic value) {
    return value is Map;
  }

  /// Determines if the value is a list.
  static bool _isList(dynamic value) {
    return value is List && value.isNotEmpty;
  }

  /// Returns the type name of the given value.
  static String getTypeName(dynamic value) {
    if (value == null) {
      return 'Object';
    } else if (value is int) {
      return 'int';
    } else if (value is double) {
      return 'double';
    } else if (value is bool) {
      return 'bool';
    } else if (value is String) {
      return 'String';
    } else if (value is List) {
      return 'Table';
    } else if (value is TomlDateTime) {
      return 'DateTime';
    } else if (value is TomlLocalDate) {
      return 'LocalDate';
    } else if (value is TomlLocalDateTime) {
      return 'LocalDateTime';
    } else if (value is TomlLocalTime) {
      return 'LocalTime';
    } else {
      return 'Object';
    }
  }

  /// Returns the appropriate widget for displaying the content based on its type.
  static Widget getContentWidget(String key, dynamic value) {
    if (value is List) {
      return TomlArrayViewer(value, key, notRoot: true);
    } else {
      return TomlObjectViewer(value, notRoot: true);
    }
  }
}
