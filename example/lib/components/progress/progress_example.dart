import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TProgressExample extends StatefulWidget {
  const TProgressExample({Key? key}) : super(key: key);

  @override
  State<TProgressExample> createState() => _TProgressExampleState();
}

class _TProgressExampleState extends State<TProgressExample> {
  double percentage1 = 0;
  double percentage2 = 0;
  double percentage3 = 0;
  Timer? _timer;

  @override
  void initState() {
    Random random = Random();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        percentage1 += 10;
        percentage2 = random.nextInt(101).toDouble();
        percentage3 = random.nextInt(101).toDouble();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TSingleChildScrollView(
      child: TSpace(
        direction: Axis.vertical,
        children: [
          const TSingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TSpace(
              mainAxisSize: MainAxisSize.max,
              children: [
                TProgress(percentage: 100, theme: TProgressTheme.circle),
                TProgress(percentage: 30, theme: TProgressTheme.circle),
                TProgress(percentage: 50, theme: TProgressTheme.circle, label: Text('75Day'), status: TProgressStatus.success),
                TProgress(percentage: 50, theme: TProgressTheme.circle, status: TProgressStatus.warning),
                TProgress(percentage: 50, theme: TProgressTheme.circle, status: TProgressStatus.error),
                TProgress(
                  percentage: 0,
                  color: [Color.fromRGBO(0, 82, 217, 1), Color(0xFF00A870)],
                  theme: TProgressTheme.circle,
                ),
                TProgress(
                  percentage: 50,
                  color: [Color.fromRGBO(0, 82, 217, 1), Color(0xFF00A870)],
                  theme: TProgressTheme.circle,
                ),
                TProgress(
                  percentage: 100,
                  color: [Color.fromRGBO(0, 82, 217, 1), Color(0xFF00A870)],
                  theme: TProgressTheme.circle,
                ),
              ],
            ),
          ),
          const TProgress(percentage: 0),
          TProgress(percentage: percentage2, showLabel: false),
          TProgress(percentage: percentage3, status: TProgressStatus.success),
          TProgress(percentage: percentage1, status: TProgressStatus.warning),
          TProgress(percentage: percentage2, status: TProgressStatus.error),
          TProgress(
            color: const [Color.fromRGBO(0, 82, 217, 1), Color(0xFF00A870)],
            percentage: percentage3,
          ),
          TProgress(percentage: percentage1, theme: TProgressTheme.plump),
          TProgress(percentage: percentage2, status: TProgressStatus.success, theme: TProgressTheme.plump),
          TProgress(percentage: percentage3, status: TProgressStatus.warning, theme: TProgressTheme.plump),
          TProgress(percentage: percentage1, status: TProgressStatus.error, theme: TProgressTheme.plump),
        ],
      ),
    );
  }
}
