// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `{size} 条/页`
  String paginationItemsPerPage(Object size) {
    return Intl.message(
      '$size 条/页',
      name: 'paginationItemsPerPage',
      desc: '',
      args: [size],
    );
  }

  /// `跳至`
  String get paginationJumpTo {
    return Intl.message(
      '跳至',
      name: 'paginationJumpTo',
      desc: '',
      args: [],
    );
  }

  /// `页`
  String get paginationPage {
    return Intl.message(
      '页',
      name: 'paginationPage',
      desc: '',
      args: [],
    );
  }

  /// `共 {total} 项数据`
  String paginationTotal(Object total) {
    return Intl.message(
      '共 $total 项数据',
      name: 'paginationTotal',
      desc: '',
      args: [total],
    );
  }

  /// `暂无数据`
  String get cascaderEmpty {
    return Intl.message(
      '暂无数据',
      name: 'cascaderEmpty',
      desc: '',
      args: [],
    );
  }

  /// `加载中`
  String get cascaderLoadingText {
    return Intl.message(
      '加载中',
      name: 'cascaderLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `请选择`
  String get cascaderPlaceholder {
    return Intl.message(
      '请选择',
      name: 'cascaderPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `{year} 年`
  String calendarYearSelection(Object year) {
    return Intl.message(
      '$year 年',
      name: 'calendarYearSelection',
      desc: '',
      args: [year],
    );
  }

  /// `{month} 月`
  String calendarMonthSelection(Object month) {
    return Intl.message(
      '$month 月',
      name: 'calendarMonthSelection',
      desc: '',
      args: [month],
    );
  }

  /// `年`
  String get calendarYearRadio {
    return Intl.message(
      '年',
      name: 'calendarYearRadio',
      desc: '',
      args: [],
    );
  }

  /// `月`
  String get calendarMonthRadio {
    return Intl.message(
      '月',
      name: 'calendarMonthRadio',
      desc: '',
      args: [],
    );
  }

  /// `隐藏周末`
  String get calendarHideWeekend {
    return Intl.message(
      '隐藏周末',
      name: 'calendarHideWeekend',
      desc: '',
      args: [],
    );
  }

  /// `显示周末`
  String get calendarShowWeekend {
    return Intl.message(
      '显示周末',
      name: 'calendarShowWeekend',
      desc: '',
      args: [],
    );
  }

  /// `今天`
  String get calendarToday {
    return Intl.message(
      '今天',
      name: 'calendarToday',
      desc: '',
      args: [],
    );
  }

  /// `本月`
  String get calendarThisMonth {
    return Intl.message(
      '本月',
      name: 'calendarThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `一,二,三,四,五,六,日`
  String get calendarWeek {
    return Intl.message(
      '一,二,三,四,五,六,日',
      name: 'calendarWeek',
      desc: '',
      args: [],
    );
  }

  /// `一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月`
  String get calendarCellMonth {
    return Intl.message(
      '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月',
      name: 'calendarCellMonth',
      desc: '',
      args: [],
    );
  }

  /// `{checked} / {total} 项`
  String transferTitle(Object checked, Object total) {
    return Intl.message(
      '$checked / $total 项',
      name: 'transferTitle',
      desc: '',
      args: [checked, total],
    );
  }

  /// `暂无数据`
  String get transferEmpty {
    return Intl.message(
      '暂无数据',
      name: 'transferEmpty',
      desc: '',
      args: [],
    );
  }

  /// `请输入关键词搜索`
  String get transferPlaceholder {
    return Intl.message(
      '请输入关键词搜索',
      name: 'transferPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `此刻`
  String get timePickerNow {
    return Intl.message(
      '此刻',
      name: 'timePickerNow',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get timePickerConfirm {
    return Intl.message(
      '确定',
      name: 'timePickerConfirm',
      desc: '',
      args: [],
    );
  }

  /// `上午`
  String get timePickerAnteMeridiem {
    return Intl.message(
      '上午',
      name: 'timePickerAnteMeridiem',
      desc: '',
      args: [],
    );
  }

  /// `下午`
  String get timePickerPostMeridiem {
    return Intl.message(
      '下午',
      name: 'timePickerPostMeridiem',
      desc: '',
      args: [],
    );
  }

  /// `选择时间`
  String get timePickerPlaceholder {
    return Intl.message(
      '选择时间',
      name: 'timePickerPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get dialogConfirm {
    return Intl.message(
      '确认',
      name: 'dialogConfirm',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get dialogCancel {
    return Intl.message(
      '取消',
      name: 'dialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get drawerConfirm {
    return Intl.message(
      '确认',
      name: 'drawerConfirm',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get drawerCancel {
    return Intl.message(
      '取消',
      name: 'drawerCancel',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get popconfirmConfirmContent {
    return Intl.message(
      '确定',
      name: 'popconfirmConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get popconfirmCancelContent {
    return Intl.message(
      '取消',
      name: 'popconfirmCancelContent',
      desc: '',
      args: [],
    );
  }

  /// `暂无数据`
  String get tableEmpty {
    return Intl.message(
      '暂无数据',
      name: 'tableEmpty',
      desc: '',
      args: [],
    );
  }

  /// `正在加载中，请稍后`
  String get tableLoadingText {
    return Intl.message(
      '正在加载中，请稍后',
      name: 'tableLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `点击加载更多`
  String get tableLoadingMoreText {
    return Intl.message(
      '点击加载更多',
      name: 'tableLoadingMoreText',
      desc: '',
      args: [],
    );
  }

  /// `请输入内容（无默认值）`
  String get tableFilterInputPlaceholder {
    return Intl.message(
      '请输入内容（无默认值）',
      name: 'tableFilterInputPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `点击升序`
  String get tableSortAscendingOperationText {
    return Intl.message(
      '点击升序',
      name: 'tableSortAscendingOperationText',
      desc: '',
      args: [],
    );
  }

  /// `点击取消排序`
  String get tableSortCancelOperationText {
    return Intl.message(
      '点击取消排序',
      name: 'tableSortCancelOperationText',
      desc: '',
      args: [],
    );
  }

  /// `点击降序`
  String get tableSortDescendingOperationText {
    return Intl.message(
      '点击降序',
      name: 'tableSortDescendingOperationText',
      desc: '',
      args: [],
    );
  }

  /// `清空筛选`
  String get tableClearFilterResultButtonText {
    return Intl.message(
      '清空筛选',
      name: 'tableClearFilterResultButtonText',
      desc: '',
      args: [],
    );
  }

  /// `列配置`
  String get tableColumnConfigButtonText {
    return Intl.message(
      '列配置',
      name: 'tableColumnConfigButtonText',
      desc: '',
      args: [],
    );
  }

  /// `表格列配置`
  String get tableColumnConfigTitleText {
    return Intl.message(
      '表格列配置',
      name: 'tableColumnConfigTitleText',
      desc: '',
      args: [],
    );
  }

  /// `请选择需要在表格中显示的数据列`
  String get tableColumnConfigDescriptionText {
    return Intl.message(
      '请选择需要在表格中显示的数据列',
      name: 'tableColumnConfigDescriptionText',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get tableConfirmText {
    return Intl.message(
      '确认',
      name: 'tableConfirmText',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get tableCancelText {
    return Intl.message(
      '取消',
      name: 'tableCancelText',
      desc: '',
      args: [],
    );
  }

  /// `重置`
  String get tableResetText {
    return Intl.message(
      '重置',
      name: 'tableResetText',
      desc: '',
      args: [],
    );
  }

  /// `全选`
  String get tableSelectAllText {
    return Intl.message(
      '全选',
      name: 'tableSelectAllText',
      desc: '',
      args: [],
    );
  }

  /// `搜索“{result}”，找到 {count} 条结果`
  String tableSearchResultText(Object result, Object count) {
    return Intl.message(
      '搜索“$result”，找到 $count 条结果',
      name: 'tableSearchResultText',
      desc: '',
      args: [result, count],
    );
  }

  /// `暂无数据`
  String get selectEmpty {
    return Intl.message(
      '暂无数据',
      name: 'selectEmpty',
      desc: '',
      args: [],
    );
  }

  /// `加载中`
  String get selectLoadingText {
    return Intl.message(
      '加载中',
      name: 'selectLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `请选择`
  String get selectPlaceholder {
    return Intl.message(
      '请选择',
      name: 'selectPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `暂无数据`
  String get treeEmpty {
    return Intl.message(
      '暂无数据',
      name: 'treeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `暂无数据`
  String get treeSelectEmpty {
    return Intl.message(
      '暂无数据',
      name: 'treeSelectEmpty',
      desc: '',
      args: [],
    );
  }

  /// `加载中`
  String get treeSelectLoadingText {
    return Intl.message(
      '加载中',
      name: 'treeSelectLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `请选择`
  String get treeSelectPlaceholder {
    return Intl.message(
      '请选择',
      name: 'treeSelectPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `请选择日期`
  String get datePickerPlaceholderDate {
    return Intl.message(
      '请选择日期',
      name: 'datePickerPlaceholderDate',
      desc: '',
      args: [],
    );
  }

  /// `请选择月份`
  String get datePickerPlaceholderMonth {
    return Intl.message(
      '请选择月份',
      name: 'datePickerPlaceholderMonth',
      desc: '',
      args: [],
    );
  }

  /// `请选择年份`
  String get datePickerPlaceholderYear {
    return Intl.message(
      '请选择年份',
      name: 'datePickerPlaceholderYear',
      desc: '',
      args: [],
    );
  }

  /// `{week, select, mon{一} tue{二} wed{三} thu{四} fri{五} sat{六} sun{日} other{ }}`
  String datePickerWeekdays(Object week) {
    return Intl.select(
      week,
      {
        'mon': '一',
        'tue': '二',
        'wed': '三',
        'thu': '四',
        'fri': '五',
        'sat': '六',
        'sun': '日',
        'other': ' ',
      },
      name: 'datePickerWeekdays',
      desc: '',
      args: [week],
    );
  }

  /// `{month, select, jan{1 月} feb{2 月} mar{3 月} apr{4 月} may{5 月} jun{6 月} jul{7 月} aug{8 月} sep{9 月} oct{10 月} nov{11 月} dec{12 月} other{ }}`
  String datePickerMonths(Object month) {
    return Intl.select(
      month,
      {
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
      },
      name: 'datePickerMonths',
      desc: '',
      args: [month],
    );
  }

  /// `{quarters, select, q1{一季度} q2{二季度} q3{三季度} q4{四季度} other{ }}`
  String datePickerQuarters(Object quarters) {
    return Intl.select(
      quarters,
      {
        'q1': '一季度',
        'q2': '二季度',
        'q3': '三季度',
        'q4': '四季度',
        'other': ' ',
      },
      name: 'datePickerQuarters',
      desc: '',
      args: [quarters],
    );
  }

  /// ` - `
  String get datePickerRangeSeparator {
    return Intl.message(
      ' - ',
      name: 'datePickerRangeSeparator',
      desc: '',
      args: [],
    );
  }

  /// `ltr`
  String get datePickerDirection {
    return Intl.message(
      'ltr',
      name: 'datePickerDirection',
      desc: '',
      args: [],
    );
  }

  /// `YYYY-MM-DD`
  String get datePickerFormat {
    return Intl.message(
      'YYYY-MM-DD',
      name: 'datePickerFormat',
      desc: '',
      args: [],
    );
  }

  /// `日`
  String get datePickerDayAriaLabel {
    return Intl.message(
      '日',
      name: 'datePickerDayAriaLabel',
      desc: '',
      args: [],
    );
  }

  /// `周`
  String get datePickerWeekAbbreviation {
    return Intl.message(
      '周',
      name: 'datePickerWeekAbbreviation',
      desc: '',
      args: [],
    );
  }

  /// `年`
  String get datePickerYearAriaLabel {
    return Intl.message(
      '年',
      name: 'datePickerYearAriaLabel',
      desc: '',
      args: [],
    );
  }

  /// `月`
  String get datePickerMonthAriaLabel {
    return Intl.message(
      '月',
      name: 'datePickerMonthAriaLabel',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get datePickerConfirm {
    return Intl.message(
      '确定',
      name: 'datePickerConfirm',
      desc: '',
      args: [],
    );
  }

  /// `选择时间`
  String get datePickerSelectTime {
    return Intl.message(
      '选择时间',
      name: 'datePickerSelectTime',
      desc: '',
      args: [],
    );
  }

  /// `选择日期`
  String get datePickerSelectDate {
    return Intl.message(
      '选择日期',
      name: 'datePickerSelectDate',
      desc: '',
      args: [],
    );
  }

  /// `下一年`
  String get datePickerNextYear {
    return Intl.message(
      '下一年',
      name: 'datePickerNextYear',
      desc: '',
      args: [],
    );
  }

  /// `上一年`
  String get datePickerPreYear {
    return Intl.message(
      '上一年',
      name: 'datePickerPreYear',
      desc: '',
      args: [],
    );
  }

  /// `下个月`
  String get datePickerNextMonth {
    return Intl.message(
      '下个月',
      name: 'datePickerNextMonth',
      desc: '',
      args: [],
    );
  }

  /// `上个月`
  String get datePickerPreMonth {
    return Intl.message(
      '上个月',
      name: 'datePickerPreMonth',
      desc: '',
      args: [],
    );
  }

  /// `上个十年`
  String get datePickerPreDecade {
    return Intl.message(
      '上个十年',
      name: 'datePickerPreDecade',
      desc: '',
      args: [],
    );
  }

  /// `下个十年`
  String get datePickerNextDecade {
    return Intl.message(
      '下个十年',
      name: 'datePickerNextDecade',
      desc: '',
      args: [],
    );
  }

  /// `当前`
  String get datePickerNow {
    return Intl.message(
      '当前',
      name: 'datePickerNow',
      desc: '',
      args: [],
    );
  }

  /// `文件大小不能超过 {sizeLimit}`
  String uploadSizeLimitMessage(Object sizeLimit) {
    return Intl.message(
      '文件大小不能超过 $sizeLimit',
      name: 'uploadSizeLimitMessage',
      desc: '',
      args: [sizeLimit],
    );
  }

  /// `取消上传`
  String get uploadCancelUploadText {
    return Intl.message(
      '取消上传',
      name: 'uploadCancelUploadText',
      desc: '',
      args: [],
    );
  }

  /// `选择文件`
  String get uploadTriggerUploadTextFileInput {
    return Intl.message(
      '选择文件',
      name: 'uploadTriggerUploadTextFileInput',
      desc: '',
      args: [],
    );
  }

  /// `点击上传图片`
  String get uploadTriggerUploadTextImage {
    return Intl.message(
      '点击上传图片',
      name: 'uploadTriggerUploadTextImage',
      desc: '',
      args: [],
    );
  }

  /// `点击上传`
  String get uploadTriggerUploadTextNormal {
    return Intl.message(
      '点击上传',
      name: 'uploadTriggerUploadTextNormal',
      desc: '',
      args: [],
    );
  }

  /// `重新选择`
  String get uploadTriggerUploadTextReupload {
    return Intl.message(
      '重新选择',
      name: 'uploadTriggerUploadTextReupload',
      desc: '',
      args: [],
    );
  }

  /// `继续选择`
  String get uploadTriggerUploadTextContinueUpload {
    return Intl.message(
      '继续选择',
      name: 'uploadTriggerUploadTextContinueUpload',
      desc: '',
      args: [],
    );
  }

  /// `删除`
  String get uploadTriggerUploadTextDelete {
    return Intl.message(
      '删除',
      name: 'uploadTriggerUploadTextDelete',
      desc: '',
      args: [],
    );
  }

  /// `上传中`
  String get uploadTriggerUploadTextUploading {
    return Intl.message(
      '上传中',
      name: 'uploadTriggerUploadTextUploading',
      desc: '',
      args: [],
    );
  }

  /// `释放鼠标`
  String get uploadDraggerDragDropText {
    return Intl.message(
      '释放鼠标',
      name: 'uploadDraggerDragDropText',
      desc: '',
      args: [],
    );
  }

  /// `拖拽到此区域`
  String get uploadDraggerDraggingText {
    return Intl.message(
      '拖拽到此区域',
      name: 'uploadDraggerDraggingText',
      desc: '',
      args: [],
    );
  }

  /// `点击上方“选择文件”或将文件拖拽到此区域`
  String get uploadDraggerClickAndDragText {
    return Intl.message(
      '点击上方“选择文件”或将文件拖拽到此区域',
      name: 'uploadDraggerClickAndDragText',
      desc: '',
      args: [],
    );
  }

  /// `文件名`
  String get uploadFileFileNameText {
    return Intl.message(
      '文件名',
      name: 'uploadFileFileNameText',
      desc: '',
      args: [],
    );
  }

  /// `文件大小`
  String get uploadFileFileSizeText {
    return Intl.message(
      '文件大小',
      name: 'uploadFileFileSizeText',
      desc: '',
      args: [],
    );
  }

  /// `状态`
  String get uploadFileFileStatusText {
    return Intl.message(
      '状态',
      name: 'uploadFileFileStatusText',
      desc: '',
      args: [],
    );
  }

  /// `操作`
  String get uploadFileFileOperationText {
    return Intl.message(
      '操作',
      name: 'uploadFileFileOperationText',
      desc: '',
      args: [],
    );
  }

  /// `上传日期`
  String get uploadFileFileOperationDateText {
    return Intl.message(
      '上传日期',
      name: 'uploadFileFileOperationDateText',
      desc: '',
      args: [],
    );
  }

  /// `上传中`
  String get uploadProgressUploadingText {
    return Intl.message(
      '上传中',
      name: 'uploadProgressUploadingText',
      desc: '',
      args: [],
    );
  }

  /// `待上传`
  String get uploadProgressWaitingText {
    return Intl.message(
      '待上传',
      name: 'uploadProgressWaitingText',
      desc: '',
      args: [],
    );
  }

  /// `上传失败`
  String get uploadProgressFailText {
    return Intl.message(
      '上传失败',
      name: 'uploadProgressFailText',
      desc: '',
      args: [],
    );
  }

  /// `上传成功`
  String get uploadProgressSuccessText {
    return Intl.message(
      '上传成功',
      name: 'uploadProgressSuccessText',
      desc: '',
      args: [],
    );
  }

  /// `请输入正确的{name}`
  String formErrorMessageDate(Object name) {
    return Intl.message(
      '请输入正确的$name',
      name: 'formErrorMessageDate',
      desc: '',
      args: [name],
    );
  }

  /// `请输入正确的{name}`
  String formErrorMessageUrl(Object name) {
    return Intl.message(
      '请输入正确的$name',
      name: 'formErrorMessageUrl',
      desc: '',
      args: [name],
    );
  }

  /// `{name}必填`
  String formErrorMessageRequired(Object name) {
    return Intl.message(
      '$name必填',
      name: 'formErrorMessageRequired',
      desc: '',
      args: [name],
    );
  }

  /// `{name}字符长度不能超过 {validate} 个字符，一个中文等于两个字符`
  String formErrorMessageMax(Object name, Object validate) {
    return Intl.message(
      '$name字符长度不能超过 $validate 个字符，一个中文等于两个字符',
      name: 'formErrorMessageMax',
      desc: '',
      args: [name, validate],
    );
  }

  /// `{name}字符长度不能少于 {validate} 个字符，一个中文等于两个字符`
  String formErrorMessageMin(Object name, Object validate) {
    return Intl.message(
      '$name字符长度不能少于 $validate 个字符，一个中文等于两个字符',
      name: 'formErrorMessageMin',
      desc: '',
      args: [name, validate],
    );
  }

  /// `{name}字符长度必须是 {validate}`
  String formErrorMessageLen(Object name, Object validate) {
    return Intl.message(
      '$name字符长度必须是 $validate',
      name: 'formErrorMessageLen',
      desc: '',
      args: [name, validate],
    );
  }

  /// `{name}只能是{validate}等`
  String formErrorMessageEnum(Object name, Object validate) {
    return Intl.message(
      '$name只能是$validate等',
      name: 'formErrorMessageEnum',
      desc: '',
      args: [name, validate],
    );
  }

  /// `请输入正确的{name}`
  String formErrorMessageIdcard(Object name) {
    return Intl.message(
      '请输入正确的$name',
      name: 'formErrorMessageIdcard',
      desc: '',
      args: [name],
    );
  }

  /// `请输入正确的{name}`
  String formErrorMessageTelnumber(Object name) {
    return Intl.message(
      '请输入正确的$name',
      name: 'formErrorMessageTelnumber',
      desc: '',
      args: [name],
    );
  }

  /// `请输入正确的{name}`
  String formErrorMessagePattern(Object name) {
    return Intl.message(
      '请输入正确的$name',
      name: 'formErrorMessagePattern',
      desc: '',
      args: [name],
    );
  }

  /// `{name}不符合要求`
  String formErrorMessageValidator(Object name) {
    return Intl.message(
      '$name不符合要求',
      name: 'formErrorMessageValidator',
      desc: '',
      args: [name],
    );
  }

  /// `{name}数据类型必须是布尔类型`
  String formErrorMessageBoolean(Object name) {
    return Intl.message(
      '$name数据类型必须是布尔类型',
      name: 'formErrorMessageBoolean',
      desc: '',
      args: [name],
    );
  }

  /// `{name}必须是数字`
  String formErrorMessageNumber(Object name) {
    return Intl.message(
      '$name必须是数字',
      name: 'formErrorMessageNumber',
      desc: '',
      args: [name],
    );
  }

  /// `请输入`
  String get inputPlaceholder {
    return Intl.message(
      '请输入',
      name: 'inputPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `正在加载中，请稍等`
  String get listLoadingText {
    return Intl.message(
      '正在加载中，请稍等',
      name: 'listLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `点击加载更多`
  String get listLoadingMoreText {
    return Intl.message(
      '点击加载更多',
      name: 'listLoadingMoreText',
      desc: '',
      args: [],
    );
  }

  /// `展开更多`
  String get alertExpandText {
    return Intl.message(
      '展开更多',
      name: 'alertExpandText',
      desc: '',
      args: [],
    );
  }

  /// `收起`
  String get alertCollapseText {
    return Intl.message(
      '收起',
      name: 'alertCollapseText',
      desc: '',
      args: [],
    );
  }

  /// `链接复制成功`
  String get anchorCopySuccessText {
    return Intl.message(
      '链接复制成功',
      name: 'anchorCopySuccessText',
      desc: '',
      args: [],
    );
  }

  /// `复制链接`
  String get anchorCopyText {
    return Intl.message(
      '复制链接',
      name: 'anchorCopyText',
      desc: '',
      args: [],
    );
  }

  /// `系统预设颜色`
  String get colorPickerSwatchColorTitle {
    return Intl.message(
      '系统预设颜色',
      name: 'colorPickerSwatchColorTitle',
      desc: '',
      args: [],
    );
  }

  /// `最近使用颜色`
  String get colorPickerRecentColorTitle {
    return Intl.message(
      '最近使用颜色',
      name: 'colorPickerRecentColorTitle',
      desc: '',
      args: [],
    );
  }

  /// `确定清空最近使用的颜色吗？`
  String get colorPickerClearConfirmText {
    return Intl.message(
      '确定清空最近使用的颜色吗？',
      name: 'colorPickerClearConfirmText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
      Locale.fromSubtags(languageCode: 'ko', countryCode: 'KR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
