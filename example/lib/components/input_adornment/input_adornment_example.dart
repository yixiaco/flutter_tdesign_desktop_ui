import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TInputAdornmentExample extends StatefulWidget {
  const TInputAdornmentExample({Key? key}) : super(key: key);

  @override
  State<TInputAdornmentExample> createState() => _TInputAdornmentExampleState();
}

class _TInputAdornmentExampleState extends State<TInputAdornmentExample> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return Container(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 300),
        child: TInputBox(
          controller: _controller,
          focusNode: _focusNode,
          style: TextStyle(color: Colors.black,fontSize: 16),
          selectionColor: colorScheme.brandColor8.withOpacity(.7),
          enableInteractiveSelection: true,
          selectionControls: desktopTextSelectionControls,
          cursorColor: Colors.black,
          cursorWidth: 1,
          expands: false,
          forceLine: false,
          maxLines: 1,
          placeholder: 'xxx',
          border: MaterialStatePropertyAll(BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(6),
          )),
          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 6, vertical: 4)),
          prefix: MaterialStatePropertyAll(Text('prefix')),
          suffix: MaterialStatePropertyAll(Text('suffix')),
          // tips: MaterialStatePropertyAll(Text('tips')),
          // textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
