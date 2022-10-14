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
    return labels
        .map((label) => TCheckboxOption<String>(label: Text(label), value: label, disabled: disabled))
        .toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TCheckboxOption &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          value == other.value &&
          disabled == other.disabled;

  @override
  int get hashCode => label.hashCode ^ value.hashCode ^ disabled.hashCode;
}

/// 多选框组
class TCheckboxGroup<T> extends TFormItemValidate {
  const TCheckboxGroup({
    Key? key,
    this.disabled = false,
    this.max,
    required this.options,
    this.value,
    this.defaultValue = const [],
    String? name,
    this.onChange,
  }) : super(key: key, name: name);

  /// 是否禁用组件
  final bool disabled;

  /// 支持最多选中的数量
  final int? max;

  /// 子元素
  final List<TCheckboxOption<T>> options;

  /// 选中值
  final List<T>? value;

  /// 表单重置时的初始化默认值
  final List<T> defaultValue;

  /// 值变化时触发
  final TCheckboxGroupChange<T>? onChange;

  @override
  TFormItemValidateState<TCheckboxGroup<T>> createState() => TCheckboxGroupState<T>();
}

class TCheckboxGroupState<T> extends TFormItemValidateState<TCheckboxGroup<T>> {
  late List<T> _value;

  @override
  void initState() {
    _value = widget.value ?? widget.defaultValue;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _value.clear();
  }

  @override
  void didUpdateWidget(covariant TCheckboxGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && _value != widget.value) {
      _value = widget.value ?? [];
      formChange();
    }
  }

  /// 根据当前选项值，全选或全不选
  void checkAll() {
    if (widget.options.every((element) => _value.contains(element))) {
      // 全选=>全不选
      widget.onChange?.call(false, null, []);
    } else {
      // 全不选=>全选
      widget.onChange?.call(true, null, widget.options.map((e) => e.value).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    var formDisabled = this.formDisabled;
    List<Widget> box = widget.options
        .map(
          (e) {
            return TCheckbox<T>(
            disabled: formDisabled || widget.disabled || e.disabled,
            label: e.label,
            value: e.value,
            checked: _value.contains(e.value),
            onChange: (checked, indeterminate, value) {
              List<T>? list;
              if (checked) {
                if (widget.max == null || _value.length < widget.max!) {
                  list = [..._value, e.value];
                }
              } else {
                list = _value.where((element) => element != e.value).toList();
              }
              if (list != null) {
                widget.onChange?.call(checked, e, list);
              }
            },
          );
          },
        )
        .toList();

    return TSpace(
      breakLine: true,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: box,
    );
  }

  @override
  get formItemValue => _value;

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        _value = [];
        break;
      case TFormResetType.initial:
        _value = widget.defaultValue;
        break;
    }
    widget.onChange?.call(false, null, _value);

  }
}
