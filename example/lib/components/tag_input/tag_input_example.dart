import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TTagInputExample extends StatefulWidget {
  const TTagInputExample({Key? key}) : super(key: key);

  @override
  State<TTagInputExample> createState() => _TTagInputExampleState();
}

class _TTagInputExampleState extends State<TTagInputExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Wrap(
                    children: [
                      const Text('prefix'),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 155),
                        child: TInputBox(
                          forceLine: false,
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          selectionColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('suffix'),
                Text('suffix'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
