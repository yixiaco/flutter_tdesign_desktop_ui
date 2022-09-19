// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko_KR locale. All the
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
  String get localeName => 'ko_KR';

  static String m0(month) => "${month} 달";

  static String m1(year) => "${year} 년도";

  static String m2(month) => "${Intl.select(month, {
            'jan': '1 월',
            'feb': '2 월',
            'mar': '3 월',
            'apr': '4 월',
            'may': '5 월',
            'jun': '6 월',
            'jul': '7 월',
            'aug': '8 월',
            'sep': '9 월',
            'oct': '10 월',
            'nov': '11 월',
            'dec': '12 월',
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
            'mon': '하나',
            'tue': '둘',
            'wed': '삼',
            'thu': '4',
            'fri': '다섯',
            'sat': '여섯',
            'sun': '낮',
            'other': ' ',
          })}";

  static String m5(name) => "${name}데이터 유형은 부울이어야 합니다";

  static String m6(name) => "정확한 내용을 입력해주세요${name}";

  static String m7(name, validate) => "${name}만 될 수 있습니다${validate}그리고 더";

  static String m8(name) => "정확한 내용을 입력해주세요${name}";

  static String m9(name, validate) => "${name}문자 길이는 다음과 같아야 합니다. ${validate}";

  static String m10(name, validate) =>
      "${name}문자 길이는 초과할 수 없습니다 ${validate} 캐릭터，한자는 두 글자와 같다";

  static String m11(name, validate) =>
      "${name}문자 길이는 다음보다 작을 수 없습니다 ${validate} 캐릭터，한자는 두 글자와 같다";

  static String m12(name) => "${name}숫자여야 합니다";

  static String m13(name) => "정확한 내용을 입력해주세요${name}";

  static String m14(name) => "${name}필수의";

  static String m15(name) => "정확한 내용을 입력해주세요${name}";

  static String m16(name) => "정확한 내용을 입력해주세요${name}";

  static String m17(name) => "${name}비준수";

  static String m18(size) => "${size} /페이지";

  static String m19(total) => "흔한 ${total} 아이템 데이터";

  static String m20(result, count) => "검색“${result}”，일어나 ${count} 결과";

  static String m21(checked, total) => "${checked} / ${total} 안건";

  static String m22(sizeLimit) => "이미지 크기는 다음을 초과할 수 없습니다 ${sizeLimit}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertCollapseText": MessageLookupByLibrary.simpleMessage("치워"),
        "alertExpandText": MessageLookupByLibrary.simpleMessage("더 확장"),
        "anchorCopySuccessText":
            MessageLookupByLibrary.simpleMessage("링크 복사 성공"),
        "anchorCopyText": MessageLookupByLibrary.simpleMessage("링크 복사"),
        "calendarCellMonth": MessageLookupByLibrary.simpleMessage(
            "1월,2월,3월,4월,5월,6월,7월,8월,9월,10월,11월,12월"),
        "calendarHideWeekend": MessageLookupByLibrary.simpleMessage("주말을 숨기다"),
        "calendarMonthRadio": MessageLookupByLibrary.simpleMessage("달"),
        "calendarMonthSelection": m0,
        "calendarShowWeekend": MessageLookupByLibrary.simpleMessage("주말 쇼"),
        "calendarThisMonth": MessageLookupByLibrary.simpleMessage("이번 달"),
        "calendarToday": MessageLookupByLibrary.simpleMessage("오늘"),
        "calendarWeek":
            MessageLookupByLibrary.simpleMessage("하나,둘,셋,넷,다섯,여섯,하루"),
        "calendarYearRadio": MessageLookupByLibrary.simpleMessage("년도"),
        "calendarYearSelection": m1,
        "cascaderEmpty": MessageLookupByLibrary.simpleMessage("데이터 없음"),
        "cascaderLoadingText": MessageLookupByLibrary.simpleMessage("로딩 중"),
        "cascaderPlaceholder": MessageLookupByLibrary.simpleMessage("선택해주세요"),
        "colorPickerClearConfirmText":
            MessageLookupByLibrary.simpleMessage("최근에 사용한 색상을 지우시겠습니까?"),
        "colorPickerRecentColorTitle":
            MessageLookupByLibrary.simpleMessage("최근 사용한 색상"),
        "colorPickerSwatchColorTitle":
            MessageLookupByLibrary.simpleMessage("시스템 기본 색상"),
        "datePickerConfirm": MessageLookupByLibrary.simpleMessage("확신하는"),
        "datePickerDayAriaLabel": MessageLookupByLibrary.simpleMessage("낮"),
        "datePickerDirection": MessageLookupByLibrary.simpleMessage("ltr"),
        "datePickerFormat": MessageLookupByLibrary.simpleMessage("YYYY-MM-DD"),
        "datePickerMonthAriaLabel": MessageLookupByLibrary.simpleMessage("달"),
        "datePickerMonths": m2,
        "datePickerNextDecade": MessageLookupByLibrary.simpleMessage("다음 10년"),
        "datePickerNextMonth": MessageLookupByLibrary.simpleMessage("다음 달"),
        "datePickerNextYear": MessageLookupByLibrary.simpleMessage("내년"),
        "datePickerNow": MessageLookupByLibrary.simpleMessage("현재의"),
        "datePickerPlaceholderDate":
            MessageLookupByLibrary.simpleMessage("날짜를 선택하세요Z"),
        "datePickerPlaceholderMonth":
            MessageLookupByLibrary.simpleMessage("월을 선택하세요"),
        "datePickerPlaceholderYear":
            MessageLookupByLibrary.simpleMessage("연도를 선택하세요"),
        "datePickerPreDecade": MessageLookupByLibrary.simpleMessage("지난 십 년"),
        "datePickerPreMonth": MessageLookupByLibrary.simpleMessage("지난 달"),
        "datePickerPreYear": MessageLookupByLibrary.simpleMessage("작년"),
        "datePickerQuarters": m3,
        "datePickerRangeSeparator": MessageLookupByLibrary.simpleMessage(" - "),
        "datePickerSelectDate": MessageLookupByLibrary.simpleMessage("날짜 선택"),
        "datePickerSelectTime": MessageLookupByLibrary.simpleMessage("선발 기간"),
        "datePickerWeekAbbreviation": MessageLookupByLibrary.simpleMessage("주"),
        "datePickerWeekdays": m4,
        "datePickerYearAriaLabel": MessageLookupByLibrary.simpleMessage("년도"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("취소"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("확인하다"),
        "drawerCancel": MessageLookupByLibrary.simpleMessage("취소"),
        "drawerConfirm": MessageLookupByLibrary.simpleMessage("확인하다"),
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
        "inputPlaceholder": MessageLookupByLibrary.simpleMessage("들어 오세요"),
        "listLoadingMoreText":
            MessageLookupByLibrary.simpleMessage("더 로드하려면 클릭하세요"),
        "listLoadingText": MessageLookupByLibrary.simpleMessage("로딩 중 기다려주세요"),
        "paginationItemsPerPage": m18,
        "paginationJumpTo": MessageLookupByLibrary.simpleMessage("건너뛰다"),
        "paginationPage": MessageLookupByLibrary.simpleMessage("페이지"),
        "paginationTotal": m19,
        "popconfirmCancelContent": MessageLookupByLibrary.simpleMessage("취소"),
        "popconfirmConfirmContent":
            MessageLookupByLibrary.simpleMessage("확신하는"),
        "selectEmpty": MessageLookupByLibrary.simpleMessage("데이터 없음"),
        "selectLoadingText": MessageLookupByLibrary.simpleMessage("로딩 중"),
        "selectPlaceholder": MessageLookupByLibrary.simpleMessage("선택해주세요"),
        "tableCancelText": MessageLookupByLibrary.simpleMessage("취소"),
        "tableClearFilterResultButtonText":
            MessageLookupByLibrary.simpleMessage("클리어 필터"),
        "tableColumnConfigButtonText":
            MessageLookupByLibrary.simpleMessage("열 구성"),
        "tableColumnConfigDescriptionText":
            MessageLookupByLibrary.simpleMessage("테이블에 표시할 데이터 열을 선택하십시오"),
        "tableColumnConfigTitleText":
            MessageLookupByLibrary.simpleMessage("테이블 열 구성"),
        "tableConfirmText": MessageLookupByLibrary.simpleMessage("확인하다"),
        "tableEmpty": MessageLookupByLibrary.simpleMessage("데이터 없음"),
        "tableFilterInputPlaceholder":
            MessageLookupByLibrary.simpleMessage("아무거나 입력하세요(기본값 없음)"),
        "tableLoadingMoreText":
            MessageLookupByLibrary.simpleMessage("더 로드하려면 클릭하세요"),
        "tableLoadingText": MessageLookupByLibrary.simpleMessage("로딩 중 기다려주세요"),
        "tableResetText": MessageLookupByLibrary.simpleMessage("초기화"),
        "tableSearchResultText": m20,
        "tableSelectAllText": MessageLookupByLibrary.simpleMessage("모두 선택"),
        "tableSortAscendingOperationText":
            MessageLookupByLibrary.simpleMessage("오름차순으로 클릭"),
        "tableSortCancelOperationText":
            MessageLookupByLibrary.simpleMessage("클릭하여 정렬 해제"),
        "tableSortDescendingOperationText":
            MessageLookupByLibrary.simpleMessage("내림차순으로 클릭"),
        "timePickerAnteMeridiem": MessageLookupByLibrary.simpleMessage("아침"),
        "timePickerConfirm": MessageLookupByLibrary.simpleMessage("확신하는"),
        "timePickerNow": MessageLookupByLibrary.simpleMessage("지금"),
        "timePickerPlaceholder": MessageLookupByLibrary.simpleMessage("선발 기간"),
        "timePickerPostMeridiem": MessageLookupByLibrary.simpleMessage("오후"),
        "transferEmpty": MessageLookupByLibrary.simpleMessage("데이터 없음"),
        "transferPlaceholder":
            MessageLookupByLibrary.simpleMessage("검색할 키워드를 입력하세요"),
        "transferTitle": m21,
        "treeEmpty": MessageLookupByLibrary.simpleMessage("데이터 없음"),
        "treeSelectEmpty": MessageLookupByLibrary.simpleMessage("데이터 없음"),
        "treeSelectLoadingText": MessageLookupByLibrary.simpleMessage("로딩 중"),
        "treeSelectPlaceholder": MessageLookupByLibrary.simpleMessage("선택해주세요"),
        "uploadCancelUploadText":
            MessageLookupByLibrary.simpleMessage("업로드 취소"),
        "uploadDraggerClickAndDragText": MessageLookupByLibrary.simpleMessage(
            "위의 \"파일 선택\"을 클릭하거나 파일을 이 영역으로 끌어다 놓습니다"),
        "uploadDraggerDragDropText":
            MessageLookupByLibrary.simpleMessage("마우스를 놓으십시오"),
        "uploadDraggerDraggingText":
            MessageLookupByLibrary.simpleMessage("이 영역으로 드래그 앤 드롭"),
        "uploadFileFileNameText": MessageLookupByLibrary.simpleMessage("파일 이름"),
        "uploadFileFileOperationDateText":
            MessageLookupByLibrary.simpleMessage("업로드 날짜"),
        "uploadFileFileOperationText":
            MessageLookupByLibrary.simpleMessage("작동하다"),
        "uploadFileFileSizeText": MessageLookupByLibrary.simpleMessage("파일 크기"),
        "uploadFileFileStatusText": MessageLookupByLibrary.simpleMessage("상태"),
        "uploadProgressFailText":
            MessageLookupByLibrary.simpleMessage("업로드 실패"),
        "uploadProgressSuccessText":
            MessageLookupByLibrary.simpleMessage("성공적으로 업로드됨"),
        "uploadProgressUploadingText":
            MessageLookupByLibrary.simpleMessage("업로드"),
        "uploadProgressWaitingText":
            MessageLookupByLibrary.simpleMessage("업로드 보류 중"),
        "uploadSizeLimitMessage": m22,
        "uploadTriggerUploadTextContinueUpload":
            MessageLookupByLibrary.simpleMessage("계속 업로드"),
        "uploadTriggerUploadTextDelete":
            MessageLookupByLibrary.simpleMessage("삭제"),
        "uploadTriggerUploadTextFileInput":
            MessageLookupByLibrary.simpleMessage("파일 선택"),
        "uploadTriggerUploadTextImage":
            MessageLookupByLibrary.simpleMessage("이미지를 업로드하려면 클릭하세요"),
        "uploadTriggerUploadTextNormal":
            MessageLookupByLibrary.simpleMessage("업로드하려면 클릭"),
        "uploadTriggerUploadTextReupload":
            MessageLookupByLibrary.simpleMessage("재업로드"),
        "uploadTriggerUploadTextUploading":
            MessageLookupByLibrary.simpleMessage("업로드")
      };
}
