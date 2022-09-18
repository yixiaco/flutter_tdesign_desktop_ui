// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(month) => "${month} 月";

  static String m1(year) => "${year} 年";

  static String m2(month) => "${Intl.select(month, {
            'jan': '1 月',
            'feb': '2 月',
            'mar': '3 月',
            'apr': '4 月',
            'may': '5 月',
            'jun': '6 月',
            'jul': '7 月',
            'aug': '8 月',
            'sep': '9 月',
            'oct': '10 月',
            'nov': '11 月',
            'dec': '12 月',
            'other': ' ',
          })}";

  static String m3(quarters) => "${Intl.select(quarters, {
            'q1': '一季度',
            'q2': '二季度',
            'q3': '三季度',
            'q4': '四季度',
            'other': ' ',
          })}";

  static String m4(week) => "${Intl.select(week, {
            'mon': '一',
            'tue': '二',
            'wed': '三',
            'thu': '四',
            'fri': '五',
            'sat': '六',
            'sun': '日',
            'other': ' ',
          })}";

  static String m5(name) => "${name}数据类型必须是布尔类型";

  static String m6(name) => "请输入正确的${name}";

  static String m7(name, validate) => "${name}只能是${validate}等";

  static String m8(name) => "请输入正确的${name}";

  static String m9(name, validate) => "${name}字符长度必须是 ${validate}";

  static String m10(name, validate) =>
      "${name}字符长度不能超过 ${validate} 个字符，一个中文等于两个字符";

  static String m11(name, validate) =>
      "${name}字符长度不能少于 ${validate} 个字符，一个中文等于两个字符";

  static String m12(name) => "${name}必须是数字";

  static String m13(name) => "请输入正确的${name}";

  static String m14(name) => "${name}必填";

  static String m15(name) => "请输入正确的${name}";

  static String m16(name) => "请输入正确的${name}";

  static String m17(name) => "${name}不符合要求";

  static String m18(size) => "${size} 条/页";

  static String m19(total) => "共 ${total} 项数据";

  static String m20(result, count) => "搜索“${result}”，找到 ${count} 条结果";

  static String m21(checked, total) => "${checked} / ${total} 项";

  static String m22(sizeLimit) => "文件大小不能超过 ${sizeLimit}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertCollapseText": MessageLookupByLibrary.simpleMessage("收起"),
        "alertExpandText": MessageLookupByLibrary.simpleMessage("展开更多"),
        "anchorCopySuccessText": MessageLookupByLibrary.simpleMessage("链接复制成功"),
        "anchorCopyText": MessageLookupByLibrary.simpleMessage("复制链接"),
        "calendarCellMonth": MessageLookupByLibrary.simpleMessage(
            "一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月"),
        "calendarHideWeekend": MessageLookupByLibrary.simpleMessage("隐藏周末"),
        "calendarMonthRadio": MessageLookupByLibrary.simpleMessage("月"),
        "calendarMonthSelection": m0,
        "calendarShowWeekend": MessageLookupByLibrary.simpleMessage("显示周末"),
        "calendarThisMonth": MessageLookupByLibrary.simpleMessage("本月"),
        "calendarToday": MessageLookupByLibrary.simpleMessage("今天"),
        "calendarWeek": MessageLookupByLibrary.simpleMessage("一,二,三,四,五,六,日"),
        "calendarYearRadio": MessageLookupByLibrary.simpleMessage("年"),
        "calendarYearSelection": m1,
        "cascaderEmpty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "cascaderLoadingText": MessageLookupByLibrary.simpleMessage("加载中"),
        "cascaderPlaceholder": MessageLookupByLibrary.simpleMessage("请选择"),
        "colorPickerClearConfirmText":
            MessageLookupByLibrary.simpleMessage("确定清空最近使用的颜色吗？"),
        "colorPickerRecentColorTitle":
            MessageLookupByLibrary.simpleMessage("最近使用颜色"),
        "colorPickerSwatchColorTitle":
            MessageLookupByLibrary.simpleMessage("系统预设颜色"),
        "datePickerConfirm": MessageLookupByLibrary.simpleMessage("确定"),
        "datePickerDayAriaLabel": MessageLookupByLibrary.simpleMessage("日"),
        "datePickerDirection": MessageLookupByLibrary.simpleMessage("ltr"),
        "datePickerFormat": MessageLookupByLibrary.simpleMessage("YYYY-MM-DD"),
        "datePickerMonthAriaLabel": MessageLookupByLibrary.simpleMessage("月"),
        "datePickerMonths": m2,
        "datePickerNextDecade": MessageLookupByLibrary.simpleMessage("下个十年"),
        "datePickerNextMonth": MessageLookupByLibrary.simpleMessage("下个月"),
        "datePickerNextYear": MessageLookupByLibrary.simpleMessage("下一年"),
        "datePickerNow": MessageLookupByLibrary.simpleMessage("当前"),
        "datePickerPlaceholderDate":
            MessageLookupByLibrary.simpleMessage("请选择日期"),
        "datePickerPlaceholderMonth":
            MessageLookupByLibrary.simpleMessage("请选择月份"),
        "datePickerPlaceholderYear":
            MessageLookupByLibrary.simpleMessage("请选择年份"),
        "datePickerPreDecade": MessageLookupByLibrary.simpleMessage("上个十年"),
        "datePickerPreMonth": MessageLookupByLibrary.simpleMessage("上个月"),
        "datePickerPreYear": MessageLookupByLibrary.simpleMessage("上一年"),
        "datePickerQuarters": m3,
        "datePickerRangeSeparator": MessageLookupByLibrary.simpleMessage(" - "),
        "datePickerSelectDate": MessageLookupByLibrary.simpleMessage("选择日期"),
        "datePickerSelectTime": MessageLookupByLibrary.simpleMessage("选择时间"),
        "datePickerWeekAbbreviation": MessageLookupByLibrary.simpleMessage("周"),
        "datePickerWeekdays": m4,
        "datePickerYearAriaLabel": MessageLookupByLibrary.simpleMessage("年"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("确认"),
        "drawerCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "drawerConfirm": MessageLookupByLibrary.simpleMessage("确认"),
        "formErrorMessageBoolean": m5,
        "formErrorMessageDate": m6,
        "formErrorMessageEnum": m7,
        "formErrorMessageIdcard": m8,
        "formErrorMessageLen": m9,
        "formErrorMessageMax": m10,
        "formErrorMessageMin": m11,
        "formErrorMessageNumber": m12,
        "formErrorMessagePattern": m13,
        "formErrorMessageRequired": m14,
        "formErrorMessageTelnumber": m15,
        "formErrorMessageUrl": m16,
        "formErrorMessageValidator": m17,
        "inputPlaceholder": MessageLookupByLibrary.simpleMessage("请输入"),
        "listLoadingMoreText": MessageLookupByLibrary.simpleMessage("点击加载更多"),
        "listLoadingText": MessageLookupByLibrary.simpleMessage("正在加载中，请稍等"),
        "paginationItemsPerPage": m18,
        "paginationJumpTo": MessageLookupByLibrary.simpleMessage("跳至"),
        "paginationPage": MessageLookupByLibrary.simpleMessage("页"),
        "paginationTotal": m19,
        "popconfirmCancelContent": MessageLookupByLibrary.simpleMessage("取消"),
        "popconfirmConfirmContent": MessageLookupByLibrary.simpleMessage("确定"),
        "selectEmpty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "selectLoadingText": MessageLookupByLibrary.simpleMessage("加载中"),
        "selectPlaceholder": MessageLookupByLibrary.simpleMessage("请选择"),
        "tableCancelText": MessageLookupByLibrary.simpleMessage("取消"),
        "tableClearFilterResultButtonText":
            MessageLookupByLibrary.simpleMessage("清空筛选"),
        "tableColumnConfigButtonText":
            MessageLookupByLibrary.simpleMessage("列配置"),
        "tableColumnConfigDescriptionText":
            MessageLookupByLibrary.simpleMessage("请选择需要在表格中显示的数据列"),
        "tableColumnConfigTitleText":
            MessageLookupByLibrary.simpleMessage("表格列配置"),
        "tableConfirmText": MessageLookupByLibrary.simpleMessage("确认"),
        "tableEmpty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "tableFilterInputPlaceholder":
            MessageLookupByLibrary.simpleMessage("请输入内容（无默认值）"),
        "tableLoadingMoreText": MessageLookupByLibrary.simpleMessage("点击加载更多"),
        "tableLoadingText": MessageLookupByLibrary.simpleMessage("正在加载中，请稍后"),
        "tableResetText": MessageLookupByLibrary.simpleMessage("重置"),
        "tableSearchResultText": m20,
        "tableSelectAllText": MessageLookupByLibrary.simpleMessage("全选"),
        "tableSortAscendingOperationText":
            MessageLookupByLibrary.simpleMessage("点击升序"),
        "tableSortCancelOperationText":
            MessageLookupByLibrary.simpleMessage("点击取消排序"),
        "tableSortDescendingOperationText":
            MessageLookupByLibrary.simpleMessage("点击降序"),
        "timePickerAnteMeridiem": MessageLookupByLibrary.simpleMessage("上午"),
        "timePickerConfirm": MessageLookupByLibrary.simpleMessage("确定"),
        "timePickerNow": MessageLookupByLibrary.simpleMessage("此刻"),
        "timePickerPlaceholder": MessageLookupByLibrary.simpleMessage("选择时间"),
        "timePickerPostMeridiem": MessageLookupByLibrary.simpleMessage("下午"),
        "transferEmpty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "transferPlaceholder": MessageLookupByLibrary.simpleMessage("请输入关键词搜索"),
        "transferTitle": m21,
        "treeEmpty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "treeSelectEmpty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "treeSelectLoadingText": MessageLookupByLibrary.simpleMessage("加载中"),
        "treeSelectPlaceholder": MessageLookupByLibrary.simpleMessage("请选择"),
        "uploadCancelUploadText": MessageLookupByLibrary.simpleMessage("取消上传"),
        "uploadDraggerClickAndDragText":
            MessageLookupByLibrary.simpleMessage("点击上方“选择文件”或将文件拖拽到此区域"),
        "uploadDraggerDragDropText":
            MessageLookupByLibrary.simpleMessage("释放鼠标"),
        "uploadDraggerDraggingText":
            MessageLookupByLibrary.simpleMessage("拖拽到此区域"),
        "uploadFileFileNameText": MessageLookupByLibrary.simpleMessage("文件名"),
        "uploadFileFileOperationDateText":
            MessageLookupByLibrary.simpleMessage("上传日期"),
        "uploadFileFileOperationText":
            MessageLookupByLibrary.simpleMessage("操作"),
        "uploadFileFileSizeText": MessageLookupByLibrary.simpleMessage("文件大小"),
        "uploadFileFileStatusText": MessageLookupByLibrary.simpleMessage("状态"),
        "uploadProgressFailText": MessageLookupByLibrary.simpleMessage("上传失败"),
        "uploadProgressSuccessText":
            MessageLookupByLibrary.simpleMessage("上传成功"),
        "uploadProgressUploadingText":
            MessageLookupByLibrary.simpleMessage("上传中"),
        "uploadProgressWaitingText":
            MessageLookupByLibrary.simpleMessage("待上传"),
        "uploadSizeLimitMessage": m22,
        "uploadTriggerUploadTextContinueUpload":
            MessageLookupByLibrary.simpleMessage("继续选择"),
        "uploadTriggerUploadTextDelete":
            MessageLookupByLibrary.simpleMessage("删除"),
        "uploadTriggerUploadTextFileInput":
            MessageLookupByLibrary.simpleMessage("选择文件"),
        "uploadTriggerUploadTextImage":
            MessageLookupByLibrary.simpleMessage("点击上传图片"),
        "uploadTriggerUploadTextNormal":
            MessageLookupByLibrary.simpleMessage("点击上传"),
        "uploadTriggerUploadTextReupload":
            MessageLookupByLibrary.simpleMessage("重新选择"),
        "uploadTriggerUploadTextUploading":
            MessageLookupByLibrary.simpleMessage("上传中")
      };
}
