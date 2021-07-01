/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 18:06:58
 * @LastEditTime: 2021-06-25 11:14:19
 */
import 'dart:async';

import 'package:example/pages/example_adaption_page.dart';
import 'package:example/pages/example_log_page.dart';
import 'package:example/pages/example_route_page.dart';
import 'package:example/pages/example_http_page.dart';
import 'package:example/pages/example_exception_handle_page.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:logger_flutter/logger_flutter.dart';
import 'pages/example_toast_page.dart';
import 'package:example/pages/example_storage_page.dart';
import 'package:example/pages/example_custom_ui_page.dart';
import 'router.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  // runApp(MyApp());
  var openAdaption = await Storage.get('adaption');
  runApp(DevicePreview(
    enabled: openAdaption ?? false,
    builder: (context) => MyApp(), // Wrap your app
  ));
  // runZonedGuarded(
  //   () async {
  //     var openAdaption = await Storage.get('adaption');
  //     runApp(DevicePreview(
  //       enabled: openAdaption ?? false,
  //       builder: (context) => MyApp(), // Wrap your app
  //     ));
  //   },
  //   (e, s) {
  //     print('Current zone (1) inside catch: ${Zone.current.toString()}');
  //     print('Exception handled (1) $e, \n$s');
  //   },
  // );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      title: 'Flutter Framework Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Framework Demo Page'),
      // 路由拦截
      onGenerateRoute: (RouteSettings settings) {
        print('onGenerateRoute:${settings.name}');
        final String name = settings.name;
        final Function pageContentBuilder = AppRoute.getAllRoute()[name];
        if (pageContentBuilder != null) {
          final Route route = MaterialPageRoute(settings: RouteSettings(name: name), builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
          return route;
        }
        return null;
      },
      // builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Map> dataList = [
    {'index': 0, 'title': '网络HTTP', 'expanded': false, 'body': _httpExampleBody()},
    {'index': 1, 'title': '消息提示', 'expanded': false, 'body': _toastExampleBody()},
    {'index': 2, 'title': '路由', 'expanded': false, 'body': _routerExampleBody()},
    {'index': 3, 'title': '统一错误处理', 'expanded': false, 'body': _exceptionHandleBody()},
    {'index': 4, 'title': '日志', 'expanded': false, 'body': _loggerExampleBody()},
    {'index': 5, 'title': '屏幕适配', 'expanded': false, 'body': _adaptionExampleBody()},
    {'index': 6, 'title': '自定义UI组件库', 'expanded': false, 'body': _customUIBody()},
    {'index': 7, 'title': '本地存储', 'expanded': false, 'body': _storageExampleBody()}
  ];
  // ,{1: '消息提示'},{2: '路由'},{3: '统一错误处理'},{4: '日志'},{5: '屏幕适配'},{6: '自定义UI组件库'}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LiveRoute.singleton.register(); // 注册路由
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.top,
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Flutter Framework',
                          style: TextStyle(fontSize: 24),
                        ))),
                Container(
                  padding: EdgeInsets.only(bottom: 24),
                  child: RichText(
                    text: TextSpan(text: "本Flutter 框架由网络HTTP请求、消息提示、路由、统一错误处理、日志、屏幕适配、自定义UI组件库构成", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: []),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                ExpansionPanelList(
                  expansionCallback: (index, isExpanded) {
                    setState(() {
                      dataList[index]['expanded'] = !isExpanded;
                    });
                  },
                  children: dataList.map((value) {
                    return ExpansionPanel(
                        isExpanded: value['expanded'],
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(value['title']),
                          );
                        },
                        body: value['body']);
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}

class _toastExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('底部消息，居中消息，头部消息'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleToastPage(),
            ),
          );
        });
  }
}

class _routerExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('跳转（不带参数），跳转（带参数）， 跳转（带返回）'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleRoutePage(),
            ),
          );
        });
  }
}

class _exceptionHandleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('Flutter & Dart 中的错误处理'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleExceptionHandlePage(),
            ),
          );
        });
  }
}

class _storageExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('Set, Get'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleStoragePage(),
            ),
          );
        });
  }
}

class _customUIBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('Timer Widget'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleCustomUIPage(),
            ),
          );
        });
  }
}

class _httpExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('Get、Post、Patch、Header、Token、BaseUrl'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleHttpPage(),
            ),
          );
        });
  }
}

class _loggerExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('Verbose、Debug、Info、Warning、Error、WTF'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleLogPage(),
            ),
          );
        });
  }
}

class _adaptionExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text('Example'),
        subtitle: Text('开启/关闭屏幕适配测试'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExampleAdaptionPage(),
            ),
          );
        });
  }
}
