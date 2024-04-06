import 'package:flutter/material.dart';
import 'package:toml_viewer/toml_object_veiwer.dart';
import 'package:toml_viewer/toml_viewer_config.dart';

/// A StatefulWidget for viewing arrays in TOML (Tom's Obvious, Minimal Language) objects.
///
/// This widget is used to display arrays contained within TOML objects. It provides
/// functionality to expand and collapse individual array elements. It recursively renders
/// nested arrays and tables.
class TomlArrayViewer extends StatefulWidget {
  /// The array data to be displayed.
  final List<dynamic> data;

  /// A flag indicating whether the array is not the root array.
  ///
  /// If set to true, it adds padding to align nested arrays properly.
  final bool notRoot;

  /// The key name of the array in the TOML object.
  final String keyname;

  final TomlViewerConfig config;

  /// Creates a [TomlArrayViewer] widget.
  ///
  /// The [data] parameter contains the array data to be displayed.
  /// The [keyname] parameter specifies the key name of the array in the TOML object.
  /// The [notRoot] parameter indicates whether the array is not the root array.
  const TomlArrayViewer(
    this.data,
    this.keyname, {
    super.key,
    this.notRoot = false,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() => _TomlArrayViewerState();
}

/// The state class for [TomlArrayViewer].
class _TomlArrayViewerState extends State<TomlArrayViewer> {
  late Map<String, bool> openFlag;

  @override
  void initState() {
    super.initState();
    // Initializes the open flags for each array element.
    openFlag = {
      for (int i = 0; i < widget.data.length; i++)
        '${widget.keyname}_$i': widget.config.expandMode
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.notRoot ? 14.0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getList(),
      ),
    );
  }

  /// Builds the list of widgets to display the array elements.
  List<Widget> _getList() {
    return [
      for (int i = 0; i < widget.data.length; i++) ...[
        InkWell(
          onTap: () {
            setState(() {
              final key = '${widget.keyname}_$i';
              openFlag[key] = !(openFlag[key] ?? true);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildEntry(i),
                const Text(
                  ' = ',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: TomlObjectViewerState.getValueWidget(
                      widget.data[i], widget.config),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (openFlag['${widget.keyname}_$i'] ?? false)
          TomlObjectViewerState.getContentWidget(
              widget.keyname, widget.data[i], widget.config),
      ],
    ];
  }

  /// Builds the entry label for the array element.
  Widget _buildEntry(int index) {
    final content = widget.data[index];
    final ex = TomlObjectViewerState.isExtensible(content);
    final ink = TomlObjectViewerState.isInkWell(content);
    if (ex && ink) {
      return Text('${widget.keyname} [$index]',
          style: TextStyle(
            color: widget.notRoot ? Colors.teal : Colors.purple,
          ));
    } else {
      return Text(
        '${widget.keyname} [$index]',
        style: const TextStyle(
          color: Colors.grey,
        ),
      );
    }
  }
}
