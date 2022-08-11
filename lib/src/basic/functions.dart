import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 表示回调
typedef TCallback = void Function();

/// 代表结果的提供者
typedef TSupplier<T> = T Function();

/// 表示接受单个输入参数且不返回结果的操作
typedef TConsumer<T> = void Function(T t);

/// 表示接受一个参数并产生结果的函数
typedef TFunction<T, R> = R Function(T t);

/// 表示接受两个输入参数且不返回结果的操作
typedef TBiConsumer<T, U> = void Function(T t, U u);

/// 表示接受两个参数并产生结果的函数
typedef TBiFunction<T, U, R> = R Function(T t, U u);

/// 值回调
typedef TValueChange<T> = void Function(T value);

/// 跳转触发
typedef TJumperChange = void Function(TJumperTrigger trigger);

/// 复选框值变化时触发
typedef TCheckValueChange<T> = void Function(bool checked, bool indeterminate, T value);

/// 复选框组值变化时触发
typedef TCheckboxGroupChange<T> = void Function(bool checked, TCheckboxOption<T>? current, List<T> options);

/// 单选框值变化触发
typedef TRadioChange<T> = void Function(bool checked, T? value);

/// 输入事件
typedef TInputKeyEvent = void Function(String text, KeyEvent event);

/// 输入回调
typedef TInputCallBack = void Function(String text);
