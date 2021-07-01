/*
 * @Descripttion: 网络请求get post 封装类
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-03-29 15:34:47
 * @LastEditTime: 2021-06-24 14:01:16
 */
import 'dart:async';

import 'package:dio/dio.dart';
import 'api.dart';
import 'client_factory.dart';
import 'headers.dart';

Dio get _liveClassClient => DioClient(baseUrl: DioBase.baseurl, headers: ClassliveHeaders.headers).dio;

class LiveClassClient {
  /// @descripttion: post 请求
  /// @param {serviceName 服务名, params 请求参数}
  /// @return {*}
  static Future<T> post<T>(String serviceName, {Map<String, dynamic> params}) async {
    runZonedGuarded(() async {
      // 发送请求
      var res = await _liveClassClient.post<dynamic>(
        serviceName,
        data: params,
      );
      // 解析数据
      var response = ApiResponse<T>.fromJson(res.data as Map<String, dynamic>, (dynamic data) {
        if (data != null) {
          return data as T;
        }
        return null;
      });
      // 抛出异常
      if (response.state.code >= 2000000 && response.state.code < 3000000) {
        return response.data;
      } else {
        throw ApiException(response.state.code, serviceName, response.state.msg);
      }
    }, (e, s) {
      print('Exception handled (1) $e, \n$s');
      throw ApiException(999, serviceName, e.toString());
    });
  }

  /// @descripttion: get 请求
  /// @param {serviceName 服务名, params 请求参数}
  /// @return {*}
  static Future<T> get<T>(String serviceName, {Map<String, dynamic> params}) async {
    runZonedGuarded(() async {
      var res = await _liveClassClient.get<dynamic>(serviceName);
      // 解析数据
      var response = ApiResponse<T>.fromJson(res.data as Map<String, dynamic>, (dynamic data) {
        if (data != null) {
          return data as T;
        }
        return null;
      });
      // 抛出异常
      if (response.state.code == 2000000) {
        return response.data;
      } else {
        throw ApiException(response.state.code, serviceName, response.state.msg);
      }
    }, (e, s) {
      print('Exception handled (1) $e, \n$s');
      throw ApiException(999, serviceName, e.toString());
    });
  }

  /// @descripttion: patch 请求
  /// @param {serviceName 服务名, params 请求参数}
  /// @return {*}
  static Future<T> patch<T>(String serviceName, {Map<String, dynamic> params}) async {
    runZonedGuarded(() async {
      var res = await _liveClassClient.patch<dynamic>(serviceName);
      // 解析数据
      var response = ApiResponse<T>.fromJson(res.data as Map<String, dynamic>, (dynamic data) {
        if (data != null) {
          return data as T;
        }
        return null;
      });
      // 抛出异常
      if (response.state.code == 2000000) {
        return response.data;
      } else {
        throw ApiException(response.state.code, serviceName, response.state.msg);
      }
    }, (e, s) {
      print('Exception handled (1) $e, \n$s');
      throw ApiException(999, serviceName, e.toString());
    });
  }
}
