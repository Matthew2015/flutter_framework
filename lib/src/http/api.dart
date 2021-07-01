/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-03-29 15:34:47
 * @LastEditTime: 2021-06-17 10:46:49
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 接口异常
///
/// [code] 响应code,
/// [url] 请求地址,
/// [msg] 提示信息
class ApiException implements Exception {
  final String msg;
  final String url;
  final int code;
  ApiException([this.code, this.url, this.msg]) {
    print(this);
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
  }

  @override
  String toString() {
    return '\ncode:$code \nurl:$url \nmsg:$msg';
  }
}

/// 处理请求异常
Future<T> handleException<T>(Future<T> future) async {
  try {
    var res = await future;
    return res;
  } on DioError catch (e) {
    Fluttertoast.showToast(
        msg: e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.sendTimeout || e.type == DioErrorType.receiveTimeout) {
    } else {}
  } on ApiException catch (e) {} catch (e) {}
  return null;
}

class ApiState<T> {
  int code;
  String msg;
  ApiState();
  Map<String, dynamic> _$ApiStateToJson(ApiState<T> instance) => <String, dynamic>{'code': instance.code, 'msg': instance.msg};
  factory ApiState.fromJson(Map<String, dynamic> json) {
    return ApiState()
      ..code = json['code'] as int
      ..msg = json['msg'] as String;
  }
  Map<String, dynamic> toJson() => _$ApiStateToJson(this);
}

class ApiResponse<T> {
  String uid;
  String requestId;
  ApiState state;
  T data;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json, Function f) {
    return ApiResponse()
      ..uid = '${json['uid']}'
      ..requestId = json['requestId'] as String
      ..state = ApiState<dynamic>.fromJson(json['state'] as Map<String, dynamic>)
      ..data = (json['data'] != null && f != null) ? f(json['data']) as T : null;
  }
  // Map<String, dynamic> toJson() => _$JanusResponseToJson(this);
}
