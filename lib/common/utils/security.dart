import 'dart:convert';
import 'package:crypto/crypto.dart';

String duSHA256(String input) {
  String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO';
  var bytes = utf8.encode(input + salt);
  var digest = sha256.convert(bytes);
  return digest.toString();
}
