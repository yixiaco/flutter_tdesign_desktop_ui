import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class InputExample extends StatelessWidget {
  const InputExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TInputTheme(
      data: TInputThemeData(size: TComponentSize.medium),
      child: TSpace(
        children: [
          TInput(
            status: TInputStatus.success,
            placeholder: 'brand',
            disabled: true,
          ),
          TInput(
            clearable: true,
            status: TInputStatus.defaultStatus,
            placeholder: 'brand',
            maxLength: 5,
          ),
          TInput(
            clearable: true,
            status: TInputStatus.success,
            placeholder: 'success',
            tips: '校验通过文本提示',
            maxLength: 5,
          ),
          TInput(
            clearable: true,
            status: TInputStatus.warning,
            placeholder: 'warning',
            tips: '校验不通过文本提示',
            maxLength: 5,
          ),
          TInput(
            clearable: true,
            label: '价格：',
            initialValue: '错误状态',
            status: TInputStatus.error,
            placeholder: 'error',
            tips: '校验存在严重问题文本提示',
            maxLength: 5,
            suffix: Text('元'),
          ),
          TInput(
            showClearIconOnEmpty: true,
            clearable: true,
            type: TInputType.password,
            placeholder: '密码框',
            label: '价格：',
            maxLength: 10,
            suffix: Text('元'),
            prefixIcon: Icon(TIcons.time),
          ),
        ],
      ),
    );
  }
}
