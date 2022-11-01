import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

typedef TSelectInputCollapsedItemsCallback<T> = Widget Function(List<T> value, List<T> collapsedTags, int count);

/// 筛选器输入框
/// 定义：筛选器通用输入框
class TSelectInput<T extends SelectInputValue> extends StatelessWidget {
  const TSelectInput({
    super.key,
    this.size,
    this.allowInput = false,
    this.autoWidth = false,
    this.borderless = false,
    this.clearable = false,
    this.collapsedItems,
    this.disabled = false,
    this.inputController,
    this.defaultInputValue,
    this.label,
    this.loading = false,
    this.minCollapsedNum = 0,
    this.multiple = false,
    this.panel,
    this.placeholder,
    this.placement,
    this.trigger,
    this.showArrow,
    this.onOpen,
    this.onClose,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 150),
    this.destroyOnClose = false,
    this.popupStyle,
    this.popupVisible,
    this.readonly = false,
    this.status,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.tag,
    this.tips,
    this.tagTheme = TTagTheme.defaultTheme,
    this.tagVariant = TTagVariant.dark,
    this.textAlign = TextAlign.left,
    this.excessTagsDisplayType = TTagExcessTagsDisplayType.breakLine,
    this.dragSort = false,
    this.onDragSort,
    this.value,
    this.singleValueDisplay,
    this.multipleValueDisplay,
    this.onBlur,
    this.onClear,
    this.onEnter,
    this.onFocus,
    this.onInputChange,
    this.onMouseenter,
    this.onMouseleave,
    this.onPopupVisibleChange,
    this.onTagChange,
    this.focusNode,
    this.autofocus = false,
  }) : assert(value == null || multiple && value is List<T> || !multiple && value is T);

  /// 尺寸
  final TComponentSize? size;

  /// 是否允许输入
  final bool allowInput;

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 无边框模式
  final bool borderless;

  /// 是否可清空
  final bool clearable;

  /// 标签过多的情况下，折叠项内容，默认为 `+N`。
  /// 如果需要悬浮就显示其他内容，可以使用 `collapsedItems` 自定义。
  /// `value` 表示所有标签值，`collapsedTags` 表示折叠标签值，`count` 表示总标签数量
  final TSelectInputCollapsedItemsCallback<T>? collapsedItems;

  /// 是否禁用
  final bool disabled;

  /// 输入框的值
  final TextEditingController? inputController;

  /// 输入框的值，非受控属性
  final String? defaultInputValue;

  /// 左侧文本
  final Widget? label;

  /// 是否处于加载状态
  final bool loading;

  /// 最小折叠数量，用于标签数量过多的情况下折叠选中项，超出该数值的选中项折叠。值为 0 则表示不折叠
  final int minCollapsedNum;

  /// 是否为多选模式，默认为单选
  final bool multiple;

  /// 下拉框内容，可完全自定义
  final Widget? panel;

  /// 占位符
  final String? placeholder;

  /// Popup 浮层组件属性
  /// 浮层出现位置
  final TPopupPlacement? placement;

  /// 触发浮层出现的方式
  final TPopupTrigger? trigger;

  /// 是否显示浮层箭头
  final bool? showArrow;

  /// 打开事件
  final TCallback? onOpen;

  /// 关闭事件
  final TCallback? onClose;

  /// hover和focus时，显示的延迟
  final Duration showDuration;

  /// hover和focus时，隐藏的延迟
  final Duration hideDuration;

  /// 是否在关闭浮层时销毁浮层，默认为false.
  /// 因为一般不需要维护浮层内容的状态，这可以显著提升运行速度
  final bool destroyOnClose;

  /// 浮层样式
  final TPopupStyle? popupStyle;

  /// 是否显示下拉框
  final TPopupVisible? popupVisible;

  /// 只读状态，值为真会隐藏输入框，且无法打开下拉框
  final bool readonly;

  /// 输入框状态
  final TInputStatus? status;

  /// 前缀图标
  final Widget? prefixIcon;

  /// 后置图标前的后置内容
  final Widget? suffix;

  /// 组件后置图标
  final Widget? suffixIcon;

  /// 自定义标签的内部内容，每一个标签的当前值。注意和 valueDisplay 区分，valueDisplay 是用来定义全部标签内容，而非某一个标签
  final String Function(int index, T value)? tag;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式
  final Widget? tips;

  /// 透传 Tag 标签组件属性。

  /// 标签主题
  final TTagTheme tagTheme;

  /// 标签风格变体
  final TTagVariant tagVariant;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 标签超出时的呈现方式，有两种：横向滚动显示 和 换行显示
  final TTagExcessTagsDisplayType excessTagsDisplayType;

  /// 拖拽调整标签顺序
  final bool dragSort;

  /// 拖拽排序时触发
  final void Function(TagInputDragSortContext context)? onDragSort;

  /// 全部标签值。值为数组表示多个标签，值为非数组表示单个数值。
  final dynamic value;

  /// 自定义值呈现的全部内容
  final String Function(T? value)? singleValueDisplay;

  /// 自定义值呈现的全部内容，参数为所有标签的值。
  final List<Widget> Function(List<T> value, void Function(int index, T item) onClose)? multipleValueDisplay;

  /// 失去焦点时触发
  /// value: 值为数组表示多个标签，值为非数组表示单个数值。
  final void Function(dynamic value, TSelectInputFocusContext context)? onBlur;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 按键按下 Enter 时触发
  /// value: 值为数组表示多个标签，值为非数组表示单个数值。
  final void Function(dynamic value, String inputValue)? onEnter;

  /// 聚焦时触发
  /// value: 值为数组表示多个标签，值为非数组表示单个数值。
  final void Function(dynamic value, String inputValue, List<String>? tagInputValue)? onFocus;

  /// 输入框值发生变化时触发，context.trigger 表示触发输入框值变化的来源：文本输入触发、清除按钮触发等
  final void Function(String value, InputValueChangeContext trigger)? onInputChange;

  /// 进入输入框时触发
  final PointerEnterEventListener? onMouseenter;

  /// 离开输入框时触发
  final PointerExitEventListener? onMouseleave;

  /// 下拉框显示或隐藏时触发。
  final void Function(bool visible)? onPopupVisibleChange;

  /// 值变化时触发，参数 context.trigger 表示数据变化的触发来源；context.index 指当前变化项的下标；context.item 指当前变化项
  final void Function(List<T> value, TagInputChangeContext context)? onTagChange;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (multiple) {
      child = _buildMultiple();
    } else {
      child = _buildSingle();
    }
    return Semantics(
      button: true,
      enabled: !disabled,
      child: child,
    );
  }

  /// 构建单选组件
  Widget _buildSingle() {
    return TSingleSelectInput<T>(
      size: size,
      allowInput: allowInput,
      disabled: disabled,
      value: value,
      readonly: readonly,
      borderless: borderless,
      autoWidth: autoWidth,
      tips: tips,
      suffix: suffix,
      label: label,
      onBlur: onBlur,
      onFocus: (value, inputValue) {
        onFocus?.call(value, inputValue, null);
      },
      placeholder: placeholder,
      onMouseleave: onMouseleave,
      onMouseenter: onMouseenter,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onClear: onClear,
      clearable: clearable,
      onEnter: onEnter,
      status: status,
      popupStyle: popupStyle,
      textAlign: textAlign,
      defaultInputValue: defaultInputValue,
      destroyOnClose: destroyOnClose,
      hideDuration: hideDuration,
      inputController: inputController,
      loading: loading,
      onClose: onClose,
      onInputChange: onInputChange,
      onOpen: onOpen,
      onPopupVisibleChange: onPopupVisibleChange,
      panel: panel,
      popupVisible: popupVisible,
      showDuration: showDuration,
      valueDisplay: singleValueDisplay,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }

  /// 构建多选组件
  Widget _buildMultiple() {
    return TMultipleSelectInput<T>(
      size: size,
      allowInput: allowInput,
      disabled: disabled,
      value: value,
      readonly: readonly,
      borderless: borderless,
      tagTheme: tagTheme,
      tagVariant: tagVariant,
      autoWidth: autoWidth,
      collapsedItems: collapsedItems,
      minCollapsedNum: minCollapsedNum,
      tips: tips,
      tag: tag,
      prefixIcon: prefixIcon,
      suffix: suffix,
      label: label,
      onBlur: onBlur,
      onFocus: onFocus,
      placeholder: placeholder,
      onMouseleave: onMouseleave,
      onMouseenter: onMouseenter,
      suffixIcon: suffixIcon,
      onClear: onClear,
      clearable: clearable,
      onEnter: onEnter,
      status: status,
      popupStyle: popupStyle,
      textAlign: textAlign,
      defaultInputValue: defaultInputValue,
      destroyOnClose: destroyOnClose,
      hideDuration: hideDuration,
      inputController: inputController,
      loading: loading,
      onClose: onClose,
      onInputChange: onInputChange,
      onOpen: onOpen,
      onPopupVisibleChange: onPopupVisibleChange,
      onTagChange: onTagChange,
      panel: panel,
      popupVisible: popupVisible,
      showDuration: showDuration,
      valueDisplay: multipleValueDisplay,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}
