import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TSwitchExample extends StatefulWidget {
  const TSwitchExample({Key? key}) : super(key: key);

  @override
  State<TSwitchExample> createState() => _TSwitchExampleState();
}

class _TSwitchExampleState extends State<TSwitchExample> {
  bool value = true;
  String strValue = '是';

  @override
  Widget build(BuildContext context) {
    return TSpace(
      children: [
        TSwitch(
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          checkLabel: const Text('开'),
          uncheckLabel: const Text('关'),
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          checkLabel: const Icon(TIcons.check),
          uncheckLabel: const Icon(TIcons.close),
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          value: value,
          disabled: true,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          disabled: true,
          checkLabel: const Icon(TIcons.check),
          uncheckLabel: const Icon(TIcons.close),
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          disabled: true,
          checkLabel: const Text('开'),
          uncheckLabel: const Text('关'),
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          loading: true,
          checkLabel: const Text('开'),
          uncheckLabel: const Text('关'),
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TSwitch(
          checkLabel: const Text('开'),
          uncheckLabel: const Text('关'),
          checkValue: '是',
          uncheckValue: '否',
          value: strValue,
          onChange: (value) {
            setState(() {
              strValue = value;
            });
          },
        ),
      ],
    );
  }
}
