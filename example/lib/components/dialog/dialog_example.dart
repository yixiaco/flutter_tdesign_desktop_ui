import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 对话框示例
class TDialogExample extends StatelessWidget {
  const TDialogExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TSingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TDialog(
            body: Text('对话框内容'),
          ),
          TDialog(
            theme: TDialogTheme.info,
            headerText: '提示',
            body: Text('对话框内容'),
          ),
          TDialog(
            theme: TDialogTheme.warning,
            headerText: '警告',
            body: Text('对话框内容'),
          ),
          TDialog(
            theme: TDialogTheme.danger,
            headerText: '错误',
            body: Text('对话框内容'),
          ),
          TDialog(
            theme: TDialogTheme.success,
            headerText: '成功',
            body: Text('对话框内容'),
          ),
        ],
      ),
    );
  }
}
