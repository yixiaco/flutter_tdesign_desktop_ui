import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 告警示例
class TAlertExample extends StatelessWidget {
  const TAlertExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        const TAlert(
          theme: TAlertTheme.success,
          message: Text('这是一条成功的消息提示'),
          showClose: true,
          maxSize: true,
        ),
        TAlert(
          theme: TAlertTheme.info,
          title: const Text('这是一条普通的消息提示'),
          message: const Text('这是与普通的消息提示相关的文字辅助说明'),
          operation: GestureDetector(
            onTap: () {
              print('相关操作');
            },
            child: const Text('相关操作'),
          ),
        ),
        const TAlert(
          theme: TAlertTheme.warning,
          message: Text('这是一条警示信息'),
        ),
        const TAlert(
          theme: TAlertTheme.error,
          message: Text('高危操作/出错信息提示'),
        ),
      ],
    );
  }
}
