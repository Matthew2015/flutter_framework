/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-03-29 15:34:47
 * @LastEditTime: 2021-06-24 14:22:05
 */
import 'dart:convert' as convert;

class NativeParms<T> {
  Headers headers;
  String baseUrl;
  String userId;
  String accessToken;
  NativeParms();
  Map<String, dynamic> _$NativeParmsToJson(NativeParms<T> instance) => <String, dynamic>{'headers': instance.headers, 'baseUrl': instance.baseUrl, 'userId': instance.userId};
  factory NativeParms.fromJson(Map<String, dynamic> json) {
    print('feedback: NativeParms.fromJson');
    return NativeParms()
      ..headers = Headers.fromJson(json['headers'])
      ..baseUrl = json['host']
      ..userId = json['userId']
      ..accessToken = json['accessToken'];
  }
  Map<String, dynamic> toJson() => _$NativeParmsToJson(this);
}

class Headers<T> {
  Map<String, dynamic> headers;
  Headers();
  factory Headers.fromJson(String headers) {
    print('feedback: Headers.fromJson');
    return Headers()..headers = convert.jsonDecode(headers ?? '{}');
  }
}

class ClassliveHeaders<T> {
  static Map<String, dynamic> _headers;
  static Map<String, dynamic> get headers => _headers;

  static setHeaders(Map<String, dynamic> headers) {
    _headers = headers;
  }
}

class DioBase<T> {
  static String _baseurl;
  static String get baseurl => _baseurl;

  static setBaseUrl(String baseurl) {
    _baseurl = baseurl;
  }
}
