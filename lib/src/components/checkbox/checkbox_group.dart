import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 多选框组选项
class TCheckboxOption<T> {
  TCheckboxOption({
    required this.label,
    required this.value,
    this.disabled = false,
  });

  /// 标签
  final Widget label;

  /// 值
  final T value;

  /// 是否禁选
  final bool disabled;

  static TCheckboxOption<String> string({required String label, bool disabled = false}) {
    return TCheckboxOption<String>(label: Text(label), value: label, disabled: disabled);
  }

  static List<TCheckboxOption<String>> strings({required List<String> labels, bool disabled = false}) {
    return labels.map((label) => TCheckboxOption<String>(label: Text(label), value: label, disabled: disabled)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TCheckboxOption && runtimeType == other.runtimeType && label == other.label && value == other.value && disabled == other.disabled;

  @override
  int get hashCode => label.hashCode ^ value.hashCode ^ disabled.hashCode;
}

/// 多选框组
class TCheckboxGroup<T> extends StatefulWidget {
  const TCheckboxGroup({
    Key? key,
    this.disabled = false,
    this.max,
    required this.options,
    required this.value,
    this.onChange,
  }) : super(key: key);

  /// 是否禁用组件
  final bool disabled;

  /// 支持最多选中的数量
  final int? max;

  /// 子元素
  final List<TCheckboxOption<T>> options;

  /// 选中值
  final List<T> value;

  /// 值变化时触发
  final TCheckboxGroupChange<T>? onChange;

  @override
  State<TCheckboxGroup<T>> createState() => TCheckboxGroupState<T>();
}

class TCheckboxGroupState<T> extends State<TCheckboxGroup<T>> {
  /// 根据当前选项值，全选或全不选
  void checkAll() {
    if (widget.options.every((element) => widget.value.contains(element))) {
      // 全选=>全不选
      widget.onChange?.call(false, null, []);
    } else {
      // 全不选=>全选
      widget.onChange?.call(true, null, widget.options.map((e) => e.value).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> box = widget.options
        .map(
          (e) => TCheckbox<T>(
            disabled: widget.disabled ? true : e.disabled,
            label: e.label,
            value: e.value,
            checked: widget.value.contains(e.value),
            onChange: (checked, indeterminate, value) {
              if (widget.max == null || widget.value.length < widget.max!) {
                var list = checked ? [...widget.value, e.value] : widget.value.where((element) => element != e.value).toList();
                widget.onChange?.call(checked, e, list);
              }
            },
          ),
        )
        .toList();

    return TSpace(
      breakLine: true,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: box,
    );
  }
}