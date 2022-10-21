import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TTagInputExample extends StatefulWidget {
  const TTagInputExample({Key? key}) : super(key: key);

  @override
  State<TTagInputExample> createState() => _TTagInputExampleState();
}

class _TTagInputExampleState extends State<TTagInputExample> {
  late TTagInputController controller;

  @override
  void initState() {
    controller = TTagInputController(value: ['hello', 'world','hello', 'world','hello', 'world','hello', 'world','hello', 'world','hello', 'world']);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TTagInput(
          // disabled: true,
          // autoWidth: true,
          // excessTagsDisplayType: TTagExcessTagsDisplayType.scroll,
          controller: controller,
          clearable: true,
          // max: 5,
          // minCollapsedNum: 2,
          collapsedItems: (collapsedTags, count) {
            return TTag(child: Text('更多($count)'));
          },
          tagTheme: TTagTheme.primary,
          tagVariant: TTagVariant.light,
        ),
      ],
    );
  }
}
