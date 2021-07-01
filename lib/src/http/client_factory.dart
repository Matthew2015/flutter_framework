import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

int _connectTimeout = 40000;

class ClientConfig {
  final String baseUrl;
  final ContentType contentType;
  final int connectTimeout;
  final int receiveTimeout;
  final bool encodeURI;
  final Map<String, dynamic> headers;

  ClientConfig({
    this.baseUrl,
    this.contentType,
    this.connectTimeout,
    this.receiveTimeout,
    this.encodeURI,
    this.headers,
  });

  @override
  bool operator ==(Object other) {
    return (other is ClientConfig &&
        other.baseUrl == baseUrl &&
        other.contentType.toString() == contentType.toString() &&
        other.connectTimeout == connectTimeout &&
        other.receiveTimeout == receiveTimeout &&
        other.encodeURI == other.encodeURI &&
        other.headers.toString() == headers.toString());
  }
}

class DioClient {
  final Dio dio;
  final ClientConfig clientConfig;
  static final Map<ClientConfig, DioClient> _cache = <ClientConfig, DioClient>{};
  static String _accessToken;
  static String get accessToken => _accessToken;
  static set accessToken(String val) {
    if (val != null) {
      _accessToken = val;
    }
  }

  factory DioClient({
    String baseUrl,
    ContentType contentType,
    int connectTimeout,
    int receiveTimeout,
    bool encodeURI,
    Map<String, dynamic> headers,
  }) {
    ClientConfig clientConfig = ClientConfig(
      baseUrl: baseUrl ?? '',
      connectTimeout: connectTimeout ?? _connectTimeout,
      contentType: contentType ?? ContentType('application', 'json', charset: 'utf-8'),
      receiveTimeout: receiveTimeout ?? _connectTimeout,
      encodeURI: encodeURI ?? false,
      headers: headers ?? <String, dynamic>{},
    );

    BaseOptions options = BaseOptions(
      baseUrl: clientConfig.baseUrl,
      connectTimeout: clientConfig.connectTimeout,
      receiveTimeout: clientConfig.receiveTimeout,
      contentType: clientConfig.contentType.toString(),
      headers: clientConfig.headers,
    );

    if (_cache.containsKey(clientConfig)) {
      return _cache[clientConfig];
    } else {
      var _dio = Dio(options);
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
      final client = DioClient._internal(_dio, clientConfig);
      _cache[clientConfig] = client;
      return client;
    }
  }

  DioClient._internal(this.dio, this.clientConfig) {
    _interceptors();
  }

  /// 拦截器
  void _interceptors() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (accessToken != null) {
        options.headers.putIfAbsent(
          'Authorization',
          () {
            return 'Bearer $accessToken';
          },
        );
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
    dio.interceptors.add(LogInterceptor(responseBody: false));
  }
}
