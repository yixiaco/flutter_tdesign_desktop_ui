import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return TSpace(
      children: [
        Checkbox(
          value: check,
          onChanged: (value) {
            setState(() {
              check = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          side: BorderSide(width: 1, color: Colors.blue),
          splashRadius: 0,
          tristate: true,
        ),
        Radio(value: 'groupValue', groupValue: 'groupValue', onChanged: (value) {

        },),
        Radio(value: 'groupValue1', groupValue: 'groupValue', onChanged: (value) {

        },)
      ],
    );
  }
}
