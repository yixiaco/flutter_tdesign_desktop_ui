import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class SpaceExample extends StatelessWidget {
  const SpaceExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        const TSpace(
          separator: TDivider(
            dashed: true,
            layout: Axis.horizontal,
            align: TDividerAlign.left,
            child: Text('TDesign'),
          ),
          spacing: 0,
          direction: Axis.vertical,
          // crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('1'),
            Text('2'),
            Text('3'),
            Text('4'),
            Text('5'),
            Text('6'),
          ],
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            print(constraints);
            return const TSpace(
              separator: SizedBox(height: 10, child: VerticalDivider(width: 1, color: Colors.black)),
              children: [
                TButton(variant: TButtonVariant.text, child: Text('1')),
                TButton(variant: TButtonVariant.text, child: Text('2')),
                TButton(variant: TButtonVariant.text, child: Text('3')),
                TButton(variant: TButtonVariant.text, child: Text('4')),
                TButton(variant: TButtonVariant.text, child: Text('5')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('6')),
                TButton(variant: TButtonVariant.text, child: Text('7')),
              ],
            );
          },
        ),
      ],
    );
  }
}
