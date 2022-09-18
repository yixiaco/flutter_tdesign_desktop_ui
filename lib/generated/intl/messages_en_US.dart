// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static String m0(month) => "${month}";

  static String m1(year) => "${year}";

  static String m2(month) => "${Intl.select(month, {
            'jan': 'Jan',
            'feb': 'Feb',
            'mar': 'Mar',
            'apr': 'Apr',
            'may': 'May',
            'jun': 'Jun',
            'jul': 'Jul',
            'aug': 'Aug',
            'sep': 'Sep',
            'oct': 'Oct',
            'nov': 'Nov',
            'dec': 'Dec',
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
            'mon': 'Mon',
            'tue': 'Tue',
            'wed': 'Wed',
            'thu': 'Thu',
            'fri': 'Fri',
            'sat': 'Sat',
            'sun': 'Sun',
            'other': ' ',
          })}";

  static String m5(name) => "${name} is not a boolean";

  static String m6(name) => "${name} is invalid";

  static String m7(name, validate) => "${name} must be one of ${validate}";

  static String m8(name) => "${name} is invalid";

  static String m9(name, validate) =>
      "${name} must be exactly ${validate} characters";

  static String m10(name, validate) =>
      "${name} must be at least ${validate} characters";

  static String m11(name, validate) =>
      "${name} cannot be longer than ${validate} characters";

  static String m12(name) => "${name} must be a number";

  static String m13(name) => "${name} is invalid";

  static String m14(name) => "${name} is required";

  static String m15(name) => "${name} is invalid";

  static String m16(name) => "${name} is invalid";

  static String m17(name) => "${name} is invalid";

  static String m18(size) => "${size} / page";

  static String m19(total) => "${total} items";

  static String m20(result, count) =>
      "Search \"${result}\". Find ${count} items.";

  static String m21(checked, total) => "${checked} / ${total}";

  static String m22(sizeLimit) => "File is too large to upload. ${sizeLimit}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertCollapseText": MessageLookupByLibrary.simpleMessage("collapse"),
        "alertExpandText": MessageLookupByLibrary.simpleMessage("expand"),
        "anchorCopySuccessText":
            MessageLookupByLibrary.simpleMessage("copy the link successfully"),
        "anchorCopyText": MessageLookupByLibrary.simpleMessage("copy link"),
        "calendarCellMonth": MessageLookupByLibrary.simpleMessage(
            "January,February,March,April,May,June,July,August,September,October,November,December"),
        "calendarHideWeekend":
            MessageLookupByLibrary.simpleMessage("Hide Week"),
        "calendarMonthRadio": MessageLookupByLibrary.simpleMessage("month"),
        "calendarMonthSelection": m0,
        "calendarShowWeekend":
            MessageLookupByLibrary.simpleMessage("Show Week"),
        "calendarThisMonth": MessageLookupByLibrary.simpleMessage("This Month"),
        "calendarToday": MessageLookupByLibrary.simpleMessage("Today"),
        "calendarWeek": MessageLookupByLibrary.simpleMessage(
            "Monday,Tuesday,Wedsday,Thuresday,Friday,Staturday,Sunday"),
        "calendarYearRadio": MessageLookupByLibrary.simpleMessage("year"),
        "calendarYearSelection": m1,
        "cascaderEmpty": MessageLookupByLibrary.simpleMessage("Empty Data"),
        "cascaderLoadingText":
            MessageLookupByLibrary.simpleMessage("loading..."),
        "cascaderPlaceholder":
            MessageLookupByLibrary.simpleMessage("please select"),
        "colorPickerClearConfirmText":
            MessageLookupByLibrary.simpleMessage("Clear recently used colors?"),
        "colorPickerRecentColorTitle":
            MessageLookupByLibrary.simpleMessage("Recently Used"),
        "colorPickerSwatchColorTitle":
            MessageLookupByLibrary.simpleMessage("System Default"),
        "datePickerConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "datePickerDayAriaLabel": MessageLookupByLibrary.simpleMessage("D"),
        "datePickerDirection": MessageLookupByLibrary.simpleMessage("ltr"),
        "datePickerFormat": MessageLookupByLibrary.simpleMessage("YYYY-MM-DD"),
        "datePickerMonthAriaLabel": MessageLookupByLibrary.simpleMessage("M"),
        "datePickerMonths": m2,
        "datePickerNextDecade":
            MessageLookupByLibrary.simpleMessage("Next Decade"),
        "datePickerNextMonth":
            MessageLookupByLibrary.simpleMessage("Next Month"),
        "datePickerNextYear": MessageLookupByLibrary.simpleMessage("Next Year"),
        "datePickerNow": MessageLookupByLibrary.simpleMessage("Now"),
        "datePickerPlaceholderDate":
            MessageLookupByLibrary.simpleMessage("select date"),
        "datePickerPlaceholderMonth":
            MessageLookupByLibrary.simpleMessage("select month"),
        "datePickerPlaceholderYear":
            MessageLookupByLibrary.simpleMessage("select year"),
        "datePickerPreDecade":
            MessageLookupByLibrary.simpleMessage("Last Decade"),
        "datePickerPreMonth":
            MessageLookupByLibrary.simpleMessage("Last Month"),
        "datePickerPreYear": MessageLookupByLibrary.simpleMessage("Last Year"),
        "datePickerQuarters": m3,
        "datePickerRangeSeparator": MessageLookupByLibrary.simpleMessage(" - "),
        "datePickerSelectDate":
            MessageLookupByLibrary.simpleMessage("Select Date"),
        "datePickerSelectTime":
            MessageLookupByLibrary.simpleMessage("Select Time"),
        "datePickerWeekAbbreviation": MessageLookupByLibrary.simpleMessage("W"),
        "datePickerWeekdays": m4,
        "datePickerYearAriaLabel": MessageLookupByLibrary.simpleMessage("Y"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "drawerCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "drawerConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
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
        "inputPlaceholder":
            MessageLookupByLibrary.simpleMessage("please enter"),
        "listLoadingMoreText":
            MessageLookupByLibrary.simpleMessage("loading more"),
        "listLoadingText": MessageLookupByLibrary.simpleMessage("loading..."),
        "paginationItemsPerPage": m18,
        "paginationJumpTo": MessageLookupByLibrary.simpleMessage("jump to"),
        "paginationPage": MessageLookupByLibrary.simpleMessage(""),
        "paginationTotal": m19,
        "popconfirmCancelContent":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "popconfirmConfirmContent": MessageLookupByLibrary.simpleMessage("OK"),
        "selectEmpty": MessageLookupByLibrary.simpleMessage("Empty Data"),
        "selectLoadingText": MessageLookupByLibrary.simpleMessage("loading..."),
        "selectPlaceholder":
            MessageLookupByLibrary.simpleMessage("please select"),
        "tableCancelText": MessageLookupByLibrary.simpleMessage("Cancel"),
        "tableClearFilterResultButtonText":
            MessageLookupByLibrary.simpleMessage("Clear"),
        "tableColumnConfigButtonText":
            MessageLookupByLibrary.simpleMessage("Column Config"),
        "tableColumnConfigDescriptionText":
            MessageLookupByLibrary.simpleMessage(
                "Please select columns to show them in the table"),
        "tableColumnConfigTitleText":
            MessageLookupByLibrary.simpleMessage("Table Column Config"),
        "tableConfirmText": MessageLookupByLibrary.simpleMessage("Confirm"),
        "tableEmpty": MessageLookupByLibrary.simpleMessage("Empty Data"),
        "tableFilterInputPlaceholder": MessageLookupByLibrary.simpleMessage(""),
        "tableLoadingMoreText":
            MessageLookupByLibrary.simpleMessage("loading more"),
        "tableLoadingText": MessageLookupByLibrary.simpleMessage("loading..."),
        "tableResetText": MessageLookupByLibrary.simpleMessage("Reset"),
        "tableSearchResultText": m20,
        "tableSelectAllText":
            MessageLookupByLibrary.simpleMessage("Select All"),
        "tableSortAscendingOperationText":
            MessageLookupByLibrary.simpleMessage("click to sort ascending"),
        "tableSortCancelOperationText":
            MessageLookupByLibrary.simpleMessage("click to cancel sorting"),
        "tableSortDescendingOperationText":
            MessageLookupByLibrary.simpleMessage("click to sort descending"),
        "timePickerAnteMeridiem": MessageLookupByLibrary.simpleMessage("AM"),
        "timePickerConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "timePickerNow": MessageLookupByLibrary.simpleMessage("Now"),
        "timePickerPlaceholder":
            MessageLookupByLibrary.simpleMessage("please select"),
        "timePickerPostMeridiem": MessageLookupByLibrary.simpleMessage("PM"),
        "transferEmpty": MessageLookupByLibrary.simpleMessage("Empty Data"),
        "transferPlaceholder":
            MessageLookupByLibrary.simpleMessage("enter keyworkd to search"),
        "transferTitle": m21,
        "treeEmpty": MessageLookupByLibrary.simpleMessage("Empty Data"),
        "treeSelectEmpty": MessageLookupByLibrary.simpleMessage("Empty Data"),
        "treeSelectLoadingText":
            MessageLookupByLibrary.simpleMessage("loading..."),
        "treeSelectPlaceholder":
            MessageLookupByLibrary.simpleMessage("please select"),
        "uploadCancelUploadText":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "uploadDraggerClickAndDragText": MessageLookupByLibrary.simpleMessage(
            "Click \"Upload\" or Drag file to this area to upload"),
        "uploadDraggerDragDropText":
            MessageLookupByLibrary.simpleMessage("Drop hear"),
        "uploadDraggerDraggingText": MessageLookupByLibrary.simpleMessage(
            "Drag file to this area to upload"),
        "uploadFileFileNameText":
            MessageLookupByLibrary.simpleMessage("filename"),
        "uploadFileFileOperationDateText":
            MessageLookupByLibrary.simpleMessage("date"),
        "uploadFileFileOperationText":
            MessageLookupByLibrary.simpleMessage("operation"),
        "uploadFileFileSizeText": MessageLookupByLibrary.simpleMessage("size"),
        "uploadFileFileStatusText":
            MessageLookupByLibrary.simpleMessage("status"),
        "uploadProgressFailText":
            MessageLookupByLibrary.simpleMessage("Failed"),
        "uploadProgressSuccessText":
            MessageLookupByLibrary.simpleMessage("Success"),
        "uploadProgressUploadingText":
            MessageLookupByLibrary.simpleMessage("Uploading"),
        "uploadProgressWaitingText":
            MessageLookupByLibrary.simpleMessage("Waiting"),
        "uploadSizeLimitMessage": m22,
        "uploadTriggerUploadTextContinueUpload":
            MessageLookupByLibrary.simpleMessage("Continue Upload"),
        "uploadTriggerUploadTextDelete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "uploadTriggerUploadTextFileInput":
            MessageLookupByLibrary.simpleMessage("Upload"),
        "uploadTriggerUploadTextImage":
            MessageLookupByLibrary.simpleMessage("Click to upload"),
        "uploadTriggerUploadTextNormal":
            MessageLookupByLibrary.simpleMessage("Upload"),
        "uploadTriggerUploadTextReupload":
            MessageLookupByLibrary.simpleMessage("ReUpload"),
        "uploadTriggerUploadTextUploading":
            MessageLookupByLibrary.simpleMessage("uploading")
      };
}
