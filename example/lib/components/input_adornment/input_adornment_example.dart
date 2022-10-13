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
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return TSpace(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 200,maxWidth: 300,maxHeight: 200),
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
            minLines: 1,
            maxLines: 3,
            placeholder: '请输入',
            border: MaterialStatePropertyAll(BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(6),
            )),
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 6, vertical: 4)),
            prefix: MaterialStatePropertyAll(Text('prefix')),
            suffix: MaterialStatePropertyAll(Text('suffix')),
            tips: MaterialStatePropertyAll(Text('tips')),
            placeholderStyle: MaterialStatePropertyAll(TextStyle(
              color: Colors.black12,
              fontSize: 16,
              // overflow: TextOverflow.ellipsis,
            )),
            textAlign: TextAlign.end,
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
  }
}
