import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class SpaceExample extends StatelessWidget {
  const SpaceExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TSpace(
      direction: Axis.vertical,
      children: [
        TSpace(
          separator: TDivider(),
          children: [
            TButton(variant: TButtonVariant.text, child: Text('1')),
            TButton(variant: TButtonVariant.text, child: Text('2')),
            TButton(variant: TButtonVariant.text, child: Text('3')),
            TButton(variant: TButtonVariant.text, child: Text('4')),
            TButton(variant: TButtonVariant.text, child: Text('5')),
            TButton(variant: TButtonVariant.text, child: Text('6')),
          ],
        ),
        TSpace(
          separator: SizedBox(height: 10,child: VerticalDivider(width: 1, color: Colors.black)),
          children: [
            TButton(variant: TButtonVariant.text, child: Text('1')),
            TButton(variant: TButtonVariant.text, child: Text('2')),
            TButton(variant: TButtonVariant.text, child: Text('3')),
            TButton(variant: TButtonVariant.text, child: Text('4')),
            TButton(variant: TButtonVariant.text, child: Text('5')),
            TButton(variant: TButtonVariant.text, child: Text('6')),
          ],
        )
      ],
    );
  }
}
