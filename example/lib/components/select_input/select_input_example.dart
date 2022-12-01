import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 筛选器输入框示例代码
class TSelectInputExample extends StatefulWidget {
  const TSelectInputExample({super.key});

  @override
  State<TSelectInputExample> createState() => _TSelectInputExampleState();
}

class _TSelectInputExampleState extends State<TSelectInputExample> {
  SelectInputValue? _singleValue;
  late List<SelectInputValue> _multipleValue;
  late TPopupVisible _multiplePopupVisible;
  late TPopupVisible _singlePopupVisible;
  late List<SelectInputValue> options;
  FocusNode singleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _multiplePopupVisible = TPopupVisible();
    _singlePopupVisible = TPopupVisible();
    _multipleValue = [];
    options = [
      const SelectInputValue(label: 'tdesign-vue', value: 1),
      const SelectInputValue(label: 'tdesign-react', value: 2),
      const SelectInputValue(label: 'tdesign-miniprogram', value: 3),
      const SelectInputValue(label: 'tdesign-angular', value: 4),
      const SelectInputValue(label: 'tdesign-mobile-vue', value: 5),
      const SelectInputValue(label: 'tdesign-mobile-react', value: 6),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _multiplePopupVisible.dispose();
    _singlePopupVisible.dispose();
    singleFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TSelectInput<SelectInputValue>(
          autoWidth: true,
          value: _singleValue,
          focusNode: singleFocusNode,
          // allowInput: true,
          clearable: true,
          suffixIcon: const Icon(TIcons.chevronDown),
          popupStyle: const TPopupStyle(constraints: BoxConstraints(maxHeight: 280)),
          popupVisible: _singlePopupVisible,
          singleValueDisplay: (value) => value != null ? '${value.label} Student' : '',
          onClear: () {
            setState(() {
              _singleValue = null;
            });
          },
          panel: TSingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: TSpace(
              spacing: 2,
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(options.length, (index) {
                return TButton(
                  variant: TButtonVariant.text,
                  child: Text(options[index].label),
                  onPressed: () {
                    setState(() {
                      _singleValue = options[index];
                    });
                    singleFocusNode.unfocus();
                    _singlePopupVisible.value = false;
                  },
                );
              }),
            ),
          ),
        ),
        SizedBox(
          width: 350,
          child: TSelectInput(
            value: _multipleValue,
            // autoWidth: true,
            multiple: true,
            allowInput: true,
            // readonly: true,
            clearable: true,
            popupVisible: _multiplePopupVisible,
            suffixIcon: const Icon(TIcons.chevronDown),
            onTagChange: (value, context) {
              if (context.trigger == TagInputTriggerSource.clear || context.trigger == TagInputTriggerSource.reset) {
                setState(() {
                  _multipleValue.clear();
                });
              }
              if (TagInputTriggerSource.tagRemove == context.trigger ||
                  TagInputTriggerSource.backspace == context.trigger) {
                setState(() {
                  _multipleValue.removeAt(context.index!);
                });
              }
              if (TagInputTriggerSource.enter == context.trigger) {
                setState(() {
                  var inputValue = SelectInputValue(label: context.item!, value: context.item!);
                  options.add(inputValue);
                  _multipleValue.add(inputValue);
                });
              }
            },
            popupStyle: const TPopupStyle(constraints: BoxConstraints(maxHeight: 280)),
            panel: TSingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TSpace(
                spacing: 2,
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(options.length, (index) {
                  return TButton(
                    variant: TButtonVariant.text,
                    child: Text(options[index].label),
                    onPressed: () {
                      setState(() {
                        _multipleValue.add(options[index]);
                      });
                    },
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
