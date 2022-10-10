import 'package:flutter/cupertino.dart';
import 'package:tdesign_desktop_ui/src/localization.dart';
import 'package:tdesign_desktop_ui/src/util/helper.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_date.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_email.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_url.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_value_empty.dart';

/// 校验规则
class TFormRule {
  /// 内置校验方法，校验值类型是否为布尔类型，示例：TFormRule(boolean: true, message: '数据类型必须是布尔类型')
  final bool? boolean;

  /// 内置校验方法，校验值是否为日期格式，示例：TFormRule(date: true, message: '请输入正确的日期')。
  final bool? date;

  /// [date]的默认参数
  final IsDateOptions dateOptions;

  /// 内置校验方法，校验值是否为邮件格式
  final bool? email;

  /// [email]的参数，校验值是否为邮件格式
  final IsEmailOptions emailOptions;

  /// 内置校验方法，校验值是否属于枚举值中的值
  /// 示例：TFormRule(enums: ['primary', 'info', 'warning'], message: '值只能是 primary/info/warning 中的一种')
  final List<String>? enums;

  /// 内置校验方法，校验值是否为身份证号码，组件校验正则为 /^(\d{18,18}|\d{15,15}|\d{17,17}x)$/i
  /// 示例：TFormRule(idcard: true, message: '请输入正确的身份证号码')
  final bool? idcard;

  /// 内置校验方法，校验值固定长度，如：len: 10 表示值的字符长度只能等于 10 ，中文表示 2 个字符，英文为 1 个字符
  /// 示例：TFormRule(len: 10, message: '内容长度不对')。
  /// 如果希望字母和中文都是同样的长度，示例：TFormRule(validator: (val) => val.length == 10, message: '内容文本长度只能是 10 个字')
  final int? len;

  /// 内置校验方法，校验值最大长度，如：max: 100 表示值最多不能超过 100 个字符，中文表示 2 个字符，英文为 1 个字符。
  /// 示例：TFormRule(max: 10, message: '内容超出')
  /// 如果希望字母和中文都是同样的长度，示例：TFormRule(validator: (val) => val.length >= 10, message: '内容文本长度至少为 10 个字')。
  /// 如果数据类型数字（Number），则自动变为数字大小的比对
  final num? max;

  /// 内置校验方法，校验值最小长度，如：min: 10 表示值最多不能少于 10 个字符，中文表示 2 个字符，英文为 1 个字符。
  /// 示例：TFormRule(min: 10, message: '内容长度不够')。
  /// 如果希望字母和中文都是同样的长度，示例：TFormRule(validator: (val) => val.length >= 10, message: '内容文本长度至少为 10 个字')。
  /// 如果数据类型数字（num），则自动变为数字大小的比对
  final num? min;

  /// 内置校验方法，校验值是否为数字（1.2 、 1e5 都算数字），示例：TFormRule(number: true, message: '请输入数字')
  final bool? number;

  /// 内置校验方法，校验值是否符合正则表达式匹配结果，示例：TFormRule(pattern: RegExp(r'@qq.com'), message: '请输入 QQ 邮箱')
  final RegExp? pattern;

  /// 内置校验方法，校验值是否已经填写。该值为 true，默认显示必填标记，可通过设置 requiredMark: false 隐藏必填标记
  final bool? required;

  /// 内置校验方法，校验值是否为空格。示例：TFormRule(whitespace: true, message: '值不能为空')
  final bool? whitespace;

  /// 内置校验方法，校验值是否为手机号码，校验正则为 /^1[3-9]\d{9}$/
  /// 示例：TFormRule(telnumber: true, message: '请输入正确的手机号码')
  final bool? telnumber;

  /// 校验触发方式。可选项：change/blur
  final TFormRuleTrigger trigger;

  /// 校验未通过时呈现的错误信息类型，有 告警信息提示 和 错误信息提示 等两种。可选项：error/warning
  final TFormRuleType type;

  /// 内置校验方法，校验值是否为网络链接地址
  final bool? url;

  /// [url]的参数，校验值是否为网络链接地址
  final IsURLOptions urlOptions;

  /// 自定义校验规则，
  /// 示例：TFormRule(validator: (val) => val.length > 0, message: '请输入内容')
  final bool Function(dynamic val)? validator;

  /// 校验未通过时呈现的错误信息，值为空则不显示
  final String? message;

  const TFormRule({
    this.boolean,
    this.date,
    this.dateOptions = const IsDateOptions(),
    this.email,
    this.emailOptions = const IsEmailOptions(),
    this.enums,
    this.idcard,
    this.len,
    this.max,
    this.min,
    this.number,
    this.pattern,
    this.required,
    this.whitespace,
    this.telnumber,
    this.trigger = TFormRuleTrigger.change,
    this.type = TFormRuleType.error,
    this.url,
    this.urlOptions = const IsURLOptions(),
    this.validator,
    this.message,
  });
}

