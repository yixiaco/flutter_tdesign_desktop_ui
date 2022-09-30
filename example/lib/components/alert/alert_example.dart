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
          message: '这是一条成功的消息提示',
          showClose: true,
          maxSize: true,
        ),
        TAlert(
          theme: TAlertTheme.info,
          title: const Text('这是一条普通的消息提示'),
          maxLine: 2,
          message: '''这是折叠的第一条消息
这是折叠的第二条消息
这是折叠的第三条消息
这是折叠的第四条消息
这是折叠的第五条消息
这是折叠的第六条消息''',
          operation: GestureDetector(
            onTap: () {
              print('相关操作');
            },
            child: const Text('相关操作'),
          ),
        ),
        const TAlert(
          theme: TAlertTheme.warning,
          message: '这是一条警示信息',
        ),
        const TAlert(
          theme: TAlertTheme.error,
          message: '高危操作/出错信息提示',
        ),
      ],
    );
  }
}
