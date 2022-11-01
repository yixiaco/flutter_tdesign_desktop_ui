import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// Select 选择器
/// 用于收纳大量选项的信息录入类组件。
class TSelect<T extends TOption> extends StatefulWidget {
  const TSelect({
    super.key,
    this.autoWidth = false,
    this.borderless = false,
    this.clearable = false,
    this.collapsedItems,
    this.creatable = false,
    this.disabled = false,
    this.empty,
    this.filter,
    this.filterable = false,
    this.textController,
    this.loading = false,
    this.loadingText,
    this.max = 0,
    this.minCollapsedNum = 0,
    this.multiple = false,
    this.options = const [],
    this.panelBottomContent,
    this.panelTopContent,
    this.placeholder,
    this.popupStyle,
    this.popupVisible,
    this.prefixIcon,
    this.readonly = false,
    this.reserveKeyword = false,
    this.scroll,
    this.showArrow = true,
    this.size,
    this.status,
    this.tips,
    this.value,
    this.defaultValue,
    this.valueType = TSelectValueType.value,
    this.singleValueDisplay,
    this.multipleValueDisplay,
    this.onBlur,
    this.onClear,
    this.onCreate,
    this.onEnter,
    this.onChange,
    this.onFocus,
    this.onInputChange,
    this.onMouseenter,
    this.onMouseleave,
    this.onPopupVisibleChange,
    this.onRemove,
    this.onSearch,
    this.focusNode,
    this.autofocus = false,
    this.tagTheme = TTagTheme.defaultTheme,
    this.tagVariant = TTagVariant.dark,
    this.textAlign = TextAlign.left,
    this.excessTagsDisplayType = TTagExcessTagsDisplayType.breakLine,
    this.onOpen,
    this.onClose,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 150),
    this.destroyOnClose = false,
    this.trigger,
    this.placement,
    this.label,
  }) : assert(!multiple || multiple && value is List);

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 无边框模式
  final bool borderless;

  /// 是否可以清空选项
  final bool clearable;

  /// 多选情况下，用于设置折叠项内容，默认为 +N。如果需要悬浮就显示其他内容，可以使用 collapsedItems 自定义
  final TSelectInputCollapsedItemsCallback<TSelectOption>? collapsedItems;

  /// 是否允许用户创建新条目，需配合 filterable 使用
  final bool creatable;

  /// 是否禁用组件
  final bool disabled;

  /// 当下拉列表为空时显示的内容。
  final Widget? empty;

  /// 自定义过滤方法，用于对现有数据进行搜索过滤，判断是否过滤某一项数据。
  final FutureOr<bool> Function(String filterWords, T option)? filter;

  /// 是否可搜索
  final bool filterable;

  /// 输入框的控制器
  final TextEditingController? textController;

  /// 是否为加载状态
  final bool loading;

  /// 远程加载时显示的文字，支持自定义。如加上超链接。
  final Widget? loadingText;

  /// 用于控制多选数量，值为 0 则不限制
  final int max;

  /// 最小折叠数量，用于多选情况下折叠选中项，超出该数值的选中项折叠。值为 0 则表示不折叠
  final int minCollapsedNum;

  /// 是否允许多选
  final bool multiple;

  /// 数据化配置选项内容。
  final List<T> options;

  /// 面板内的底部内容。
  final Widget? panelBottomContent;

  /// 面板内的顶部内容。
  final Widget? panelTopContent;

  /// 占位符
  final String? placeholder;

  /// 浮层样式
  final TPopupStyle? popupStyle;

  /// 是否显示下拉框。
  final TPopupVisible? popupVisible;

  /// 组件前置图标。
  final Widget? prefixIcon;

  /// 只读状态，值为真会隐藏输入框，且无法打开下拉框
  final bool readonly;

  /// 多选且可搜索时，是否在选中一个选项后保留当前的搜索关键词
  final bool reserveKeyword;

  /// 懒加载和虚拟滚动。为保证组件收益最大化，当数据量小于阈值 scroll.threshold 时，无论虚拟滚动的配置是否存在，组件内部都不会开启虚拟滚动，scroll.threshold 默认为 100
  final TSelectScroll? scroll;

  /// 是否显示右侧箭头，默认显示
  final bool showArrow;

  /// 组件尺寸
  final TComponentSize? size;

  /// 输入框状态
  final TInputStatus? status;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式。
  final Widget? tips;

  /// {@template tdesign.components.select.value}
  /// 选中值
  /// [value],多选时为List<dynamic>,单选时为dynamic
  /// {@endtemplate}
  final dynamic value;

  /// 选中值。非受控属性
  final dynamic defaultValue;

  /// 用于控制选中值的类型。假设数据选项为：[{ label: '姓名', value: 'name' }]，value 表示值仅返回数据选项中的 value， object 表示值返回全部数据。
  /// 可选项：value/object
  final TSelectValueType valueType;

  /// 自定义值呈现的全部内容
  final String Function(TSelectOption? value)? singleValueDisplay;

  /// 自定义值呈现的全部内容，参数为所有标签的值。
  final List<Widget> Function(List<TSelectOption> value, void Function(int index, TSelectOption item) onClose)?
      multipleValueDisplay;

  /// 失去焦点时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value)? onBlur;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 当选择新创建的条目时触发
  final void Function(String value)? onCreate;

  /// 按键按下 Enter 时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value, String inputValue)? onEnter;

  /// 聚焦时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value)? onFocus;

  /// 输入框值发生变化时触发，context.trigger 表示触发输入框值变化的来源：文本输入触发、清除按钮触发等
  final void Function(String value, InputValueChangeContext trigger)? onInputChange;

  /// 进入输入框时触发
  final PointerEnterEventListener? onMouseenter;

  /// 离开输入框时触发
  final PointerExitEventListener? onMouseleave;

  /// 下拉框显示或隐藏时触发。
  final void Function(bool visible)? onPopupVisibleChange;

  /// 多选模式下，选中数据被移除时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value, TOption? data)? onRemove;

  /// 输入值变化时，触发搜索事件。主要用于远程搜索新数据
  final void Function(String filterWords)? onSearch;

  /// 选中值变化时触发。
  /// context.trigger 表示触发变化的来源；
  /// context.selectedOptions 表示选中值的完整对象，数组长度一定和 value 相同；
  /// context.option 表示当前操作的选项，不一定存在。
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value, TSelectChangeContext changeContext)? onChange;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  /// 标签主题
  final TTagTheme tagTheme;

  /// 标签风格变体
  final TTagVariant tagVariant;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 标签超出时的呈现方式，有两种：横向滚动显示 和 换行显示
  final TTagExcessTagsDisplayType excessTagsDisplayType;

  /// 浮层出现位置
  final TPopupPlacement? placement;

  /// 触发浮层出现的方式
  final TPopupTrigger? trigger;

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

  /// 左侧文本
  final Widget? label;

  @override
  State<TSelect<T>> createState() => _TSelectState<T>();
}

