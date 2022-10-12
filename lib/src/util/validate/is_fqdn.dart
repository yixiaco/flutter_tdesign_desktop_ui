import 'package:tdesign_desktop_ui/src/util/validate/validate_util.dart';

const _defaultFqdnOptions = {
  'require_tld': true,
  'allow_underscores': false,
  'allow_trailing_dot': false,
  'allow_numeric_tld': false,
  'allow_wildcard': false,
};

bool isFQDN(dynamic str, options) {
  assertString(str);
  String s = str as String;
  options = merge(options, _defaultFqdnOptions);

  bool allowTrailingDot = options['allow_trailing_dot'];
  bool allowWildcard = options['allow_wildcard'];
  bool allowNumericTld = options['allow_numeric_tld'];
  bool requireTld = options['require_tld'];
  bool allowUnderscores = options['allow_underscores'];

  /* Remove the optional trailing dot before checking validity */
  if (allowTrailingDot && s[s.length - 1] == '.') {
    s = s.substring(0, s.length - 1);
  }

  /* Remove the optional wildcard before checking validity */
  if (allowWildcard == true && s.indexOf('*.') == 0) {
    s = s.substring(2);
  }

  var parts = s.split('.');
  var tld = parts[parts.length - 1];

  if (requireTld) {
    // disallow fqdns without tld
    if (parts.length < 2) {
      return false;
    }

    if (!allowNumericTld &&
        !RegExp(r'^([a-z\u00A1-\u00A8\u00AA-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]{2,}|xn[a-z0-9-]{2,})$',
                caseSensitive: false)
            .hasMatch(tld)) {
      return false;
    }

    // disallow spaces
    if (RegExp(r'\s').hasMatch(tld)) {
      return false;
    }
  }

  // reject numeric TLDs
  if (!allowNumericTld && RegExp(r'^\d+$').hasMatch(tld)) {
    return false;
  }

  return parts.every((part) {
    if (part.length > 63) {
      return false;
    }

    if (!RegExp(r'^[a-z_\u00a1-\uffff0-9-]+$', caseSensitive: false).hasMatch(part)) {
      return false;
    }

    // disallow full-width chars
    if (RegExp(r'[\uff01-\uff5e]').hasMatch(part)) {
      return false;
    }

    // disallow parts starting or ending with hyphen
    if (RegExp(r'^-|-$').hasMatch(part)) {
      return false;
    }

    if (!allowUnderscores && RegExp(r'_').hasMatch(part)) {
      return false;
    }

    return true;
  });
}
