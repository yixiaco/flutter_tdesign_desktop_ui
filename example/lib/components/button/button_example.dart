import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 按钮示例
class TButtonExample extends StatelessWidget {
  const TButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TSingleChildScrollView(
      padding: const EdgeInsets.only(right: 16),
      scrollDirection: Axis.vertical,
      child: TSpace(
        direction: Axis.vertical,
        children: [
          TSpace(
            children: [
              TextButton(onPressed: () {}, child: const Text('TextButton')),
              OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
              ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
            ],
          ),
          TSpace(
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
          TSpace(
            children: [
              TButton(onPressed: () {}, loading: true, variant: TButtonVariant.base, child: const Text('确定')),
              TButton(onPressed: () {}, loading: true, variant: TButtonVariant.outline, child: const Text('确定')),
              TButton(onPressed: () {}, loading: true, variant: TButtonVariant.dashed, child: const Text('确定')),
              TButton(onPressed: () {}, loading: true, variant: TButtonVariant.text, child: const Text('确定')),
            ],
          ),
          TSpace(
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
          TSpace(
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
          TSpace(
            children: [
              TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.base, child: const Text('确定')),
              TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.outline, child: const Text('确定')),
              TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.dashed, child: const Text('确定')),
              TButton(onPressed: () {}, ghost: true, loading: true, variant: TButtonVariant.text, child: const Text('确定')),
            ],
          ),
          TSpace(
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
          TSpace(
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
          TSpace(
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
          Container(
            color: Colors.black,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),
            child: TSpace(
              direction: Axis.vertical,
              children: [
                TSpace(
                  children: [
                    TButton(
                      onPressed: () {},
                      variant: TButtonVariant.outline,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
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
                TSpace(
                  children: [
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.primary,
                      variant: TButtonVariant.outline,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.primary,
                      variant: TButtonVariant.dashed,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.primary,
                      variant: TButtonVariant.text,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                  ],
                ),
                TSpace(
                  children: [
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.success,
                      variant: TButtonVariant.outline,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.success,
                      variant: TButtonVariant.dashed,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.success,
                      variant: TButtonVariant.text,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                  ],
                ),
                TSpace(
                  children: [
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.warning,
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
                      themeStyle: TButtonThemeStyle.warning,
                      variant: TButtonVariant.text,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                  ],
                ),
                TSpace(
                  children: [
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.danger,
                      variant: TButtonVariant.outline,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.danger,
                      variant: TButtonVariant.dashed,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                    TButton(
                      onPressed: () {},
                      themeStyle: TButtonThemeStyle.danger,
                      variant: TButtonVariant.text,
                      ghost: true,
                      child: const Text('幽灵按钮'),
                    ),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
