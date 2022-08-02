import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class InputExample extends StatelessWidget {
  const InputExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TInput(
          status: TInputStatus.defaultStatus,
          placeholder: 'brand',
          disabled: true,
        ),
        SizedBox(height: 8),
        TInput(
          status: TInputStatus.success,
          placeholder: 'success',
        ),
        SizedBox(height: 8),
        TInput(
          status: TInputStatus.warning,
          placeholder: 'warning',
        ),
        SizedBox(height: 8),
        TInput(
          status: TInputStatus.error,
          placeholder: 'error',
        ),
      ],
    );
  }
}
