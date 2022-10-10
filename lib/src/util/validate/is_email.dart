import 'package:tdesign_desktop_ui/src/util/validate/is_fqdn.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_byte_length.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_ip.dart';
import 'package:tdesign_desktop_ui/src/util/validate/validate_util.dart';

const _defaultEmailOptions = {
  'allow_display_name': false,
  'require_display_name': false,
  'allow_utf8_local_part': true,
  'require_tld': true,
  'blacklisted_chars': '',
  'ignore_max_length': false,
  'host_blacklist': [],
};

final _splitNameAddress = RegExp(r'^([^\x00-\x1F\x7F-\x9F\cX]+)<', caseSensitive: false);
final _emailUserPart = RegExp(r"^[a-z\d!#$%&'*+\-/=?^_`{|}~]+$", caseSensitive: false);
final _gmailUserPart = RegExp(r'^[a-z\d]+$');
final _quotedEmailUser = RegExp(
    r'^([\s\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e]|(\\[\x01-\x09\x0b\x0c\x0d-\x7f]))*$', caseSensitive: false);
final _emailUserUtf8Part = RegExp(r"^[a-z\d!#$%&'*+\-/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+$", caseSensitive: false);
final _quotedEmailUserUtf8 = RegExp(
    r'^([\s\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|(\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*$',
    caseSensitive: false);
const _defaultMaxEmailLength = 254;

/// Validate display name according to the RFC2822: https://tools.ietf.org/html/rfc2822#appendix-A.1.2
/// @param {String} display_name
bool _validateDisplayName(String displayName) {
  var displayNameWithoutQuotes = displayName.replaceAll(RegExp(r'^"(.+)"$'), r'$1');
  // display name with only spaces is not valid
  if (displayNameWithoutQuotes.trim().isEmpty) {
    return false;
  }

  // check whether display name contains illegal character
  var containsIllegal = RegExp(r'[.";<>]').hasMatch(displayNameWithoutQuotes);
  if (containsIllegal) {
    // if contains illegal characters,
    // must to be enclosed in double-quotes, otherwise it's not a valid display name
    if (displayNameWithoutQuotes == displayName) {
      return false;
    }

    // the quotes in display name must start with character symbol \
    var allStartWithBackSlash =
        displayNameWithoutQuotes.split('"').length == displayNameWithoutQuotes.split('\\"').length;
    if (!allStartWithBackSlash) {
      return false;
    }
  }

  return true;
}

/// 验证是否是一个邮箱
bool isEmail(input, options) {
  assertString(input);
  options = merge(options, _defaultEmailOptions);
  String str = input as String;
  bool requireDisplayName = options['require_display_name'];
  bool allowDisplayName = options['allow_display_name'];
  bool domainSpecificValidation = options['domain_specific_validation'] ?? false;
  List hostBlacklist = options['host_blacklist'];
  String blacklistedChars = options['blacklisted_chars'];
  bool allowUtf8LocalPart = options['allow_utf8_local_part'];
  bool requireTld = options['require_tld'];
  bool ignoreMaxLength = options['ignore_max_length'];
  bool allowIpDomain = options['allow_ip_domain'] ?? false;

  if (requireDisplayName || allowDisplayName) {
    var displayEmail = _splitNameAddress.allMatches(str).map((e) => e.input).toList();
    if (displayEmail.isNotEmpty) {
      var displayName = displayEmail[1];

      // Remove display name and angle brackets to get email address
      // Can be done in the regex but will introduce a ReDOS (See  #1597 for more info)
      str = str.replaceFirst(displayName, '').replaceAll(RegExp(r'(^<|>$)'), '');

      // sometimes need to trim the last space to get the display name
      // because there may be a space between display name and email address
      // eg. myname <address@gmail.com>
      // the display name is `myname` instead of `myname `, so need to trim the last space
      if (displayName.endsWith(' ')) {
        displayName = displayName.substring(0, displayName.length - 1);
      }

      if (!_validateDisplayName(displayName)) {
        return false;
      }
    } else if (requireDisplayName) {
      return false;
    }
  }
  if (!ignoreMaxLength && str.length > _defaultMaxEmailLength) {
    return false;
  }

  var parts = str.split('@');
  var domain = parts.removeLast();
  var lowerDomain = domain.toLowerCase();

  if (hostBlacklist.contains(lowerDomain)) {
    return false;
  }

  var user = parts.join('@');

  if (domainSpecificValidation && (lowerDomain == 'gmail.com' || lowerDomain == 'googlemail.com')) {
    /*
      Previously we removed dots for gmail addresses before validating.
      This was removed because it allows `multiple..dots@gmail.com`
      to be reported as valid, but it is not.
      Gmail only normalizes single dots, removing them from here is pointless,
      should be done in normalizeEmail
    */
    user = user.toLowerCase();

    // Removing sub-address from username before gmail validation
    var username = user.split('+')[0];

    // Dots are not included in gmail length restriction
    if (!isByteLength(username.replaceAll(RegExp(r'\.'), ''), min: 6, max: 30)) {
      return false;
    }

    var userParts = username.split('.');
    for (var i = 0; i < userParts.length; i++) {
      if (!_gmailUserPart.hasMatch(userParts[i])) {
        return false;
      }
    }
  }

  if (ignoreMaxLength == false && (
    !isByteLength(user, max: 64 ) ||
    !isByteLength(domain, max: 254 ))
  ) {
    return false;
  }

  if (!isFQDN(domain, { 'require_tld': requireTld })) {
    if (!allowIpDomain) {
      return false;
    }

    if (!isIP(domain)) {
      if (!domain.startsWith('[') || !domain.endsWith(']')) {
        return false;
      }

      var noBracketDomain = domain.substring(1, domain.length - 1);

      if (noBracketDomain.isEmpty || !isIP(noBracketDomain)) {
        return false;
      }
    }
  }

  if (user.isNotEmpty && user[0] == '"') {
    user = user.substring(1, user.length - 1);
    return allowUtf8LocalPart ?
      _quotedEmailUserUtf8.hasMatch(user) :
      _quotedEmailUser.hasMatch(user);
  }

  var pattern = allowUtf8LocalPart ?
    _emailUserUtf8Part : _emailUserPart;

  var userParts = user.split('.');
  for (var i = 0; i < userParts.length; i++) {
    if (!pattern.hasMatch(userParts[i])) {
      return false;
    }
  }
  if (blacklistedChars.isNotEmpty) {
    if (user.contains(RegExp('[$blacklistedChars]+'))) return false;
  }

  return true;
}
