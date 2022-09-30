import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 对话框示例
class TDialogExample extends StatefulWidget {
  const TDialogExample({Key? key}) : super(key: key);

  @override
  State<TDialogExample> createState() => _TDialogExampleState();
}

class _TDialogExampleState extends State<TDialogExample> {
  late TDialogController _normalController;
  late TDialogController _modalController;
  late TDialogController _modelessController;

  @override
  void initState() {
    super.initState();
    _normalController = TDialogController();
    _modalController = TDialogController();
    _modelessController = TDialogController();
  }

  @override
  void dispose() {
    _normalController.dispose();
    _modalController.dispose();
    _modelessController.dispose();
    super.dispose();
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
                  TDialog.dialog(
                    context: context,
                    onClose: () {
                      print('关闭弹窗');
                    },
                    body: const Text('对话框内容'),
                  );
                },
              ),
              TButton(
                child: const Text('模态对话框'),
                onPressed: () {
                  _modalController.visible = true;
                },
              ),
              TButton(
                child: const Text('非模态对话框'),
                onPressed: () {
                  _modelessController.visible = true;
                },
              ),
              TButton(
                child: const Text('普通弹窗'),
                onPressed: () {
                  _normalController.visible = true;
                },
              ),
            ],
          ),
          TDialog(
            draggable: true,
            controller: _modalController,
            mode: TDialogMode.modal,
            body: const TInput(),
          ),
          TDialog(
            controller: _modelessController,
            mode: TDialogMode.modeless,
            body: const TInput(),
          ),
          TDialog(
            controller: _normalController,
            mode: TDialogMode.normal,
            body: const TInput(),
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
