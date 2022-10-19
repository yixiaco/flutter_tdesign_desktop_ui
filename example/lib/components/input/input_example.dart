import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 输入框示例
class TInputExample extends StatelessWidget {
  const TInputExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TSpace(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
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
          tips: Text('普通文本提示'),
          maxLength: 50,
          showLimitNumber: true,
        ),
        TInput(
          clearable: true,
          status: TInputStatus.success,
          placeholder: 'success',
          tips: Text('校验通过文本提示'),
          maxLength: 50,
          showLimitNumber: true,
        ),
        TInput(
          clearable: true,
          status: TInputStatus.warning,
          placeholder: 'warning',
          tips: Text('校验不通过文本提示'),
          maxLength: 50,
          showLimitNumber: true,
        ),
        TInput(
          clearable: true,
          label: Text('价格:'),
          defaultValue: '错误状态',
          status: TInputStatus.error,
          placeholder: 'error',
          tips: Text('校验存在严重问题文本提示'),
          maxLength: 50,
          showLimitNumber: true,
          suffix: Text('元'),
        ),
        TInput(
          showClearIconOnEmpty: true,
          clearable: true,
          type: TInputType.password,
          placeholder: '密码框',
          label: Text('价格:'),
          maxLength: 10,
          suffix: Text('元'),
          obscuringCharacter: '*',
          showLimitNumber: true,
          prefixIcon: Icon(TIcons.time),
        ),
        TInput(
          showClearIconOnEmpty: true,
          clearable: true,
          prefixLabels: [
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
            TTag(closable: true, child: Text('123456')),
          ],
          suffix: Text('元'),
          prefixIcon: Icon(TIcons.time),
          autoWidth: true,
          tips: Text('自适应宽度的输入框'),
          inputConstraints: BoxConstraints(minWidth: 100),
          breakLine: true,
        ),
      ],
    );
  }
}
