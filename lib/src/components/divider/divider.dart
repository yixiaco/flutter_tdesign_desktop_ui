import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TDivider extends StatelessWidget {
  const TDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var fontSize = theme.size.sizeOf(
      small: ThemeDataConstant.fontSizeS,
      medium: ThemeDataConstant.fontSizeBase,
      large: ThemeDataConstant.fontSizeL,
    );

    var d = 1 / MediaQuery.of(context).devicePixelRatio;
    return CustomPaint(
      size: Size(d, fontSize * 0.9),
      painter: MyCustomPainter(),
    );

    // return SizedBox(
    //   width: 1,
    //   height: fontSize * 0.9,
    //   child: Center(
    //     child: Container(
    //       width: 1,
    //       margin: EdgeInsetsDirectional.only(top: 10, bottom: 0),
    //       decoration: BoxDecoration(
    //         border: Border(
    //           left: Divider.createBorderSide(context, color: Colors.black, width: 1),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class MyCustomPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..isAntiAlias = false
      ..strokeWidth = size.width;
    var path = Path();
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
    // canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}