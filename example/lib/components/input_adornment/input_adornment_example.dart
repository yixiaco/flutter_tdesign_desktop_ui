import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TInputAdornmentExample extends StatefulWidget {
  const TInputAdornmentExample({Key? key}) : super(key: key);

  @override
  State<TInputAdornmentExample> createState() => _TInputAdornmentExampleState();
}

class _TInputAdornmentExampleState extends State<TInputAdornmentExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: const TSpace(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TInputAdornment(
            prepend: Text('https://'),
            child: TInput(),
          ),
          TInputAdornment(
            append: Text('.com'),
            child: TInput(),
          ),
          TInputAdornment(
            prepend: Text('https://'),
            append: Text('.com'),
            child: TInput(),
          ),
        ],
      ),
    );
  }
}
