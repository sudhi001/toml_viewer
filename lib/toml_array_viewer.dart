import 'package:flutter/material.dart';
import 'package:toml_viewer/toml_object_veiwer.dart';

class TomlArrayViewer extends StatefulWidget {
  final List<dynamic> data;
  final bool notRoot;
  final String keyname;

  const TomlArrayViewer(
    this.data,
    this.keyname, {
    super.key,
    this.notRoot = false,
  });

  @override
  State<StatefulWidget> createState() => _TomlArrayViewerState();
}

class _TomlArrayViewerState extends State<TomlArrayViewer> {
  late Map<String, bool> openFlag;

  @override
  void initState() {
    super.initState();
    openFlag = {
      for (int i = 0; i < widget.data.length; i++) '${widget.keyname}_$i': true
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
                    child:
                        TomlObjectViewerState.getValueWidget(widget.data[i])),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (openFlag['${widget.keyname}_$i'] ?? false)
          TomlObjectViewerState.getContentWidget(
            widget.keyname,
            widget.data[i],
          ),
      ],
    ];
  }

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
