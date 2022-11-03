import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// Select 选择器
/// 用于收纳大量选项的信息录入类组件。
class TSelect extends StatefulWidget {
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
  final FutureOr<bool> Function(String filterWords, TSelectOption option)? filter;

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
  final List<TOption> options;

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
  State<TSelect> createState() => _TSelectState();
}

class _TSelectState extends State<TSelect> {
  TPopupVisible? _popupVisible;

  /// 浮层控制器
  TPopupVisible get effectivePopupVisible => widget.popupVisible ?? (_popupVisible ??= TPopupVisible());

  /// 选中的选项
  late List<TOption?> _selectOptions;
  TextEditingController? _textController;

  /// 文本控制器
  TextEditingController get effectiveTextController =>
      widget.textController ?? (_textController ??= TextEditingController());
  late TextEditingController _filterTextController;

  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  /// 当前值
  dynamic _value;

  /// 内部格式化的值
  dynamic get _innerValue {
    if (widget.valueType == TSelectValueType.value) {
      return _value;
    }
    if (widget.multiple) {
      return (_value as List).map((e) => (e as TSelectOption).value).toList();
    }
    return (_value as TSelectOption?)?.value;
  }

  /// 可过滤
  bool get _filterable => widget.filterable || widget.filter != null;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.defaultValue;
    _filterTextController = TextEditingController();
    _syncSelectOptions();
  }

  @override
  void didUpdateWidget(covariant TSelect oldWidget) {
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
    if (widget.multiple) {
      _selectOptions = (_innerValue as List).map((e) => optionMap[e]).toList();
    } else {
      if (_innerValue == null) {
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
    _textController?.dispose();
    _filterTextController.dispose();
    _focusNode?.dispose();
    _searchDebounceTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    dynamic value;
    String placeholder = widget.placeholder ?? GlobalTDesignLocalizations.of(context).selectPlaceholder;
    if (widget.multiple) {
      value = _selectOptions.mapIndexed((index, e) {
        var option = e as TSelectOption?;
        if (option == null) {
          // 如果option不存在，返回value值
          var innerValue = _innerValue[index];
          return SelectInputValue(label: innerValue ?? 'undefined', value: innerValue);
        }
        return SelectInputValue(label: option.label, value: option);
      }).toList();
    } else {
      if (_selectOptions.isNotEmpty) {
        var option = _selectOptions[0] as TSelectOption;
        value = SelectInputValue(label: option.label, value: option);
        placeholder = option.label;
      }
    }
    Widget panel = _TSelectPanel(
      selectState: this,
      textController: _filterTextController,
      options: widget.options,
      filterable: widget.filterable || widget.filter != null,
      onClick: _handleClick,
      loading: widget.loading,
      size: widget.size ?? theme.size,
      max: widget.max,
      multiple: widget.multiple,
      filter: widget.filter,
      empty: widget.empty,
      loadingText: widget.loadingText,
    );
    Widget suffixIcon = AnimatedBuilder(
      animation: effectivePopupVisible,
      builder: (context, child) {
        return TFakeArrow(
          placement: effectivePopupVisible.value ? TFakeArrowPlacement.top : TFakeArrowPlacement.bottom,
        );
      },
    );
    MaterialStateColor backgroundColor = MaterialStateColor.resolveWith((states) {
      if (states.containsAny([MaterialState.hovered, MaterialState.focused])) {
        return colorScheme.bgColorContainerHover;
      }
      if(states.contains(MaterialState.disabled)){
        return colorScheme.bgColorComponentDisabled;
      }
      return Colors.transparent;
    });
    return TInputTheme(
      data: TInputThemeData(
        backgroundColor: widget.borderless ? backgroundColor : null,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return TSelectInput<SelectInputValue>(
            multiple: widget.multiple,
            value: value,
            inputController: effectiveTextController,
            autoWidth: widget.autoWidth,
            autofocus: widget.autofocus,
            focusNode: effectiveFocusNode,
            onPopupVisibleChange: widget.onPopupVisibleChange,
            size: widget.size,
            onClear: _handleClear,
            borderless: widget.borderless,
            loading: widget.loading,
            allowInput: _filterable,
            popupStyle: TPopupStyle(
              padding: EdgeInsets.zero,
              radius: BorderRadius.circular(TVar.borderRadiusMedium),
              shadows: colorScheme.shadow2,
              constraints: const BoxConstraints(maxHeight: _kSelectDropdownMaxHeight),
            ).merge(widget.popupStyle),
            placeholder: placeholder,
            readonly: widget.readonly,
            showArrow: widget.showArrow,
            clearable: widget.clearable,
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffixIcon,
            minCollapsedNum: widget.minCollapsedNum,
            onTagChange: _handleTagChange,
            onMouseleave: widget.onMouseleave,
            onMouseenter: widget.onMouseenter,
            popupVisible: effectivePopupVisible,
            panel: panel,
            onInputChange: (value, trigger) {
              if (effectiveFocusNode.hasFocus) {
                _filterTextController.text = value;
              }
              widget.onInputChange?.call(value, trigger);
              _handleSearch(value);
            },
            onFocus: (value, inputValue, tagInputValue) {
              if (_filterable) {
                if (!widget.multiple) {
                  // 单选
                  effectiveTextController.clear();
                  _filterTextController.clear();
                }
              }
              widget.onFocus?.call(_value);
            },
            onBlur: (value, context) {
              widget.onBlur?.call(_value);
              if (_filterable) {
                if (widget.multiple) {
                  // 多选
                  // 失去焦点时，清空搜索框
                  effectiveTextController.clear();
                }
                _filterTextController.clear();
              }
            },
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
        },
      ),
    );
  }

  Timer? _searchDebounceTimer;

  /// 处理搜索事件
  void _handleSearch(String search) {
    // 去抖
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      _searchDebounceTimer = null;
      widget.onSearch?.call(search);
    });
  }

  /// 处理option点击事件
  void _handleClick(TSelectOption option, bool check) {
    dynamic value = _value;
    var options = List.of(_selectOptions);
    if (widget.multiple) {
      value ??= [];
      var list = List.of(value);
      if (check) {
        if (widget.valueType == TSelectValueType.object) {
          list.add(option);
        } else {
          list.add(option.value);
        }
        options.add(option);
        // 选中后是否清空搜索关键词
        if (!widget.reserveKeyword) {
          effectiveTextController.clear();
        }
      } else {
        var index = _innerValue.indexOf(option.value);
        list.removeAt(index);
        options.removeAt(index);
      }
      value = list;
    } else {
      if (widget.valueType == TSelectValueType.object) {
        value = option;
      } else {
        value = option.value;
      }
      // 先提前移除焦点，选中文本时防止覆盖过滤文本控制器
      effectiveFocusNode.unfocus();
      effectivePopupVisible.value = false;
    }
    var trigger = check ? TSelectValueChangeTrigger.check : TSelectValueChangeTrigger.uncheck;
    widget.onChange?.call(value, TSelectChangeContext(selectedOptions: options, option: option, trigger: trigger));
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
class _TSelectPanel extends StatefulWidget {
  const _TSelectPanel({
    Key? key,
    required this.selectState,
    required this.textController,
    required this.options,
    required this.filterable,
    this.filter,
    required this.size,
    required this.loading,
    this.loadingText,
    this.empty,
    required this.max,
    required this.multiple,
    required this.onClick,
  }) : super(key: key);

  final _TSelectState selectState;

  /// 可编辑文本字段的控制器
  final TextEditingController textController;

  /// 选项
  final List<TOption> options;

  /// 是否可搜索
  final bool filterable;

  /// 自定义过滤方法，用于对现有数据进行搜索过滤，判断是否过滤某一项数据。
  final FutureOr<bool> Function(String filterWords, TSelectOption option)? filter;

  /// 组件大小
  final TComponentSize size;

  /// 是否为加载状态
  final bool loading;

  /// 远程加载时显示的文字，支持自定义。如加上超链接。
  final Widget? loadingText;

  /// 当下拉列表为空时显示的内容。
  final Widget? empty;

  /// 用于控制多选数量，值为 0 则不限制
  final int max;

  /// 是否允许多选
  final bool multiple;

  /// 点击事件
  final void Function(TSelectOption option, bool check) onClick;

  @override
  State<_TSelectPanel> createState() => _TSelectPanelState();
}

class _TSelectPanelState extends State<_TSelectPanel> {
  late String _filterWords;
  Future<List<TOption>>? future;

  @override
  void initState() {
    super.initState();
    _filterWords = widget.textController.text;
    widget.textController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.textController.removeListener(_handleTextChange);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _TSelectPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textController != oldWidget.textController) {
      oldWidget.textController.removeListener(_handleTextChange);
      widget.textController.removeListener(_handleTextChange);
      _handleTextChange();
    }
    if (widget.options != oldWidget.options) {
      _handleTextChange(true);
    }
  }

  /// 文本变更
  void _handleTextChange([bool update = false]) {
    if (_filterWords != widget.textController.text || update) {
      _filterWords = widget.textController.text;
      if (widget.filterable) {
        if (mounted) {
          setState(() {
            // 在迭代中使用过滤选项
            future = _handleFilter(_filterWords, widget.options);
          });
        } else {
          future = _handleFilter(_filterWords, widget.options);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);

    TComponentSize size = widget.size;

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

    if (widget.loading) {
      return _buildLoading(theme);
    }
    if (widget.options.isEmpty) {
      return _buildEmpty(theme);
    }
    return FutureBuilder(
      initialData: widget.options,
      future: future,
      builder: (context, snapshot) {
        var list = snapshot.data!;
        if (list.isEmpty) {
          return _buildEmpty(theme);
        }
        return TSingleChildScrollView(
          child: Padding(
            padding: padding,
            child: FixedCrossFlex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(list.length, (index) {
                var option = list[index];
                bool isFirst = index == 0;
                if (option is TSelectOptionGroup) {
                  return _TOptionGroup(
                    max: widget.max,
                    value: widget.selectState._innerValue,
                    multiple: widget.multiple,
                    optionGroup: option,
                    size: size,
                    onClick: (option, check) {
                      widget.onClick(option, check);
                    },
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: isFirst ? 0 : 2),
                  child: _TOption(
                    max: widget.max,
                    option: option as TSelectOption,
                    multiple: widget.multiple,
                    value: widget.selectState._innerValue,
                    size: size,
                    onClick: (option, check) {
                      widget.onClick(option, check);
                    },
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  /// 处理过滤数据
  Future<List<TOption>> _handleFilter(String filterWords, List<TOption> options) async {
    List<TOption> list = [];
    if (!widget.filterable || widget.textController.text.isEmpty) {
      return options;
    }
    for (var option in options) {
      if (option is TSelectOptionGroup) {
        var filterChildren = await _handleFilter(filterWords, option.children);
        if (filterChildren.isNotEmpty) {
          list.add(option.copyWith(children: filterChildren.cast()));
        }
      } else if (option is TSelectOption) {
        var bool = await (widget.filter ?? _filter).call(filterWords, option);
        if (bool) {
          list.add(option);
        }
      }
    }
    return list;
  }

  /// 处理过滤
  FutureOr<bool> _filter(String filterWords, TSelectOption option) async {
    return option.label.toLowerCase().contains(filterWords.toLowerCase());
  }

  /// 构建加载中
  Widget _buildLoading(TThemeData theme) {
    var colorScheme = theme.colorScheme;
    String text = GlobalTDesignLocalizations.of(context).selectLoadingText;
    Widget? child = widget.loadingText;
    return SizedBox(
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: colorScheme.textColorDisabled),
              child: child ?? Text(text),
            ),
          )
        ],
      ),
    );
  }

  /// 构建空数据
  Widget _buildEmpty(TThemeData theme) {
    var colorScheme = theme.colorScheme;
    String text = GlobalTDesignLocalizations.of(context).selectEmpty;
    Widget? child = widget.empty;
    return SizedBox(
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: colorScheme.textColorDisabled),
              child: child ?? Text(text),
            ),
          )
        ],
      ),
    );
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
