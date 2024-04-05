import 'package:flutter/material.dart';
import 'package:toml/toml.dart';

import 'toml_array_viewer.dart';

class TomlObjectViewer extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool notRoot;

  const TomlObjectViewer(this.data, {super.key, this.notRoot = false});

  @override
  State<StatefulWidget> createState() => TomlObjectViewerState();
}

class TomlObjectViewerState extends State<TomlObjectViewer> {
  late Map<String, bool> openFlag;

  @override
  void initState() {
    super.initState();
    openFlag = {
      for (final entry in widget.data.entries)
        if (isExpandable(entry.value)) entry.key: true
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notRoot) {
      return Container(
        padding: const EdgeInsets.only(left: 14.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: _getList()),
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getList());
  }

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
                                : Colors.purple.shade900),
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

  static Widget getValueWidget(dynamic content) {
    var style = TextStyle(color: Colors.red.shade800);
    if (content == null) {
      return Expanded(
          child: Text(
        'undefined',
        style: style,
      ));
    } else if (content is int) {
      return Expanded(
          child: Text(
        content.toString(),
        style: style,
      ));
    } else if (content is String) {
      return Expanded(
          child: Text(
        '"$content"',
        style: style,
      ));
    } else if (content is bool) {
      return Expanded(
          child: Text(
        content.toString(),
        style: style,
      ));
    } else if (content is double) {
      return Expanded(
          child: Text(
        content.toString(),
        style: style,
      ));
    } else if (content is TomlLocalDate) {
      return Expanded(
          child: Text(
        content.toString(),
        style: style,
      ));
    } else if (content is TomlLocalDateTime) {
      return Expanded(
          child: Text(
        content.toString(),
        style: style,
      ));
    } else if (content is TomlDateTime) {
      return Expanded(
          child: Text(
        content.toString(),
        style: style,
      ));
    } else if (content is List) {
      if (content.isEmpty) {
        return const Text(
          'Array[0]',
          style: TextStyle(color: Colors.grey),
        );
      } else {
        return Text(
          'Array of ${TomlObjectViewerState.getTypeName(content)}[${content.length}]',
          style: const TextStyle(color: Colors.grey),
        );
      }
    }
    return const Text(
      'Table',
      style: TextStyle(color: Colors.grey),
    );
  }

  static bool isInkWell(dynamic content) {
    if (content == null ||
        content is int ||
        content is String ||
        content is bool ||
        content is double) {
      return false;
    } else if (content is List) {
      return content.isNotEmpty;
    }
    return true;
  }

  static bool isExpandable(dynamic value) {
    return isExtensible(value) || _isList(value);
  }

  static bool isExtensible(dynamic value) {
    return value is Map;
  }

  static bool _isList(dynamic value) {
    return value is List && value.isNotEmpty;
  }

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

  static Widget getContentWidget(String key, dynamic value) {
    if (value is List) {
      return TomlArrayViewer(value, key, notRoot: true);
    } else {
      return TomlObjectViewer(value, notRoot: true);
    }
  }
}