class _TSelectState<T extends TOption> extends State<TSelect<T>> {
  TPopupVisible? _popupVisible;

  TPopupVisible get effectivePopupVisible => widget.popupVisible ?? (_popupVisible ??= TPopupVisible());

  late List<TOption?> _selectOptions;

  dynamic _value;

  dynamic get _innerValue {
    if (widget.valueType == TSelectValueType.value) {
      return _value;
    }
    if (widget.multiple) {
      return (_value as List).map((e) => (e as TSelectOption).value).toList();
    }
    return (_value as TSelectOption?)?.value;
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.defaultValue;
    _syncSelectOptions();
  }

  @override
  void didUpdateWidget(covariant TSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.multiple != oldWidget.multiple || widget.valueType != oldWidget.valueType) {
      _value = widget.value;
      _syncSelectOptions();
    } else if (widget.multiple) {
      if (!(widget.value as List).contentEquals(_value)) {
        _value = widget.value;
        _syncSelectOptions();
      }
    } else if (widget.value != _value) {
      _value = widget.value;
      _syncSelectOptions();
    }
  }

  /// 将值同步为option
  void _syncSelectOptions() {
    var selectOptions = _search(_innerValue, widget.options);
    var optionMap = selectOptions.associateBy((element) => (element as TSelectOption).value);
    if(widget.multiple) {
      _selectOptions = (_innerValue as List).map((e) => optionMap[e]).toList();
    } else {
      if(_innerValue == null) {
        _selectOptions = [];
      } else {
        _selectOptions = [optionMap[_innerValue]];
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _selectOptions.clear();
    _popupVisible?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    dynamic value;
    if (widget.multiple) {
      value = _selectOptions.map((e) {
        var option = e as TSelectOption?;
        return SelectInputValue(label: option?.label ?? 'undefined', value: option);
      }).toList();
    } else {
      if (_selectOptions.isNotEmpty) {
        var option = _selectOptions[0] as TSelectOption;
        value = SelectInputValue(label: option.label, value: option);
      }
    }
    return TSelectInput<SelectInputValue>(
      multiple: widget.multiple,
      value: value,
      autoWidth: widget.autoWidth,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onPopupVisibleChange: widget.onPopupVisibleChange,
      size: widget.size,
      onClear: _handleClear,
      borderless: widget.borderless,
      loading: widget.loading,
      allowInput: widget.filterable,
      popupStyle: TPopupStyle(
        padding: EdgeInsets.zero,
        radius: BorderRadius.circular(TVar.borderRadiusMedium),
        shadows: colorScheme.shadow2,
        constraints: const BoxConstraints(maxHeight: _kSelectDropdownMaxHeight),
      ).merge(widget.popupStyle),
      placeholder: widget.placeholder ?? GlobalTDesignLocalizations.of(context).selectPlaceholder,
      readonly: widget.readonly,
      showArrow: widget.showArrow,
      clearable: widget.clearable,
      prefixIcon: widget.prefixIcon,
      suffixIcon: AnimatedBuilder(
        animation: effectivePopupVisible,
        builder: (context, child) {
          return TFakeArrow(
            placement: effectivePopupVisible.value ? TFakeArrowPlacement.top : TFakeArrowPlacement.bottom,
          );
        },
      ),
      minCollapsedNum: widget.minCollapsedNum,
      onTagChange: _handleTagChange,
      onMouseleave: widget.onMouseleave,
      onMouseenter: widget.onMouseenter,
      popupVisible: effectivePopupVisible,
      panel: _TSelectPanel(selectState: this),
      onInputChange: widget.onInputChange,
      onFocus: (value, inputValue, tagInputValue) => widget.onFocus?.call(_value),
      onBlur: (value, context) => widget.onBlur?.call(_value),
      onEnter: (value, inputValue) => widget.onEnter?.call(_value, inputValue),
      tagTheme: widget.tagTheme,
      tagVariant: widget.tagVariant,
      textAlign: widget.textAlign,
      label: widget.label,
      disabled: widget.disabled,
      status: widget.status,
      excessTagsDisplayType: widget.excessTagsDisplayType,
      tips: widget.tips,
      trigger: widget.trigger,
      placement: widget.placement,
      destroyOnClose: widget.destroyOnClose,
      onClose: widget.onClose,
      onOpen: widget.onOpen,
      hideDuration: widget.hideDuration,
      showDuration: widget.showDuration,
      inputController: widget.textController,
      collapsedItems: widget.collapsedItems != null
          ? (value, collapsedTags, count) {
              var valueList = value.map((e) => e.value as TSelectOption).toList();
              var collapsedTagsList = collapsedTags.map((e) => e.value as TSelectOption).toList();
              return widget.collapsedItems!(valueList, collapsedTagsList, count);
            }
          : null,
      singleValueDisplay: widget.singleValueDisplay != null
          ? (value) => widget.singleValueDisplay!.call(value?.value as TSelectOption?)
          : null,
      multipleValueDisplay: widget.singleValueDisplay != null
          ? (value, onClose) {
              var list = value.map((e) => e.value as TSelectOption).toList();
              return widget.multipleValueDisplay!.call(list, (index, item) {
                onClose(index, SelectInputValue(label: item.label, value: item));
              });
            }
          : null,
    );
  }

  /// 处理标签变更--多选
  void _handleTagChange(List<SelectInputValue> value, TagInputChangeContext context) {
    if (TagInputTriggerSource.tagRemove == context.trigger || TagInputTriggerSource.backspace == context.trigger) {
      var list = List.of(_value);
      var options = List.of(_selectOptions);
      var option = options[context.index!];
      var currentValue = list[context.index!];
      list.removeAt(context.index!);
      options.removeAt(context.index!);
      TSelectValueChangeTrigger trigger;
      if (TagInputTriggerSource.tagRemove == context.trigger) {
        trigger = TSelectValueChangeTrigger.tagRemove;
      } else {
        trigger = TSelectValueChangeTrigger.backspace;
      }
      widget.onRemove?.call(currentValue, option);
      widget.onChange?.call(list, TSelectChangeContext(selectedOptions: options, option: option, trigger: trigger));
    }
    if (widget.creatable && TagInputTriggerSource.enter == context.trigger) {
      var list = List.of(_value);
      var options = List.of(_selectOptions);
      if (widget.max > 0 && list.length < widget.max) {
        var inputValue = TSelectOption(label: context.item!, value: context.item!);
        if (widget.valueType == TSelectValueType.object) {
          list.add(inputValue);
        } else {
          list.add(context.item!);
        }
        options.add(inputValue);
        widget.onChange?.call(
          list,
          TSelectChangeContext(
            selectedOptions: options,
            option: inputValue,
            trigger: TSelectValueChangeTrigger.check,
          ),
        );
        widget.onCreate?.call(context.item!);
      }
    }
  }

  /// 处理清理请求
  void _handleClear() {
    var changeContext = const TSelectChangeContext(
      selectedOptions: [],
      option: null,
      trigger: TSelectValueChangeTrigger.clear,
    );
    if (widget.multiple) {
      widget.onChange?.call([], changeContext);
    } else {
      widget.onChange?.call(null, changeContext);
    }
    widget.onClear?.call();
  }

  /// 搜索选项中的[TSelectOption]对象
  List<TSelectOption> _getSelectOptions(List<TOption> options) {
    return options.flatMap<TSelectOption>((element) {
      if (element is TSelectOptionGroup) {
        return _getSelectOptions(element.children.cast());
      }
      return [element as TSelectOption];
    }).toList();
  }

  /// 根据值，获取对应的选项
  List<TOption> _search(dynamic value, List<TOption> options) {
    if (value is List) {
      return value.flatMap<TOption>((element) {
        return _search(element, options);
      }).toList();
    } else {
      var allOptions = _getSelectOptions(options);
      var checkOption = allOptions.firstOrNullWhere((element) => element.value == value);
      return [if (checkOption != null) checkOption];
    }
  }
}

const double _kSelectOptionHeightS = 20;
const double _kSelectOptionHeightDefault = 28;
const double _kSelectOptionHeightL = 36;
const EdgeInsets _kSelectDropdownPaddingS = EdgeInsets.all(4);
const EdgeInsets _kSelectDropdownPadding = EdgeInsets.all(6);
const EdgeInsets _kSelectDropdownPaddingL = EdgeInsets.all(8);
const double _kSelectDropdownMaxHeight = 300;
const EdgeInsets _kSelectOptionPaddingS = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets _kSelectOptionPaddingDefault = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets _kSelectOptionPaddingL = EdgeInsets.symmetric(vertical: 7, horizontal: 12);

/// 面板
class _TSelectPanel<T extends TOption> extends StatelessWidget {
  const _TSelectPanel({Key? key, required this.selectState}) : super(key: key);

  final _TSelectState<T> selectState;

  TSelect<T> get selectWidget => selectState.widget;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    TComponentSize size = selectWidget.size ?? theme.size;

    EdgeInsets padding;
    switch (size) {
      case TComponentSize.small:
        padding = _kSelectDropdownPaddingS;
        break;
      case TComponentSize.medium:
        padding = _kSelectDropdownPadding;
        break;
      case TComponentSize.large:
        padding = _kSelectDropdownPaddingL;
        break;
    }

    if (selectWidget.options.isEmpty || selectWidget.loading) {
      String text;
      if (selectWidget.loading) {
        text = GlobalTDesignLocalizations.of(context).selectLoadingText;
      } else {
        text = GlobalTDesignLocalizations.of(context).selectEmpty;
      }
      return SizedBox(
        height: 32,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: colorScheme.textColorDisabled),
                child: selectWidget.empty ?? Text(text),
              ),
            )
          ],
        ),
      );
    }
    return TSingleChildScrollView(
      child: Padding(
        padding: padding,
        child: FixedCrossFlex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(selectWidget.options.length, (index) {
            var option = selectWidget.options[index];
            bool isFirst = index == 0;
            if (option is TSelectOptionGroup) {
              return _TOptionGroup(
                max: selectWidget.max,
                value: selectState._innerValue,
                multiple: selectWidget.multiple,
                optionGroup: option,
                size: size,
                onClick: (option, check) {
                  _handleClick(option, check);
                },
              );
            }
            return Padding(
              padding: EdgeInsets.only(top: isFirst ? 0 : 2),
              child: _TOption(
                max: selectWidget.max,
                option: option as TSelectOption,
                multiple: selectWidget.multiple,
                value: selectState._innerValue,
                size: size,
                onClick: (option, check) {
                  _handleClick(option, check);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  /// 处理option点击事件
  void _handleClick(TSelectOption option, bool check) {
    dynamic value = selectState._value;
    var options = List.of(selectState._selectOptions);
    if (selectWidget.multiple) {
      value ??= [];
      var list = List.of(value);
      if (check) {
        if (selectWidget.valueType == TSelectValueType.object) {
          list.add(option);
        } else {
          list.add(option.value);
        }
        options.add(option);
      } else {
        var index = selectState._innerValue.indexOf(option.value);
        list.removeAt(index);
        options.removeAt(index);
      }
      value = list;
    } else {
      if (selectWidget.valueType == TSelectValueType.object) {
        value = option;
      } else {
        value = option.value;
      }
      selectState.effectivePopupVisible.value = false;
    }
    var trigger = check ? TSelectValueChangeTrigger.check : TSelectValueChangeTrigger.uncheck;
    selectWidget.onChange?.call(value, TSelectChangeContext(selectedOptions: options, option: option, trigger: trigger));
  }
}

/// 分组
class _TOptionGroup extends StatelessWidget {
  const _TOptionGroup({
    Key? key,
    this.value,
    required this.multiple,
    required this.optionGroup,
    required this.size,
    required this.max,
    this.onClick,
  }) : super(key: key);

  /// 选中的值
  final dynamic value;

  /// 是否多选
  final bool multiple;

  final TSelectOptionGroup optionGroup;

  /// 组件大小
  final TComponentSize size;

  /// 用于控制多选数量，值为 0 则不限制
  final int max;

  /// 点击回调
  final void Function(TSelectOption option, bool check)? onClick;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    double height;
    EdgeInsets groupPadding;
    EdgeInsets optionPadding;
    switch (size) {
      case TComponentSize.small:
        height = _kSelectOptionHeightS;
        groupPadding = _kSelectOptionPaddingS;
        optionPadding = _kSelectDropdownPaddingS;
        break;
      case TComponentSize.medium:
        height = _kSelectOptionHeightDefault;
        groupPadding = _kSelectOptionPaddingDefault;
        optionPadding = _kSelectDropdownPadding;
        break;
      case TComponentSize.large:
        height = _kSelectOptionHeightL;
        groupPadding = _kSelectOptionPaddingL;
        optionPadding = _kSelectDropdownPaddingL;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          padding: groupPadding,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: colorScheme.textColorPlaceholder),
            child: Text(optionGroup.group),
          ),
        ),
        Container(
          padding: optionPadding,
          child: FixedCrossFlex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(optionGroup.children.length, (index) {
              var option = optionGroup.children[index];
              bool isFirst = index == 0;
              return Padding(
                padding: EdgeInsets.only(top: isFirst ? 0 : 2),
                child: _TOption(
                  option: option,
                  max: max,
                  multiple: multiple,
                  value: value,
                  size: size,
                  onClick: onClick,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// 选项
class _TOption extends StatelessWidget {
  const _TOption({
    Key? key,
    required this.option,
    this.value,
    required this.multiple,
    required this.size,
    required this.max,
    this.onClick,
  }) : super(key: key);

  /// 选中的值
  final dynamic value;

  /// 是否多选
  final bool multiple;

  /// 数据化配置选项内容
  final TSelectOption option;

  /// 组件大小
  final TComponentSize size;

  /// 用于控制多选数量，值为 0 则不限制
  final int max;

  /// 点击回调
  final void Function(TSelectOption option, bool check)? onClick;

  bool get disabled {
    if (option.disabled) {
      return true;
    }
    if (!_check && max > 0 && multiple && value.length >= max) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    TComponentSize size = this.size;
    MaterialStateProperty<Color?> labelTextColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.textColorDisabled;
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColor;
      }
      return colorScheme.textColorPrimary;
    });
    MaterialStateProperty<Color?> backgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.bgColorContainerHover.withOpacity(0);
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColorLight;
      }
      if (states.containsAny([MaterialState.focused, MaterialState.hovered, MaterialState.pressed])) {
        return colorScheme.bgColorContainerHover;
      }
      return colorScheme.bgColorContainerHover.withOpacity(0);
    });

    TextStyle textStyle;
    double height;
    switch (size) {
      case TComponentSize.small:
        textStyle = theme.fontData.fontBodySmall;
        height = _kSelectOptionHeightS;
        break;
      case TComponentSize.medium:
        textStyle = theme.fontData.fontBodyMedium;
        height = _kSelectOptionHeightDefault;
        break;
      case TComponentSize.large:
        textStyle = theme.fontData.fontBodyLarge;
        height = _kSelectOptionHeightL;
        break;
    }

    return TRipple(
      disabled: disabled,
      fixedRippleColor: colorScheme.bgColorContainerActive,
      backgroundColor: backgroundColor,
      selected: _check,
      animatedDuration: TVar.animDurationBase,
      radius: BorderRadius.circular(TVar.borderRadiusDefault),
      builder: (context, states) {
        Widget label = DefaultTextStyle(
          style: textStyle.merge(TextStyle(
            overflow: TextOverflow.ellipsis,
            color: labelTextColor.resolve(states),
          )),
          child: option.child ?? Text(option.label),
        );
        if (multiple) {
          label = TCheckbox(
            disabled: disabled,
            checked: _check,
            label: label,
            onChange: (checked, indeterminate, value) {
              onClick?.call(option, checked);
            },
          );
        }
        return Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [label],
          ),
        );
      },
      onTap: () {
        onClick?.call(option, !multiple || !_check);
      },
    );
  }

  /// 是否选中
  bool get _check {
    if (value == null) {
      return false;
    }
    if (multiple) {
      return (value as List).any((element) => option.value == element);
    }
    return value == option.value;
  }
}
