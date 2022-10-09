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
const _IPv4SegmentFormat = '(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])';
const _IPv4AddressFormat = '($_IPv4SegmentFormat[.]){3}$_IPv4SegmentFormat';
final _IPv4AddressRegExp = RegExp('^$_IPv4AddressFormat\$');

const _IPv6SegmentFormat = '(?:[0-9a-fA-F]{1,4})';
final _IPv6AddressRegExp = RegExp('^(' +
    '(?:$_IPv6SegmentFormat:){7}(?:$_IPv6SegmentFormat|:)|' +
    '(?:$_IPv6SegmentFormat:){6}(?:$_IPv4AddressFormat|:$_IPv6SegmentFormat|:)|' +
    '(?:$_IPv6SegmentFormat:){5}(?::$_IPv4AddressFormat|(:$_IPv6SegmentFormat){1,2}|:)|' +
    '(?:$_IPv6SegmentFormat:){4}(?:(:$_IPv6SegmentFormat){0,1}:$_IPv4AddressFormat|(:$_IPv6SegmentFormat){1,3}|:)|' +
    '(?:$_IPv6SegmentFormat:){3}(?:(:$_IPv6SegmentFormat){0,2}:$_IPv4AddressFormat|(:$_IPv6SegmentFormat){1,4}|:)|' +
    '(?:$_IPv6SegmentFormat:){2}(?:(:$_IPv6SegmentFormat){0,3}:$_IPv4AddressFormat|(:$_IPv6SegmentFormat){1,5}|:)|' +
    '(?:$_IPv6SegmentFormat:){1}(?:(:$_IPv6SegmentFormat){0,4}:$_IPv4AddressFormat|(:$_IPv6SegmentFormat){1,6}|:)|' +
    '(?::((?::$_IPv6SegmentFormat){0,5}:$_IPv4AddressFormat|(?::$_IPv6SegmentFormat){1,7}|:))' +
    ')(%[0-9a-zA-Z-.:]{1,})?\$');

bool isIP([str, String version = '']) {
  if (str is! String) {
    return false;
  }
  if (version.isEmpty) {
    return isIP(str, '4') || isIP(str, '6');
  }
  if (version == '4') {
    return _IPv4AddressRegExp.hasMatch(str);
  }
  if (version == '6') {
    return _IPv6AddressRegExp.hasMatch(str);
  }
  return false;
}
