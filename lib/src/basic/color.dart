import 'package:flutter/material.dart';

///主题色是产品中最核心、最高频使用的颜色，它常用于强调信息、引导操作，并在很大程度上决定了产品整体的基调和风格。
///TDesign 以腾讯蓝（Tencent Blue）作为默认主题色，蕴含了科技创新、开放共享的品牌特质和生态理念，其稳健、中性的气质，在中后台设计中也具有广泛的普适性.
class TColors {

  const TColors._();

  /// 点击色
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFECF2FE),
      100: Color(0xFFD4E3FC),
      200: Color(0xFFBBD3FB),
      300: Color(0xFF96BBF8),
      400: Color(0xFF699EF5),
      500: Color(0xFF4787F0),
      600: Color(0xFF266FE8),
      700: Color(0xFF0052D9),
      800: Color(0xFF0034B5),
      900: Color(0xFF001F97),
    },
  );
  static const int _bluePrimaryValue = 0xFF0052D9;

  /// 错误色
  static const MaterialColor red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(0xFFFDECEE),
      100: Color(0xFFF9D7D9),
      200: Color(0xFFF8B9BE),
      300: Color(0xFFF78D94),
      400: Color(0xFFF36D78),
      500: Color(0xFFE34D59),
      600: Color(0xFFC9353F),
      700: Color(0xFFB11F26),
      800: Color(0xFF951114),
      900: Color(0xFF680506),
    },
  );
  static const int _redPrimaryValue = 0xFFE34D59;

  /// 告警色
  static const MaterialColor orange = MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      50: Color(0xFFFEF3E6),
      100: Color(0xFFF9E0C7),
      200: Color(0xFFF7C797),
      300: Color(0xFFF2995F),
      400: Color(0xFFED7B2F),
      500: Color(0xFFD35A21),
      600: Color(0xFFBA431B),
      700: Color(0xFF9E3610),
      800: Color(0xFF842B0B),
      900: Color(0xFF5A1907),
    },
  );
  static const int _orangePrimaryValue = 0xFFED7B2F;

  /// 成功色
  static const MaterialColor green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFE8F8F2),
      100: Color(0xFFBCEBDC),
      200: Color(0xFF85DBBE),
      300: Color(0xFF48C79C),
      400: Color(0xFF00A870),
      500: Color(0xFF078D5C),
      600: Color(0xFF067945),
      700: Color(0xFF056334),
      800: Color(0xFF044F2A),
      900: Color(0xFF033017),
    },
  );
  static const int _greenPrimaryValue = 0xFF00A870;

  /// 扩展色

  /// 天蓝色
  static const MaterialColor cyan = MaterialColor(
    _cyanPrimaryValue,
    <int, Color>{
      50: Color(0xFFD6F7FF),
      100: Color(0xFFB2ECFF),
      200: Color(0xFF85DAFF),
      300: Color(0xFF5CC5FC),
      400: Color(0xFF31ADFB),
      500: Color(0xFF0594FA),
      600: Color(0xFF007EDF),
      700: Color(0xFF0068C0),
      800: Color(0xFF00549E),
      900: Color(0xFF00417D),
    },
  );
  static const int _cyanPrimaryValue = 0xFF0594FA;

  /// 紫色
  static const MaterialColor purple = MaterialColor(
    _purplePrimaryValue,
    <int, Color>{
      50: Color(0xFFF3E0FF),
      100: Color(0xFFE6C4FF),
      200: Color(0xFFD8ABFF),
      300: Color(0xFFC68CFF),
      400: Color(0xFFAE78F0),
      500: Color(0xFF9963D8),
      600: Color(0xFF834EC2),
      700: Color(0xFF6D3BAC),
      800: Color(0xFF572796),
      900: Color(0xFF421381),
    },
  );
  static const int _purplePrimaryValue = 0xFF834EC2;

  /// 黄色
  static const MaterialColor yellow = MaterialColor(
    _yellowPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFF8B8),
      100: Color(0xFFFFE478),
      200: Color(0xFFFBCA25),
      300: Color(0xFFEBB105),
      400: Color(0xFFD29C00),
      500: Color(0xFFBA8700),
      600: Color(0xFFA37200),
      700: Color(0xFF8C5F00),
      800: Color(0xFF754C00),
      900: Color(0xFF5E3A00),
    },
  );
  static const int _yellowPrimaryValue = 0xFFEBB105;

  /// 粉红色
  static const MaterialColor pink = MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFE9FF),
      100: Color(0xFFFFD1FC),
      200: Color(0xFFFFB2F2),
      300: Color(0xFFFF8FE1),
      400: Color(0xFFFF66CC),
      500: Color(0xFFED49B4),
      600: Color(0xFFD42C9D),
      700: Color(0xFFBC0088),
      800: Color(0xFF9B006B),
      900: Color(0xFF7B0052),
    },
  );
  static const int _pinkPrimaryValue = 0xFFED49B4;


  /// 中性色
  /// 中性色包含一系列灰黑色，同时考虑到在暗黑模式下需要通过中性色来区界面分层级关系，所以在 CIELab 中根据亮度将中性色扩展至14个。
  /// 并且常用文字与其色彩对比度均大于4.5，满足 WCAG2.0 标准。

  /// 白色
  static const Color white = Color(0xFFFFFFFF);
  /// 灰色 L96
  static const Color gray1 = Color(0xFFF3F3F3);
  /// 灰色 L94
  static const Color gray2 = Color(0xFFEEEEEE);
  /// 灰色 L92
  static const Color gray3 = Color(0xFFE7E7E7);
  /// 灰色 L88
  static const Color gray4 = Color(0xFFDCDCDC);
  /// 灰色 L80
  static const Color gray5 = Color(0xFFC5C5C5);
  /// 灰色 L68
  static const Color gray6 = Color(0xFFA6A6A6);
  /// 灰色 L58
  static const Color gray7 = Color(0xFF8B8B8B);
  /// 灰色 L50
  static const Color gray8 = Color(0xFF777777);
  /// 灰色 L40
  static const Color gray9 = Color(0xFF5E5E5E);
  /// 灰色 L32
  static const Color gray10 = Color(0xFF4B4B4B);
  /// 灰色 L24
  static const Color gray11 = Color(0xFF383838);
  /// 灰色 L18
  static const Color gray12 = Color(0xFF2C2C2C);
  /// 灰色 L14
  static const Color gray13 = Color(0xFF242424);
  /// 灰色 L8
  static const Color gray14 = Color(0xFF181818);


  /// 蓝色 L96
  static const Color blue1 = Color(0xFFECF2FE);
  /// 蓝色 L94
  static const Color blue2 = Color(0xFFDEECFF);
  /// 蓝色 L92
  static const Color blue3 = Color(0xFFD4E3FC);
  /// 蓝色 L88
  static const Color blue4 = Color(0xFFBBD3FB);
  /// 蓝色 L80
  static const Color blue5 = Color(0xFF96BBF8);
  /// 蓝色 L68
  static const Color blue6 = Color(0xFF699EF5);
  /// 蓝色 L58
  static const Color blue7 = Color(0xFF4787F0);
  /// 蓝色 L50
  static const Color blue8 = Color(0xFF266FE8);
  /// 蓝色 L40
  static const Color blue9 = Color(0xFF0052D9);
  /// 蓝色 L32
  static const Color blue10 = Color(0xFF0034B5);
  /// 蓝色 L24
  static const Color blue11 = Color(0xFF001F97);
  /// 蓝色 L18
  static const Color blue12 = Color(0xFF00235C);
  /// 蓝色 L14
  static const Color blue13 = Color(0xFF001B47);
  /// 蓝色 L8
  static const Color blue14 = Color(0xFF000F29);

  /// 带有品牌色倾向的中性色
  ///外在页面模版等应用场景中，需要在各层级的灰黑色中加入颜色倾向，以突出品牌氛围。
  ///过程中使用了 RGB 混色模型，经过多次的尝试最终确定了品牌色的混合比例为 20%，运用规则同普通中性色一致。

  /// 蓝灰色 L96
  static const Color blueGray1 = Color(0xFFF1F2F5);
  /// 蓝灰色 L94
  static const Color blueGray2 = Color(0xFFEBEDF1);
  /// 蓝灰色 L92
  static const Color blueGray3 = Color(0xFFE3E6EB);
  /// 蓝灰色 L88
  static const Color blueGray4 = Color(0xFFD6DBE3);
  /// 蓝灰色 L80
  static const Color blueGray5 = Color(0xFFBCC4D0);
  /// 蓝灰色 L68
  static const Color blueGray6 = Color(0xFF97A3B7);
  /// 蓝灰色 L58
  static const Color blueGray7 = Color(0xFF7787A2);
  /// 蓝灰色 L50
  static const Color blueGray8 = Color(0xFF5F7292);
  /// 蓝灰色 L40
  static const Color blueGray9 = Color(0xFF4B5B76);
  /// 蓝灰色 L32
  static const Color blueGray10 = Color(0xFF3C485C);
  /// 蓝灰色 L24
  static const Color blueGray11 = Color(0xFF2C3645);
  /// 蓝灰色 L18
  static const Color blueGray12 = Color(0xFF232A35);
  /// 蓝灰色 L14
  static const Color blueGray13 = Color(0xFF1C222B);
  /// 蓝灰色 L8
  static const Color blueGray14 = Color(0xFF13161B);


  /// dark mode

  /// 暗黑模式-点击色
  static const MaterialColor blueDark = MaterialColor(
    _blueDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF1E2C60),
      100: Color(0xFF062E9A),
      200: Color(0xFF073AB5),
      300: Color(0xFF084DCD),
      400: Color(0xFF0957D9),
      500: Color(0xFF2174FF),
      600: Color(0xFF478DFF),
      700: Color(0xFF69A1FF),
      800: Color(0xFF8CB8FF),
      900: Color(0xFFABCAFF),
    },
  );
  static const int _blueDarkPrimaryValue = 0xFF2174FF;

  /// 暗黑模式-点击色
  static const MaterialColor blueDark1 = MaterialColor(
    _blueDark1PrimaryValue,
    <int, Color>{
      50: Color(0xFF1B2F51),
      100: Color(0xFF173463),
      200: Color(0xFF143975),
      300: Color(0xFF103D88),
      400: Color(0xFF0D429A),
      500: Color(0xFF054BBE),
      600: Color(0xFF2667D4),
      700: Color(0xFF4582E6),
      800: Color(0xFF699EF5),
      900: Color(0xFF96BBF8),
    },
  );
  static const int _blueDark1PrimaryValue = 0xFF4582E6;

  /// 暗黑模式-错误色
  static const MaterialColor redDark = MaterialColor(
    _redDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF730524),
      100: Color(0xFF960627),
      200: Color(0xFFB01C37),
      300: Color(0xFFC9384A),
      400: Color(0xFFE35661),
      500: Color(0xFFFB6E77),
      600: Color(0xFFFF9195),
      700: Color(0xFFFFB5B8),
      800: Color(0xFFFFD6D8),
      900: Color(0xFFFFF2F2),
    },
  );
  static const int _redDarkPrimaryValue = 0xFFFB6E77;

  /// 暗黑模式-错误色
  static const MaterialColor redDark1 = MaterialColor(
    _redDark1PrimaryValue,
    <int, Color>{
      50: Color(0xFF472324),
      100: Color(0xFF5E2A2D),
      200: Color(0xFF703439),
      300: Color(0xFF83383E),
      400: Color(0xFFA03F46),
      500: Color(0xFFC64751),
      600: Color(0xFFDE6670),
      700: Color(0xFFEC888E),
      800: Color(0xFFEDB1B6),
      900: Color(0xFFEECED0),
    },
  );
  static const int _redDark1PrimaryValue = 0xFFC64751;

  /// 暗黑模式-告警色
  static const MaterialColor orangeDark = MaterialColor(
    _orangeDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF692204),
      100: Color(0xFF873105),
      200: Color(0xFFA24006),
      300: Color(0xFFC25110),
      400: Color(0xFFD66724),
      500: Color(0xFFED8139),
      600: Color(0xFFFF9852),
      700: Color(0xFFFFB97D),
      800: Color(0xFFFFD8AD),
      900: Color(0xFFFFF4E5),
    },
  );
  static const int _orangeDarkPrimaryValue = 0xFFED8139;

  /// 暗黑模式-告警色
  static const MaterialColor orangeDark1 = MaterialColor(
    _orangeDark1PrimaryValue,
    <int, Color>{
      50: Color(0xFF4F2A1D),
      100: Color(0xFF582F21),
      200: Color(0xFF733C23),
      300: Color(0xFFA75D2B),
      400: Color(0xFFCF6E2D),
      500: Color(0xFFDC7633),
      600: Color(0xFFE8935C),
      700: Color(0xFFECBF91),
      800: Color(0xFFEED7BF),
      900: Color(0xFFF3E9DC),
    },
  );
  static const int _orangeDark1PrimaryValue = 0xFFCF6E2D;

  /// 暗黑模式-成功色
  static const MaterialColor greenDark = MaterialColor(
    _greenDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF034116),
      100: Color(0xFF035428),
      200: Color(0xFF046939),
      300: Color(0xFF057E4C),
      400: Color(0xFF06935F),
      500: Color(0xFF07A872),
      600: Color(0xFF37BF8E),
      700: Color(0xFF71D5AE),
      800: Color(0xFFB3E8D1),
      900: Color(0xFFE8F7F1),
    },
  );
  static const int _greenDarkPrimaryValue = 0xFF07A872;

  /// 暗黑模式-成功色
  static const MaterialColor greenDark1 = MaterialColor(
    _greenDark1PrimaryValue,
    <int, Color>{
      50: Color(0xFF193A2A),
      100: Color(0xFF1A4230),
      200: Color(0xFF17533D),
      300: Color(0xFF0D7A55),
      400: Color(0xFF059465),
      500: Color(0xFF43AF8A),
      600: Color(0xFF46BF96),
      700: Color(0xFF80D2B6),
      800: Color(0xFFB4E1D3),
      900: Color(0xFFDEEDE8),
    },
  );
  static const int _greenDark1PrimaryValue = 0xFF059465;

  /// 暗黑模式-扩展色

  /// 暗黑模式-天蓝色
  static const MaterialColor cyanDark = MaterialColor(
    _cyanDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF05437D),
      100: Color(0xFF06579E),
      200: Color(0xFF086CC0),
      300: Color(0xFF0B83DF),
      400: Color(0xFF0F98FA),
      500: Color(0xFF3CB1FB),
      600: Color(0xFF67C9FC),
      700: Color(0xFF8FDDFF),
      800: Color(0xFFBDEFFF),
      900: Color(0xFFE0F9FF),
    },
  );
  static const int _cyanDarkPrimaryValue = 0xFF3CB1FB;

  /// 暗黑模式-紫色
  static const MaterialColor purpleDark = MaterialColor(
    _purpleDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF451981),
      100: Color(0xFF5A2D96),
      200: Color(0xFF7141AC),
      300: Color(0xFF8755C2),
      400: Color(0xFF9E6CD8),
      500: Color(0xFFB382F0),
      600: Color(0xFFCB96FF),
      700: Color(0xFFDDB5FF),
      800: Color(0xFFEACFFF),
      900: Color(0xFFF7EBFF),
    },
  );
  static const int _purpleDarkPrimaryValue = 0xFFB382F0;

  /// 暗黑模式-黄色
  static const MaterialColor yellowDark = MaterialColor(
    _yellowDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF5E3B04),
      100: Color(0xFF754E05),
      200: Color(0xFF8C6106),
      300: Color(0xFFA37407),
      400: Color(0xFFBA8907),
      500: Color(0xFFD29E08),
      600: Color(0xFFEBB30E),
      700: Color(0xFFFBCC30),
      800: Color(0xFFFFE682),
      900: Color(0xFFFFF9C2),
    },
  );
  static const int _yellowDarkPrimaryValue = 0xFFD29E08;

  /// 暗黑模式-粉红色
  static const MaterialColor pinkDark = MaterialColor(
    _pinkDarkPrimaryValue,
    <int, Color>{
      50: Color(0xFF7B0554),
      100: Color(0xFF9B066D),
      200: Color(0xFFBC088A),
      300: Color(0xFFD435A0),
      400: Color(0xFFED53B7),
      500: Color(0xFFFF70CF),
      600: Color(0xFFFF99E4),
      700: Color(0xFFFFBDF4),
      800: Color(0xFFFFDBFD),
      900: Color(0xFFFFF2FF),
    },
  );
  static const int _pinkDarkPrimaryValue = 0xFFFF70CF;
}