/// 校验触发方式
enum TFormRuleTrigger {
  /// 实时检验
  change,

  /// 失去焦点时检验
  blur,

  /// 全部
  all;
}

/// 校验未通过时呈现的错误信息类型
enum TFormRuleType {
  /// 错误信息提示
  error,

  /// 告警信息提示
  warning;
}

class IsDateOptions {
  /// 默认为YYYY/MM/DD
  final String format;

  /// 默认为false. 如果strictMode设置为 true，验证器将拒绝不同于format
  final bool strictMode;

  /// 允许的日期分隔符数组，默认为['/', '-']
  final List<String> delimiters;

  const IsDateOptions({
    this.format = 'YYYY/MM/DD',
    this.strictMode = false,
    this.delimiters = const ['/', '-'],
  });

  /// 转为map参数
  Map toOptions() {
    return {
      'format': format,
      'delimiters': delimiters,
      'strictMode': strictMode,
    };
  }
}

class IsEmailOptions {
  /// 如果allow_display_name设置为 true，验证器也将匹配Display Name <email-address>
  final bool allowDisplayName;

  /// 如果require_display_name设置为 true，验证器将拒绝没有格式的字符串Display Name <email-address>
  final bool requireDisplayName;

  /// 如果allow_utf8_local_part设置为 false，验证器将不允许电子邮件地址的本地部分中有任何非英语 UTF8 字符
  final bool allowUtf8LocalPart;

  /// 如果require_tld设置为 false，则域中没有 TLD 的电子邮件地址也将被匹配
  final bool requireTld;

  /// 如果allow_ip_domain设置为 true，验证器将允许主机部分中的 IP 地址
  final bool allowIpDomain;

  /// 如果domain_specific_validation为真，将启用一些额外的验证，例如，不允许某些语法上有效的电子邮件地址被 GMail 拒绝
  final bool domainSpecificValidation;

  /// 如果blacklisted_chars收到一个字符串，那么验证器将拒绝在名称部分包含字符串中任何字符的电子邮件
  final String blacklistedChars;

  /// 如果ignore_max_length设置为 true，验证器将不会检查电子邮件的标准最大长度
  final bool ignoreMaxLength;

  /// 如果host_blacklist设置为字符串数组并且@符号之后的电子邮件部分与其中定义的字符串之一匹配，则验证失败
  final List<String> hostBlacklist;

  const IsEmailOptions({
    this.allowDisplayName = false,
    this.requireDisplayName = false,
    this.allowUtf8LocalPart = true,
    this.requireTld = true,
    this.allowIpDomain = false,
    this.domainSpecificValidation = false,
    this.blacklistedChars = '',
    this.ignoreMaxLength = false,
    this.hostBlacklist = const [],
  });

  /// 转为map参数
  Map toOptions() {
    return {
      'allow_display_name': allowDisplayName,
      'require_display_name': requireDisplayName,
      'allow_utf8_local_part': allowUtf8LocalPart,
      'require_tld': requireTld,
      'allow_ip_domain': allowIpDomain,
      'blacklisted_chars': blacklistedChars,
      'ignore_max_length': ignoreMaxLength,
      'host_blacklist': hostBlacklist,
      'domain_specific_validation': domainSpecificValidation,
    };
  }
}

class IsURLOptions {
  /// 可以使用此选项修改有效协议
  final List<String> protocols;

  /// 如果设置为 true，如果 URL 中不存在协议，isURL 将返回 false
  final bool requireProtocol;

  /// 如果设置为 false isURL 将不检查 URL 中是否存在主机
  final bool requireHost;

  /// 如果设置为 true，isURL 将检查 URL 中是否存在端口
  final bool requirePort;

  /// isURL 将检查 URL 的协议是否存在于协议选项中。
  final bool requireValidProtocol;

  /// 如果设置为 true 协议相对 URL 将被允许
  final bool allowProtocolRelativeUrls;

  /// 如果设置为 false，如果存在片段，isURL 将返回 false
  final bool allowFragments;

  /// 如果设置为 false，如果存在查询组件，isURL 将返回 false
  final bool allowQueryComponents;

  ///  如果设置为 false isURL 将跳过字符串长度验证（2083 个字符是 IE 最大 URL 长度）
  final bool validateLength;

  const IsURLOptions({
    this.protocols = const ['http', 'https', 'ftp'],
    this.requireProtocol = false,
    this.requireHost = true,
    this.requirePort = false,
    this.requireValidProtocol = true,
    this.allowProtocolRelativeUrls = false,
    this.allowFragments = true,
    this.allowQueryComponents = true,
    this.validateLength = true,
  });

