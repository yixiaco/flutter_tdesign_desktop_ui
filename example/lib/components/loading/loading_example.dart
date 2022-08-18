import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TLoadingExample extends StatefulWidget {
  const TLoadingExample({Key? key}) : super(key: key);

  @override
  State<TLoadingExample> createState() => _TLoadingExampleState();
}

class _TLoadingExampleState extends State<TLoadingExample> {
  @override
  Widget build(BuildContext context) {
    return const TSpace(
      direction: Axis.vertical,
      children: [
        LinearProgressIndicator(),
        CircularProgressIndicator(),
        TLoading(),
      ],
    );
  }
}
