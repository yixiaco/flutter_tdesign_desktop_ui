// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja_JP locale. All the
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
  String get localeName => 'ja_JP';

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
            'q1': 'Q1',
            'q2': 'Q2',
            'q3': 'Q3',
            'q4': 'Q4',
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

  static String m5(name) => "${name}データ型は Boolean 型であること";

  static String m6(name) => "正しく入力してください${name}";

  static String m7(name, validate) => "${name}でしかありえません${validate}等";

  static String m8(name) => "正しく入力してください${name}";

  static String m9(name, validate) => "${name}文字の長さは、必ず ${validate}";

  static String m10(name, validate) => "${name}文字数制限 ${validate} 文字，一中二文";

  static String m11(name, validate) =>
      "${name}を下回る文字数は使用できません ${validate} 文字，一中二文";

  static String m12(name) => "${name}デジタルであること";

  static String m13(name) => "正しく入力してください${name}";

  static String m14(name) => "${name}必須項目";

  static String m15(name) => "正しく入力してください${name}";

  static String m16(name) => "正しく入力してください${name}";

  static String m17(name) => "${name}要件を満たしていない";

  static String m18(size) => "${size} /ページ";

  static String m19(total) => "合計 ${total} 項目データ";

  static String m20(result, count) => "検索“${result}”，探す ${count} 記事結果";

  static String m21(checked, total) => "${checked} / ${total} 項目";

  static String m22(sizeLimit) => "画像サイズは最大で ${sizeLimit}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertCollapseText": MessageLookupByLibrary.simpleMessage("コレクト"),
        "alertExpandText": MessageLookupByLibrary.simpleMessage("もっと拡大する"),
        "anchorCopySuccessText":
            MessageLookupByLibrary.simpleMessage("リンクが正常にコピーされました"),
        "anchorCopyText": MessageLookupByLibrary.simpleMessage("コピーリンク"),
        "calendarCellMonth": MessageLookupByLibrary.simpleMessage(
            "一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月"),
        "calendarHideWeekend":
            MessageLookupByLibrary.simpleMessage("ヒドゥン・ウィークエンド"),
        "calendarMonthRadio": MessageLookupByLibrary.simpleMessage("月"),
        "calendarMonthSelection": m0,
        "calendarShowWeekend":
            MessageLookupByLibrary.simpleMessage("ショーウィークエンド"),
        "calendarThisMonth": MessageLookupByLibrary.simpleMessage("今月は"),
        "calendarToday": MessageLookupByLibrary.simpleMessage("今日"),
        "calendarWeek": MessageLookupByLibrary.simpleMessage("月,火,水,木,金,土,日"),
        "calendarYearRadio": MessageLookupByLibrary.simpleMessage("年"),
        "calendarYearSelection": m1,
        "cascaderEmpty": MessageLookupByLibrary.simpleMessage("データなし"),
        "cascaderLoadingText": MessageLookupByLibrary.simpleMessage("ローディング"),
        "cascaderPlaceholder": MessageLookupByLibrary.simpleMessage("選択してください"),
        "colorPickerClearConfirmText":
            MessageLookupByLibrary.simpleMessage("最近使用した色をクリアにするのは確実ですか？"),
        "colorPickerRecentColorTitle":
            MessageLookupByLibrary.simpleMessage("最近使用した色"),
        "colorPickerSwatchColorTitle":
            MessageLookupByLibrary.simpleMessage("システムプリセットカラー"),
        "datePickerConfirm": MessageLookupByLibrary.simpleMessage("決定事項"),
        "datePickerDayAriaLabel": MessageLookupByLibrary.simpleMessage("日"),
        "datePickerDirection": MessageLookupByLibrary.simpleMessage("ltr"),
        "datePickerFormat": MessageLookupByLibrary.simpleMessage("YYYY-MM-DD"),
        "datePickerMonthAriaLabel": MessageLookupByLibrary.simpleMessage("月"),
        "datePickerMonths": m2,
        "datePickerNextDecade": MessageLookupByLibrary.simpleMessage("次の10年"),
        "datePickerNextMonth": MessageLookupByLibrary.simpleMessage("来月"),
        "datePickerNextYear": MessageLookupByLibrary.simpleMessage("来年度"),
        "datePickerNow": MessageLookupByLibrary.simpleMessage("電流"),
        "datePickerPlaceholderDate":
            MessageLookupByLibrary.simpleMessage("日付を選択してください"),
        "datePickerPlaceholderMonth":
            MessageLookupByLibrary.simpleMessage("月を選択してください"),
        "datePickerPlaceholderYear":
            MessageLookupByLibrary.simpleMessage("年度を選択してください"),
        "datePickerPreDecade": MessageLookupByLibrary.simpleMessage("過去10年間"),
        "datePickerPreMonth": MessageLookupByLibrary.simpleMessage("先月"),
        "datePickerPreYear": MessageLookupByLibrary.simpleMessage("前年度"),
        "datePickerQuarters": m3,
        "datePickerRangeSeparator": MessageLookupByLibrary.simpleMessage(" - "),
        "datePickerSelectDate": MessageLookupByLibrary.simpleMessage("日付を選択"),
        "datePickerSelectTime": MessageLookupByLibrary.simpleMessage("時間を選択する"),
        "datePickerWeekAbbreviation":
            MessageLookupByLibrary.simpleMessage("週間"),
        "datePickerWeekdays": m4,
        "datePickerYearAriaLabel": MessageLookupByLibrary.simpleMessage("年"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("キャンセルについて"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("確認事項"),
        "drawerCancel": MessageLookupByLibrary.simpleMessage("キャンセルについて"),
        "drawerConfirm": MessageLookupByLibrary.simpleMessage("確認事項"),
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
        "inputPlaceholder": MessageLookupByLibrary.simpleMessage("入力してください"),
        "listLoadingMoreText":
            MessageLookupByLibrary.simpleMessage("クリックでさらに読み込み"),
        "listLoadingText":
            MessageLookupByLibrary.simpleMessage("ロード中です、お待ちください"),
        "paginationItemsPerPage": m18,
        "paginationJumpTo": MessageLookupByLibrary.simpleMessage("ジャンプする"),
        "paginationPage": MessageLookupByLibrary.simpleMessage("ページ"),
        "paginationTotal": m19,
        "popconfirmCancelContent":
            MessageLookupByLibrary.simpleMessage("キャンセルについて"),
        "popconfirmConfirmContent":
            MessageLookupByLibrary.simpleMessage("確認事項"),
        "selectEmpty": MessageLookupByLibrary.simpleMessage("データなし"),
        "selectLoadingText": MessageLookupByLibrary.simpleMessage("ローディング"),
        "selectPlaceholder": MessageLookupByLibrary.simpleMessage("選択してください"),
        "tableCancelText": MessageLookupByLibrary.simpleMessage("キャンセルについて"),
        "tableClearFilterResultButtonText":
            MessageLookupByLibrary.simpleMessage("クリアフィルター"),
        "tableColumnConfigButtonText":
            MessageLookupByLibrary.simpleMessage("カラム構成"),
        "tableColumnConfigDescriptionText":
            MessageLookupByLibrary.simpleMessage("表に表示するデータの列を選択してください。"),
        "tableColumnConfigTitleText":
            MessageLookupByLibrary.simpleMessage("テーブルカラムの構成"),
        "tableConfirmText": MessageLookupByLibrary.simpleMessage("確認事項"),
        "tableEmpty": MessageLookupByLibrary.simpleMessage("データなし"),
        "tableFilterInputPlaceholder":
            MessageLookupByLibrary.simpleMessage("内容を入力してください（初期値なし）"),
        "tableLoadingMoreText":
            MessageLookupByLibrary.simpleMessage("クリックでさらに読み込み"),
        "tableLoadingText":
            MessageLookupByLibrary.simpleMessage("ロード中です、お待ちください"),
        "tableResetText": MessageLookupByLibrary.simpleMessage("リセット"),
        "tableSearchResultText": m20,
        "tableSelectAllText": MessageLookupByLibrary.simpleMessage("すべて選択"),
        "tableSortAscendingOperationText":
            MessageLookupByLibrary.simpleMessage("クリックで昇降"),
        "tableSortCancelOperationText":
            MessageLookupByLibrary.simpleMessage("クリックでソート解除"),
        "tableSortDescendingOperationText":
            MessageLookupByLibrary.simpleMessage("降順でクリック"),
        "timePickerAnteMeridiem": MessageLookupByLibrary.simpleMessage("モーニング"),
        "timePickerConfirm": MessageLookupByLibrary.simpleMessage("決定事項"),
        "timePickerNow": MessageLookupByLibrary.simpleMessage("このとき"),
        "timePickerPlaceholder":
            MessageLookupByLibrary.simpleMessage("時間を選択する"),
        "timePickerPostMeridiem": MessageLookupByLibrary.simpleMessage("午後"),
        "transferEmpty": MessageLookupByLibrary.simpleMessage("データなし"),
        "transferPlaceholder":
            MessageLookupByLibrary.simpleMessage("検索するキーワードを入力してください"),
        "transferTitle": m21,
        "treeEmpty": MessageLookupByLibrary.simpleMessage("データなし"),
        "treeSelectEmpty": MessageLookupByLibrary.simpleMessage("データなし"),
        "treeSelectLoadingText": MessageLookupByLibrary.simpleMessage("ローディング"),
        "treeSelectPlaceholder":
            MessageLookupByLibrary.simpleMessage("選択してください"),
        "uploadCancelUploadText":
            MessageLookupByLibrary.simpleMessage("アップロードをキャンセルする"),
        "uploadDraggerClickAndDragText": MessageLookupByLibrary.simpleMessage(
            "上の「ファイルを選択」をクリックするか、このエリアにファイルをドラッグ＆ドロップしてください"),
        "uploadDraggerDragDropText":
            MessageLookupByLibrary.simpleMessage("マウスを離す"),
        "uploadDraggerDraggingText":
            MessageLookupByLibrary.simpleMessage("この領域にドラッグ＆ドロップする"),
        "uploadFileFileNameText": MessageLookupByLibrary.simpleMessage("ファイル名"),
        "uploadFileFileOperationDateText":
            MessageLookupByLibrary.simpleMessage("アップロード日"),
        "uploadFileFileOperationText":
            MessageLookupByLibrary.simpleMessage("操作"),
        "uploadFileFileSizeText":
            MessageLookupByLibrary.simpleMessage("ファイルサイズ"),
        "uploadFileFileStatusText":
            MessageLookupByLibrary.simpleMessage("状態です"),
        "uploadProgressFailText":
            MessageLookupByLibrary.simpleMessage("アップロードに失敗しました"),
        "uploadProgressSuccessText":
            MessageLookupByLibrary.simpleMessage("アップロード成功"),
        "uploadProgressUploadingText":
            MessageLookupByLibrary.simpleMessage("アップロード中"),
        "uploadProgressWaitingText":
            MessageLookupByLibrary.simpleMessage("アップロード予定"),
        "uploadSizeLimitMessage": m22,
        "uploadTriggerUploadTextContinueUpload":
            MessageLookupByLibrary.simpleMessage("アップロードを継続する"),
        "uploadTriggerUploadTextDelete":
            MessageLookupByLibrary.simpleMessage("削除"),
        "uploadTriggerUploadTextFileInput":
            MessageLookupByLibrary.simpleMessage("ファイル選択"),
        "uploadTriggerUploadTextImage":
            MessageLookupByLibrary.simpleMessage("クリックで画像をアップロード"),
        "uploadTriggerUploadTextNormal":
            MessageLookupByLibrary.simpleMessage("クリックでアップロード"),
        "uploadTriggerUploadTextReupload":
            MessageLookupByLibrary.simpleMessage("再アップロード"),
        "uploadTriggerUploadTextUploading":
            MessageLookupByLibrary.simpleMessage("アップロード中")
      };
}