  Map toOptions() {
    return {
      'protocols': protocols,
      'require_protocol': requireProtocol,
      'require_host': requireHost,
      'require_port': requirePort,
      'require_valid_protocol': requireValidProtocol,
      'allow_protocol_relative_urls': allowProtocolRelativeUrls,
      'allow_fragments': allowFragments,
      'allow_query_components': allowQueryComponents,
      'validate_length': validateLength,
    };
  }
}

/// 表单错误信息配置
class TFormErrorMessage {
  /// 布尔类型校验不通过时的表单项显示文案，全局配置默认是：'${name}数据类型必须是布尔类型'
  final String? boolean;

  /// 日期校验规则不通过时的表单项显示文案，全局配置默认是：'请输入正确的${name}'
  final String? date;

  /// 枚举值校验规则不通过时的表单项显示文案，全局配置默认是：${name}只能是${validate}等
  final String? enums;

  /// 身份证号码校验不通过时的表单项显示文案，全局配置默认是：'请输入正确的${name}'
  final String? idcard;

  /// 值长度校验不通过时的表单项显示文案，全局配置默认是：'${name}字符长度必须是 ${validate}'
  final String? len;

  /// 值的长度太长或值本身太大时，校验不通过的表单项显示文案，全局配置默认是：'${name}字符长度不能超过 ${validate} 个字符，一个中文等于两个字符'
  final String? max;

  /// 值的长度太短或值本身太小时，校验不通过的表单项显示文案，全局配置默认是：'${name}字符长度不能少于 ${validate} 个字符，一个中文等于两个字符'
  final String? min;

  /// 数字类型校验不通过时的表单项显示文案，全局配置默认是：'${name}必须是数字'
  final String? number;

  /// 正则表达式校验不通过时的表单项显示文案，全局配置默认是：'请输入正确的${name}'
  final String? pattern;

  /// 没有填写必填项时的表单项显示文案，全局配置默认是：'${name}必填'
  final String? required;

  /// 手机号号码校验不通过时的表单项显示文案，全局配置默认是：'请输入正确的${name}'
  final String? telnumber;

  /// 链接校验规则不通过时的表单项显示文案，全局配置默认是：'请输入正确的${name}'
  final String? url;

  /// 自定义校验规则校验不通过时的表单项显示文案，全局配置默认是：'${name}不符合要求'
  final String? validator;

  const TFormErrorMessage({
    this.boolean,
    this.date,
    this.enums,
    this.idcard,
    this.len,
    this.max,
    this.min,
    this.number,
    this.pattern,
    this.required,
    this.telnumber,
    this.url,
    this.validator,
  });
}

class TFormItemValidateMessage {
  /// 提示消息类型
  final TFormRuleType type;

  /// 消息
  final String? message;

  const TFormItemValidateMessage({
    required this.type,
    this.message,
  });
}

/// 验证结果
class TFormItemValidateResult {
  /// 验证结果是否通过
  final bool validate;

  ///错误消息
  final String? errorMessage;

  /// 提示消息类型
  final TFormRuleType? type;

  const TFormItemValidateResult({
    required this.validate,
    this.errorMessage,
    this.type,
  });
}

/// 表单验证结果
class TFormValidateResult {
  /// 验证结果是否通过
  final bool validate;

  /// 错误消息
  final Map<String, String> errorMessage;

  /// 验证结果列表
  final Map<String, TFormItemValidateResult> validateResult;

  /// 第一条错误消息
  final String? firstMessage;

  const TFormValidateResult({
    required this.validate,
    required this.errorMessage,
    required this.validateResult,
    this.firstMessage,
  });
}

final _validateMap = {
  'date': isDate,
  'url': isURL,
  'email': isEmail,
  'required': (val) => !isValueEmpty(val),
  'whitespace': (val) => !RegExp(r'^\s+$').hasMatch(val) || val == '',
  'boolean': (val) => val is bool,
  'max': (val, num number) => (num.tryParse(val) != null ? val <= number : getCharacterLength(val).length <= number),
  'min': (val, num number) => (num.tryParse(val) != null ? val >= number : getCharacterLength(val).length >= number),
  'len': (val, num number) => getCharacterLength(val).length == number,
  'number': (val) => num.tryParse(val) != null,
  'enum': (val, List<String> strs) => strs.contains(val),
  'idcard': (val) => RegExp(r'^(\d{18}|\d{15}|\d{17}x)$', caseSensitive: false).hasMatch(val),
  'telnumber': (val) => RegExp(r'^1[3-9]\d{9}$').hasMatch(val),
  'pattern': (val, RegExp regexp) => regexp.hasMatch(val),
  // 自定义校验规则，可能是异步校验
  'validator': (val, bool Function(dynamic input) validate) => validate(val),
};

/// 校验器
class Validator {
  /// 字段名称
  final String name;

