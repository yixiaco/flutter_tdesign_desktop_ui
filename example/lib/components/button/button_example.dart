import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 按钮示例
class ButtonExample extends StatelessWidget {
  const ButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TRow(
        gutter: const TGutter.only(xs: 5, sm: 10, md: 15, lg: 20),
        runGutter: const TGutter.all(10),
        children: [
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TextButton(onPressed: () {}, child: const Text('TextButton')),
                  OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
                  ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                    onPressed: () {},
                    shape: TButtonShape.circle,
                    themeStyle: TButtonThemeStyle.danger,
                    icon: TIcons.cloudUpload,
                    // child: const Text('描边按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    shape: TButtonShape.square,
                    themeStyle: TButtonThemeStyle.danger,
                    icon: TIcons.cloudUpload,
                    // child: const Text('描边按钮'),
                  ),
                  TButton(onPressed: () {}, variant: TButtonVariant.outline, child: const Text('描边按钮')),
                  TButton(onPressed: () {}, variant: TButtonVariant.dashed, child: const Text('虚框按钮')),
                  TButton(onPressed: () {}, variant: TButtonVariant.text, child: const Text('文字按钮')),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(onPressed: () {}, loading: true, variant: TButtonVariant.base, child: const Text('确定')),
                  TButton(onPressed: () {}, loading: true, variant: TButtonVariant.outline, child: const Text('确定')),
                  TButton(onPressed: () {}, loading: true, variant: TButtonVariant.dashed, child: const Text('确定')),
                  TButton(onPressed: () {}, loading: true, variant: TButtonVariant.text, child: const Text('确定')),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                      onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.primary, variant: TButtonVariant.base, child: const Text('确定')),
                  TButton(
                      onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.success, variant: TButtonVariant.base, child: const Text('确定')),
                  TButton(onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.danger, variant: TButtonVariant.base, child: const Text('确定')),
                  TButton(
                      onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.warning, variant: TButtonVariant.base, child: const Text('确定')),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                      onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.primary, variant: TButtonVariant.text, child: const Text('确定')),
                  TButton(
                      onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.success, variant: TButtonVariant.text, child: const Text('确定')),
                  TButton(onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.danger, variant: TButtonVariant.text, child: const Text('确定')),
                  TButton(
                      onPressed: () {}, loading: true, themeStyle: TButtonThemeStyle.warning, variant: TButtonVariant.text, child: const Text('确定')),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.base, child: const Text('确定')),
                  TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.outline, child: const Text('确定')),
                  TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.dashed, child: const Text('确定')),
                  TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.text, child: const Text('确定')),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                    onPressed: () {},
                    ghost: true,
                    loading: true,
                    themeStyle: TButtonThemeStyle.primary,
                    variant: TButtonVariant.text,
                    child: const Text('确定'),
                  ),
                  TButton(
                    onPressed: () {},
                    ghost: true,
                    loading: true,
                    themeStyle: TButtonThemeStyle.success,
                    variant: TButtonVariant.text,
                    child: const Text('确定'),
                  ),
                  TButton(
                    onPressed: () {},
                    ghost: true,
                    loading: true,
                    themeStyle: TButtonThemeStyle.danger,
                    variant: TButtonVariant.text,
                    child: const Text('确定'),
                  ),
                  TButton(
                    onPressed: () {},
                    ghost: true,
                    loading: true,
                    themeStyle: TButtonThemeStyle.warning,
                    variant: TButtonVariant.text,
                    child: const Text('确定'),
                  ),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.primary,
                    child: const Text('填充按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.danger,
                    child: const Text('填充按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.warning,
                    child: const Text('填充按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.success,
                    child: const Text('填充按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.danger,
                    variant: TButtonVariant.outline,
                    child: const Text('描边按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.warning,
                    variant: TButtonVariant.dashed,
                    child: const Text('虚框按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.success,
                    variant: TButtonVariant.text,
                    child: const Text('文字按钮'),
                  ),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                    onPressed: () {},
                    disabled: true,
                    themeStyle: TButtonThemeStyle.primary,
                    child: const Text('填充按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    disabled: true,
                    themeStyle: TButtonThemeStyle.danger,
                    variant: TButtonVariant.outline,
                    child: const Text('描边按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    disabled: true,
                    themeStyle: TButtonThemeStyle.warning,
                    variant: TButtonVariant.dashed,
                    child: const Text('虚框按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    disabled: true,
                    themeStyle: TButtonThemeStyle.success,
                    variant: TButtonVariant.text,
                    child: const Text('文字按钮'),
                  ),
                ],
              ),
            ),
          ),
          TCol(
            span: const TColSpan.span(12),
            child: Container(
              color: Colors.black,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.primary,
                    ghost: true,
                    child: const Text('幽灵按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.danger,
                    variant: TButtonVariant.outline,
                    ghost: true,
                    child: const Text('幽灵按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    themeStyle: TButtonThemeStyle.warning,
                    variant: TButtonVariant.dashed,
                    ghost: true,
                    child: const Text('幽灵按钮'),
                  ),
                  TButton(
                    onPressed: () {},
                    variant: TButtonVariant.text,
                    ghost: true,
                    child: const Text('幽灵按钮'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
