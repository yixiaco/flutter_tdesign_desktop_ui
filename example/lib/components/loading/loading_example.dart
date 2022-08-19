import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TLoadingExample extends StatefulWidget {
  const TLoadingExample({Key? key}) : super(key: key);

  @override
  State<TLoadingExample> createState() => _TLoadingExampleState();
}

class _TLoadingExampleState extends State<TLoadingExample> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        const TLoading(
          text: Text('加载中...'),
        ),
        TLoading(
          loading: loading,
          text: const Text('加载中...'),
          child: const Text('this is loading component\n'
              'this is loading component\n'
              'this is loading component\n'
              'this is loading component\n'
              'this is loading component'),
        ),
        TLoading(
          loading: loading,
          delay: const Duration(milliseconds: 500),
          child: const Text('this is loading component'),
        ),
        TRadioGroup<bool>(
          variant: TRadioVariant.defaultFilled,
          options: [
            TRadioOption(label: const Text('加载中'), value: true),
            TRadioOption(label: const Text('加载完成'), value: false),
          ],
          value: loading,
          onChange: (value) {
            setState(() {
              loading = value!;
            });
          },
        ),
        TButton(
          child: const Text('全屏加载（开启加载2秒后自动归位）'),
          onPressed: () {
            TLoading.showFullLoading(context: context);
            Timer(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
