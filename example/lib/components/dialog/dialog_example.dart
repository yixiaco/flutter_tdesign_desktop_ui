import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 对话框示例
class TDialogExample extends StatefulWidget {
  const TDialogExample({Key? key}) : super(key: key);

  @override
  State<TDialogExample> createState() => _TDialogExampleState();
}

class _TDialogExampleState extends State<TDialogExample> {
  late TDialogController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TDialogController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TSingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TSpace(
            direction: Axis.horizontal,
            children: [
              TButton(
                child: const Text('打开弹窗'),
                onPressed: () {
                  TRawDialog.dialog(
                    context: context,
                    onOpened: () {
                      print('打开对话框');
                    },
                    onClosed: () {
                      print('关闭对话框');
                    },
                    dialog: const TRawDialog(
                      body: Text('对话框内容'),
                    ),
                  );
                },
              ),
              TButton(
                child: const Text('打开弹窗(嵌入模式)'),
                onPressed: () {
                  _controller.visible = true;
                },
              ),
            ],
          ),
          TDialog(
            controller: _controller,
            body: const Text('对话框内容'),
          ),
          const TRawDialog(
            body: Text('对话框内容'),
          ),
          const TRawDialog(
            theme: TDialogTheme.info,
            headerText: '提示',
            body: Text('对话框内容'),
          ),
          const TRawDialog(
            theme: TDialogTheme.warning,
            headerText: '警告',
            body: Text('对话框内容'),
          ),
          const TRawDialog(
            theme: TDialogTheme.danger,
            headerText: '错误',
            body: Text('对话框内容'),
          ),
          const TRawDialog(
            theme: TDialogTheme.success,
            headerText: '成功',
            body: Text('对话框内容'),
          ),
        ],
      ),
    );
  }
}