  /// 需要检验的值
  final dynamic value;

  /// 校验规则
  final List<TFormRule> rules;

  /// 错误模板消息
  final TFormErrorMessage? errorMessage;

  /// 上下文
  final BuildContext context;

  const Validator({
    required this.name,
    required this.value,
    required this.rules,
    this.errorMessage,
    required this.context,
  });

  /// 验证单个规则
  TFormItemValidateResult _validateOneRule(TFormRule rule) {
    bool validate = true;
    String? message = rule.message?.replaceAll(r'${name}', name);
    if (rule.required != null && rule.required!) {
      validate = _validateMap['required']!.call(value);
      message ??= errorMessage?.required?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageRequired(name);
    } else if (rule.validator != null) {
      validate = _validateMap['validator']!.call(value, rule.validator!);
      message ??= errorMessage?.validator?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageValidator(name);
    } else if (value == null) {
      // 非必填选项，值为空，非自定义规则：无需校验，直接返回 true
      validate = true;
    } else if (rule.date != null && rule.date!) {
      validate = _validateMap['date']!.call(value, rule.dateOptions.toOptions());
      message ??= errorMessage?.date?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageDate(name);
    } else if (rule.url != null && rule.url!) {
      validate = _validateMap['url']!.call(value, rule.urlOptions.toOptions());
      message ??= errorMessage?.url?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageUrl(name);
    } else if (rule.email != null && rule.email!) {
      validate = _validateMap['email']!.call(value, rule.emailOptions.toOptions());
    } else if (rule.whitespace != null && rule.whitespace!) {
      validate = _validateMap['whitespace']!.call(value);
    } else if (rule.boolean != null && rule.boolean!) {
      validate = _validateMap['boolean']!.call(value);
      message ??= errorMessage?.boolean?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageBoolean(name);
    } else if (rule.max != null) {
      validate = _validateMap['max']!.call(value, rule.max!);
      message ??= message?.replaceAll(r'${validate}', rule.max!.toString()) ??
          errorMessage?.max?.replaceAll(r'${name}', name).replaceAll(r'${validate}', rule.max!.toString()) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageMax(name, rule.max!);
    } else if (rule.min != null) {
      validate = _validateMap['min']!.call(value, rule.min!);
      message ??= message?.replaceAll(r'${validate}', rule.min!.toString()) ??
          errorMessage?.min?.replaceAll(r'${name}', name).replaceAll(r'${validate}', rule.min!.toString()) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageMin(name, rule.min!);
    } else if (rule.len != null) {
      validate = _validateMap['len']!.call(value, rule.len!);
      message ??= message?.replaceAll(r'${validate}', rule.len!.toString()) ??
          errorMessage?.len?.replaceAll(r'${name}', name).replaceAll(r'${validate}', rule.len!.toString()) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageLen(name, rule.len!);
    } else if (rule.number != null && rule.number!) {
      validate = _validateMap['number']!.call(value);
      message ??= errorMessage?.number?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageNumber(name);
    } else if (rule.enums != null) {
      validate = _validateMap['enum']!.call(value, rule.enums!);
      var join = rule.enums!.join('/');
      message ??= message?.replaceAll(r'${validate}', join) ??
          errorMessage?.enums?.replaceAll(r'${name}', name).replaceAll(r'${validate}', join) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageEnum(name, join);
    } else if (rule.idcard != null && rule.idcard!) {
      validate = _validateMap['idcard']!.call(value);
      message ??= errorMessage?.idcard?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageIdcard(name);
    } else if (rule.telnumber != null && rule.telnumber!) {
      validate = _validateMap['telnumber']!.call(value);
      message ??= errorMessage?.telnumber?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessageTelnumber(name);
    } else if (rule.pattern != null) {
      validate = _validateMap['pattern']!.call(value, rule.pattern!);
      message ??= errorMessage?.pattern?.replaceAll(r'${name}', name) ??
          GlobalTDesignLocalizations.of(context).formErrorMessagePattern(name);
    }
    return TFormItemValidateResult(validate: validate, errorMessage: validate ? null : message, type: rule.type);
  }

  /// 校验
  TFormItemValidateResult validate(TFormRuleTrigger? trigger) {
    trigger ??= TFormRuleTrigger.all;
    var rules = this.rules.where((element) {
      switch (trigger!) {
        case TFormRuleTrigger.change:
          return element.trigger == TFormRuleTrigger.change;
        case TFormRuleTrigger.blur:
          return element.trigger == TFormRuleTrigger.blur;
        case TFormRuleTrigger.all:
          return true;
      }
    });
    for (var rule in rules) {
      var result = _validateOneRule(rule);
      if (!result.validate) {
        return result;
      }
    }
    return const TFormItemValidateResult(validate: true);
  }
}
