import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TTagInputExample extends StatefulWidget {
  const TTagInputExample({super.key});

  @override
  State<TTagInputExample> createState() => _TTagInputExampleState();
}

class _TTagInputExampleState extends State<TTagInputExample> {
  late TTagInputController controller;

  @override
  void initState() {
    controller = TTagInputController(value: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']);
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
          // dragSort: true,
          controller: controller,
          clearable: true,
          collapsedItems: (value, collapsedTags, count) {
            return TTag(child: Text('更多($count)'));
          },
          tagVariant: TTagVariant.light,
        ),
        TTagInput(
          // dragSort: true,
          controller: controller,
          clearable: true,
          excessTagsDisplayType: TTagExcessTagsDisplayType.scroll,
          tagVariant: TTagVariant.light,
        ),
      ],
    );
  }
}
