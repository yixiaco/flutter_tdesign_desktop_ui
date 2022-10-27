import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 栅格示例
class GridExample extends StatelessWidget {
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TRow(
      gutter: const TGutter.only(xs: 5, sm: 10, md: 15, lg: 20),
      runGutter: const TGutter.all(10),
      children: [
        TCol(
          span: const TColSpan.span(3),
          offset: const TColSpan.span(3),
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('data1'),
          ),
        ),
        TCol(
          span: const TColSpan.span(3),
          offset: const TColSpan.span(3),
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('data2'),
          ),
        ),
        TCol(
          span: const TColSpan.span(3),
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('data3'),
          ),
        ),
        TCol(
          span: const TColSpan.span(3),
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('data4'),
          ),
        ),
        TCol(
          span: const TColSpan.span(3),
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('data5'),
          ),
        ),
      ],
    );
  }
}
