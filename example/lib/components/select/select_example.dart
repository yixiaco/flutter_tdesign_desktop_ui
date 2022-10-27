import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TSelectExample extends StatefulWidget {
  const TSelectExample({super.key});

  @override
  State<TSelectExample> createState() => _TSelectExampleState();
}

class _TSelectExampleState extends State<TSelectExample> {
  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TSelect(),
      ],
    );
  }
}
