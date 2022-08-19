import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TProgressExample extends StatefulWidget {
  const TProgressExample({Key? key}) : super(key: key);

  @override
  State<TProgressExample> createState() => _TProgressExampleState();
}

class _TProgressExampleState extends State<TProgressExample> {
  @override
  Widget build(BuildContext context) {
    return const TSpace(
      direction: Axis.vertical,
      children: [
        TProgress(percentage: 50),
        TProgress(percentage: 50, showLabel: false),
        TProgress(percentage: 50, status: TProgressStatus.success),
        TProgress(percentage: 50, status: TProgressStatus.warning),
        TProgress(percentage: 50, status: TProgressStatus.error),
        TProgress(
          color: [
            Color.fromRGBO(0, 82, 217, 1),
            Color(0xFF00A870),
          ],
          percentage: 50,
        ),
        TProgress(percentage: 50),
        TProgress(percentage: 50, theme: TProgressTheme.plump),
        TProgress(percentage: 50, status: TProgressStatus.success, theme: TProgressTheme.plump),
        TProgress(percentage: 50, status: TProgressStatus.warning, theme: TProgressTheme.plump),
        TProgress(percentage: 50, status: TProgressStatus.error, theme: TProgressTheme.plump),
      ],
    );
  }
}
