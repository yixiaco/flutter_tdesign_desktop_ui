//// 11.3.  Examples
///
///    The following addresses
///
///              fe80::1234 (on the 1st link of the node)
///              ff02::5678 (on the 5th link of the node)
///              ff08::9abc (on the 10th organization of the node)
///
///    would be represented as follows:
///
///              fe80::1234%1
///              ff02::5678%5
///              ff08::9abc%10
///
///    (Here we assume a natural translation from a zone index to the
///    <zone_id> part, where the Nth zone of any scope is translated into
///    "N".)
///
///    If we use interface names as <zone_id>, those addresses could also be
///    represented as follows:
///
///             fe80::1234%ne0
///             ff02::5678%pvc1.3
///             ff08::9abc%interface10
///
///    where the interface "ne0" belongs to the 1st link, "pvc1.3" belongs
///    to the 5th link, and "interface10" belongs to the 10th organization.
const _ipv4SegmentFormat = '(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])';
const _ipv4AddressFormat = '($_ipv4SegmentFormat[.]){3}$_ipv4SegmentFormat';
final _ipv4AddressRegExp = RegExp('^$_ipv4AddressFormat\$');

const _ipv6SegmentFormat = '(?:[0-9a-fA-F]{1,4})';
final _ipv6AddressRegExp = RegExp('^('
    '(?:$_ipv6SegmentFormat:){7}(?:$_ipv6SegmentFormat|:)|'
    '(?:$_ipv6SegmentFormat:){6}(?:$_ipv4AddressFormat|:$_ipv6SegmentFormat|:)|'
    '(?:$_ipv6SegmentFormat:){5}(?::$_ipv4AddressFormat|(:$_ipv6SegmentFormat){1,2}|:)|'
    '(?:$_ipv6SegmentFormat:){4}(?:(:$_ipv6SegmentFormat){0,1}:$_ipv4AddressFormat|(:$_ipv6SegmentFormat){1,3}|:)|'
    '(?:$_ipv6SegmentFormat:){3}(?:(:$_ipv6SegmentFormat){0,2}:$_ipv4AddressFormat|(:$_ipv6SegmentFormat){1,4}|:)|'
    '(?:$_ipv6SegmentFormat:){2}(?:(:$_ipv6SegmentFormat){0,3}:$_ipv4AddressFormat|(:$_ipv6SegmentFormat){1,5}|:)|'
    '(?:$_ipv6SegmentFormat:){1}(?:(:$_ipv6SegmentFormat){0,4}:$_ipv4AddressFormat|(:$_ipv6SegmentFormat){1,6}|:)|'
    '(?::((?::$_ipv6SegmentFormat){0,5}:$_ipv4AddressFormat|(?::$_ipv6SegmentFormat){1,7}|:))'
    ')(%[0-9a-zA-Z-.:]{1,})?\$');

/// 验证是否是一个IP
bool isIP([str, String version = '']) {
  if (str is! String) {
    return false;
  }
  if (version.isEmpty) {
    return isIP(str, '4') || isIP(str, '6');
  }
  if (version == '4') {
    return _ipv4AddressRegExp.hasMatch(str);
  }
  if (version == '6') {
    return _ipv6AddressRegExp.hasMatch(str);
  }
  return false;
}
