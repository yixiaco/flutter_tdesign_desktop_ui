import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class InputExample extends StatelessWidget {
  const InputExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TInputTheme(
      data: const TInputThemeData(size: TComponentSize.medium),
      child: Column(
        children: const [
          TInput(
            status: TInputStatus.success,
            placeholder: 'brand',
            disabled: true,
          ),
          SizedBox(height: 8),
          TInput(
            status: TInputStatus.defaultStatus,
            placeholder: 'brand',
            maxLength: 5,
          ),
          SizedBox(height: 8),
          TInput(
            status: TInputStatus.success,
            placeholder: 'success',
            tips: '校验通过文本提示',
            maxLength: 5,
          ),
          SizedBox(height: 8),
          TInput(
            status: TInputStatus.warning,
            placeholder: 'warning',
            tips: '校验不通过文本提示',
            maxLength: 5,
          ),
          SizedBox(height: 8),
          TInput(
            label: '价格：',
            initialValue: '错误状态',
            status: TInputStatus.error,
            placeholder: 'error',
            tips: '校验存在严重问题文本提示',
            maxLength: 5,
          ),
          SizedBox(height: 8),
          TInput(
            type: TInputType.password,
            placeholder: '密码框',
            label: '价格：',
            maxLength: 10,
          ),
        ],
      ),
    );
  }
}
