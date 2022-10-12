import 'package:tdesign_desktop_ui/src/util/validate/is_fqdn.dart';
import 'package:tdesign_desktop_ui/src/util/validate/is_ip.dart';
import 'package:tdesign_desktop_ui/src/util/validate/validate_util.dart';

const _defaultUrlOptions = {
  'protocols': ['http', 'https', 'ftp'],
  'require_tld': true,
  'require_protocol': false,
  'require_host': true,
  'require_port': false,
  'require_valid_protocol': true,
  'allow_underscores': false,
  'allow_trailing_dot': false,
  'allow_protocol_relative_urls': false,
  'allow_fragments': true,
  'allow_query_components': true,
  'validate_length': true,
};

final _wrappedIpv6 = RegExp(r'^\[([^\]]+)\](?::([0-9]+))?$');

bool _isRegExp(obj) {
  return obj is RegExp;
}

bool _checkHost(host, List<Pattern> matches) {
  for (var i = 0; i < matches.length; i++) {
    var match = matches[i];
    if (host == match || (_isRegExp(match) && (match as RegExp).hasMatch(host))) {
      return true;
    }
  }
  return false;
}

/// 字符串是否是URL
bool isURL(url, options) {
  if (url is! String) {
    return false;
  }
  if (url.isEmpty || RegExp(r'[\s<>]').hasMatch(url)) {
    return false;
  }
  if (url.indexOf('mailto:') == 0) {
    return false;
  }
  options = merge(options, _defaultUrlOptions);

  List<String> protocols = options['protocols'];
  // bool requireTld = options['require_tld'];
  bool requireProtocol = options['require_protocol'];
  bool requireHost = options['require_host'];
  bool requirePort = options['require_port'];
  bool requireValidProtocol = options['require_valid_protocol'];
  // bool allowUnderscores = options['allow_underscores'];
  // bool allowTrailingDot = options['allow_trailing_dot'];
  bool allowProtocolRelativeUrls = options['allow_protocol_relative_urls'];
  bool allowFragments = options['allow_fragments'];
  bool allowQueryComponents = options['allow_query_components'];
  bool validateLength = options['validate_length'];
  List<Pattern>? hostWhitelist = options['host_whitelist'];
  List<Pattern>? hostBlacklist = options['host_blacklist'];

  if (validateLength && url.length >= 2083) {
    return false;
  }

  if (!allowFragments && url.contains('#')) {
    return false;
  }

  if (!allowQueryComponents && (url.contains('?') || url.contains('&'))) {
    return false;
  }

  String? protocol;
  String? auth;
  String? host;
  String? hostname;
  int? port;
  String? portStr;
  String? ipv6;
  List<String> split;

  split = url.split('#');
  url = split.removeAt(0);

  split = url.split('?');
  url = split.removeAt(0);

  split = url.split('://');
  if (split.length > 1) {
    protocol = split.removeAt(0).toLowerCase();
    if (requireValidProtocol && !protocols.contains(protocol)) {
      return false;
    }
  } else if (requireProtocol) {
    return false;
  } else if (url.substring(0, 2) == '//') {
    if (!allowProtocolRelativeUrls) {
      return false;
    }
    split[0] = url.substring(2);
  }
  url = split.join('://');

  if (url == '') {
    return false;
  }

  split = url.split('/');
  url = split.removeAt(0);

  if (url == '' && !requireHost) {
    return true;
  }

  split = url.split('@');
  if (split.length > 1) {
    if (options.disallow_auth) {
      return false;
    }
    if (split[0] == '') {
      return false;
    }
    auth = split.removeAt(0);
    if (auth.contains(':') && auth.split(':').length > 2) {
      return false;
    }
    var auths = auth.split(':');
    if (auths.length >= 2) {
      if (auths[0] == '' && auths[1] == '') {
        return false;
      }
    }
  }
  hostname = split.join('@');

  portStr = null;
  ipv6 = null;
  var ipv6Match = _wrappedIpv6.allMatches(hostname).map((e) => e.input).toList();
  if (ipv6Match.isNotEmpty) {
    host = '';
    ipv6 = ipv6Match[1];
    portStr = ipv6Match.length > 2 ? ipv6Match[2] : null;
  } else {
    split = hostname.split(':');
    if (split.isNotEmpty) {
      host = split.removeAt(0);
    }
    if (split.isNotEmpty) {
      portStr = split.join(':');
    }
  }

  if (portStr != null && portStr.isNotEmpty) {
    port = int.tryParse(portStr, radix: 10) ?? -1;
    if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port <= 0 || port > 65535) {
      return false;
    }
  } else if (requirePort) {
    return false;
  }

  if (hostWhitelist != null) {
    return _checkHost(host, hostWhitelist);
  }

  if (host == '' && !requireHost) {
    return true;
  }

  if (!isIP(host) && !isFQDN(host, options) && (ipv6 == null || !isIP(ipv6, '6'))) {
    return false;
  }

  host ??= ipv6;

  if (hostBlacklist != null && _checkHost(host, hostBlacklist)) {
    return false;
  }

  return true;
}
