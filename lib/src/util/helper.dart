class CharacterLengthResult {
  final int length;
  final String? characters;

  const CharacterLengthResult({
    required this.length,
    this.characters,
  });
}

/// 计算字符串字符的长度并可以截取字符串。
/// [str] 传入字符串
/// [maxCharacter] 规定最大字符串长度
/// returns 当没有传入maxCharacter时返回字符串字符长度，当传入maxCharacter时返回截取之后的字符串和长度。
CharacterLengthResult getCharacterLength(String? str, [int? maxCharacter]) {
  var hasMaxCharacter = maxCharacter != null;
  if (str == null || str.isEmpty) {
    if (hasMaxCharacter) {
      return CharacterLengthResult(length: 0, characters: str);
    }
    return const CharacterLengthResult(length: 0);
  }
  var len = 0;
  for (var i = 0; i < str.length; i++) {
    var currentStringLength = 0;
    if (str.codeUnitAt(i) > 127 || str.codeUnitAt(i) == 94) {
      currentStringLength = 2;
    } else {
      currentStringLength = 1;
    }
    if (hasMaxCharacter && len + currentStringLength > maxCharacter) {
      return CharacterLengthResult(length: len, characters: str.substring(0, i));
    }
    len += currentStringLength;
  }
  if (hasMaxCharacter) {
    return CharacterLengthResult(length: len, characters: str);
  }
  return CharacterLengthResult(length: len);
}
