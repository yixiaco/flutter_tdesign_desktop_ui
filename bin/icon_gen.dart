import 'dart:convert';
import 'dart:io';

void main(){
  var indexPath = "bin/t_icon.json";
  var outputPath = "lib/src/components/icons/t_icons.dart";
  var indexFile = File(indexPath);
  if(!indexFile.existsSync()){
    print("indexFile is not exist");
    return ;
  }
  var indexContent = indexFile.readAsStringSync().replaceFirst('"\\\\E842"},]}', '"\\\\E842"}]}');
  print("indexContent:\n$indexContent");
  var jsonObj = jsonDecode(indexContent);
  var iconsJson = jsonObj["icons"];
  if(iconsJson is List){
    var iconList = <IconModel>[];
    iconsJson.forEach((element) {
      var model = IconModel();
      model.name = (element["name"] as String).replaceAll("-", '_');
      model.codepoint = (element["codepoint"] as String).replaceAll("\\", '');
      iconList.add(model);
    });

    print("iconList:\n$iconList");

    var fileSb = StringBuffer(fileStart);
    var varSb = StringBuffer();
    var mapSb = StringBuffer("  static const all = <String, _TIconsData>{\n");
    iconList.forEach((model) {
      varSb.writeln("  static const ${model.name} = _TIconsData(0x${model.codepoint}, '${model.name}');");
      mapSb.writeln("    '${model.name}': ${model.name},");
    });
    fileSb.writeln(varSb);
    fileSb.writeln(mapSb);
    fileSb.writeln(fileEnd);

    // 输出文件
    var outputFile = File(outputPath);
    if(!outputFile.existsSync()){
      outputFile.createSync(recursive: true);
    }
    outputFile.writeAsStringSync(fileSb.toString());
  }
}

class IconModel {
  String name = "";
  String codepoint = "";
}

var fileStart = '''
import 'package:flutter/widgets.dart';

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
@immutable
class _TIconsData extends IconData {
  const _TIconsData(super.codePoint, this.name)
      : super(
          fontFamily: 'TIcons',
          fontPackage: 'tdesign_desktop_ui',
        );

  final String name;
}


class TIcons {

  /// 私有构造方法，不支持外部创建，仅提供静态常量给外部使用
  const TIcons._();
''';

var fileEnd = '''
  };
}
''';