import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 筛选器输入框示例代码
class TSelectInputExample extends StatefulWidget {
  const TSelectInputExample({Key? key}) : super(key: key);

  @override
  State<TSelectInputExample> createState() => _TSelectInputExampleState();
}

class _TSelectInputExampleState extends State<TSelectInputExample> {
  late TSelectInputSingleController _controller;
  late TSelectInputMultipleController _multipleController;
  late ValueNotifier<bool> _popupVisible;
  late List<SelectInputValue> options;
  FocusNode singleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _popupVisible = ValueNotifier(false);
    _controller = TSelectInputSingleController();
    _multipleController = TSelectInputMultipleController(value: []);
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
    _controller.dispose();
    _multipleController.dispose();
    _popupVisible.dispose();
    singleFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TSelectInput(
          autoWidth: true,
          controller: _controller,
          focusNode: singleFocusNode,
          allowInput: true,
          clearable: true,
          suffixIcon: const Icon(TIcons.chevronDown),
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
                    _controller.value = options[index];
                    singleFocusNode.unfocus();
                  },
                );
              }),
            ),
          ),
        ),
        SizedBox(
          width: 350,
          child: TSelectInput(
            controller: _multipleController,
            // autoWidth: true,
            multiple: true,
            allowInput: true,
            // readonly: true,
            clearable: true,
            popupVisible: _popupVisible,
            suffixIcon: const Icon(TIcons.chevronDown),
            onTagChange: (value, context) {
              if (context.trigger == TagInputTriggerSource.clear || context.trigger == TagInputTriggerSource.reset) {
                _multipleController.clear();
              }
              if (TagInputTriggerSource.tagRemove == context.trigger ||
                  TagInputTriggerSource.backspace == context.trigger) {
                setState(() {
                  _multipleController.removeAt(context.index!);
                });
              }
              if (TagInputTriggerSource.enter == context.trigger) {
                setState(() {
                  var inputValue = SelectInputValue(label: context.item!, value: context.item!);
                  options.add(inputValue);
                  _multipleController.add(inputValue);
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
                      _multipleController.add(options[index]);
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
