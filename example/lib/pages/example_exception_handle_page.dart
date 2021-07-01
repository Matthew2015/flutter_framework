/*
 * @Descripttion: Flutter & Dart 异常处理
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-24 18:38:54
 */
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleExceptionHandlePage extends StatefulWidget {
  ExampleExceptionHandlePage({Key key}) : super(key: key);

  @override
  _ExampleExceptionHandlePageState createState() => _ExampleExceptionHandlePageState();
}

class _ExampleExceptionHandlePageState extends State<ExampleExceptionHandlePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Exception Handle Example Page'),
        ),
        body: Markdown(
            data: "\n# Flutter & Dart 中的异常处理" +
                "\n## 哪些场景下需要错误处理介入" +
                "\n### 同步代码" +
                "\n同步代码中，`try-catch-finally`是最常用的错误处理方式" +
                "\n`rethrow`可以将错误信息重新上抛" +
                "\n```" +
                "\n     try {" +
                "\n        print('Allocate something 3');" +
                "\n        throw 'Other error occurred';" +
                "\n      } on IntegerDivisionByZeroException {" +
                "\n        print('Cant divide to zero');" +
                "\n      } on FormatException catch (e) {" +
                "\n        print('Format exceptions: ^e');" +
                "\n      } catch (e, s) {" +
                "\n        print('Unknown exceptions: ^e, with stack: \n^s');" +
                "\n        rethrow;" +
                "\n      } finally {" +
                "\n        print('Clean-up something 3');" +
                "\n      }" +
                "\n" +
                "\n```" +
                "\n### 异步代码" +
                "\n异步代码的错误处理也是用`try-catch-finally`，但要注意写法" +
                "\n下面是错误的例子" +
                "\n```" +
                "\n      try {" +
                "\n        Future.delayed(Duration(seconds: 1), () {" +
                "\n          final _ = 100 ~/ 0;" +
                "\n        });" +
                "\n        print('Everything is fine!');" +
                "\n      } on IntegerDivisionByZeroException {" +
                "\n        print('Cant divide to zero');" +
                "\n      } finally {" +
                "\n        print('Clean-up done');" +
                "\n      }" +
                "\n" +
                "\n```" +
                "\n为了能捕获到Futrue的错误可以有以下处理方式：" +
                "\n1. 加await" +
                "\n```" +
                "\n      try {" +
                "\n        await Future.delayed(Duration(seconds: 1), () {" +
                "\n          final _ = 100 ~/ 0;" +
                "\n        });" +
                "\n        print('Everything is fine!');" +
                "\n      } on IntegerDivisionByZeroException {" +
                "\n        print('Cant divide to zero');" +
                "\n      } finally {" +
                "\n        print('Clean-up done');" +
                "\n      }" +
                "\n" +
                "\n```" +
                "\n2.catchError & whenComplete结构" +
                "\ncatchError是捕获上方代码的异常，是catch的模拟，如果想模拟finally，则可以在catchError后加whenComplete，" +
                "\n另外可以使用test来模拟on Exeption，判断异常的类型" +
                "\n```" +
                "\n      await Future.delayed(Duration(seconds: 1), () {" +
                "\n        print('Its fie so far');" +
                "\n      }).then((value) {" +
                "\n        print('Then started');" +
                "\n        throw 'random exception';" +
                "\n      }).catchError((error) {" +
                "\n        print('Cant divide to zero');" +
                "\n      }, test: (e) => e is IntegerDivisionByZeroException).catchError((error) {" +
                "\n        print('All other exceptions: ^error');" +
                "\n      }, test: (e) => true).whenComplete(() {" +
                "\n        print('Clean-up done');" +
                "\n      });" +
                "\n" +
                "\n```" +
                "\n### 定时器" +
                "\n定时器使用`Zones`和`runZonedGuarded`处理异常，`Zones`可以将timer，微任务，Future的回调包起来（黑盒的try-catch-finally）,通过Zones对外的方法实现异常处理，注意，Zones里面捕获的异常是不会抛到上层，已经被Flutter框架捕获的异常，不会被runZoneGuarded捕获" +
                "\n```" +
                "\n      print('Current zone start in: ^{Zone.current.toString()}');" +
                "\n      runZonedGuarded(() {" +
                "\n        print('Current zone inside runZoned: ^{Zone.current.toString()} with name ^{Zone.current['ZoneName']}');" +
                "\n        Timer.run(() {" +
                "\n          print('Timer runs.');" +
                "\n          throw Exception('[Timer] Bad thing happens!');" +
                "\n        });" +
                "\n        runZonedGuarded(" +
                "\n          () {" +
                "\n            print('Current zone (1) inside runZoned: ^{Zone.current.toString()} with name ^{Zone.current['ZoneName']}');" +
                "\n            Timer.run(() {" +
                "\n              print('Timer 1 runs. ');" +
                "\n              throw Exception('[Timer 1] Bad thing happens!');" +
                "\n            });" +
                "\n          }," +
                "\n          (e, s) {" +
                "\n            print('Current zone (1) inside catch: ^{Zone.current.toString()} with name ^{Zone.current['ZoneName']}');" +
                "\n            print('Exception handled (1) ^e, \n^s');" +
                "\n          }," +
                "\n          zoneValues: {'ZoneName': 'Second zone'}," +
                "\n        );" +
                "\n        print('Everything is fine!');" +
                "\n      }, (e, s) {" +
                "\n        print('Current zone inside catch: ^{Zone.current.toString()} with name ^{Zone.current['ZoneName']}');" +
                "\n        print('Exception handled ^e, \n^s');" +
                "\n      }, zoneValues: {'ZoneName': 'First zone'});" +
                "\n" +
                "\n```" +
                "\n" +
                "\n### 流操作" +
                "\n流操作也是用Zone来捕获异常" +
                "\n" +
                "\n### Flutter App全局整体" +
                "\n使用FlutterError.onError回调方法，可以将上述捕获的异常记录下来，使用FlutterError.onError回调之前，要先WidgetsFlutterBinding.ensureInitialized()")
        // Container(
        //     child: Column(
        //   children: [
        //     Align(
        //         alignment: Alignment.centerLeft,
        //         child: Container(
        //             padding: EdgeInsets.all(20),
        //             child: Text(
        //               'Flutter & Dart 异常处理',
        //               style: TextStyle(fontSize: 24),
        //             ))),
        //     Container(
        //       padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
        //       child: RichText(
        //         text: TextSpan(text: "Framework Toast 模块，封装了Flutter_toast 库，对上层应用提供上、中、下三个位置的弹出消息  PS：", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: [
        //           TextSpan(text: 'Android 10和11 flutter_toast有bug，设置位置和style无效，后续考虑使用flutter_easyloading来替换', style: TextStyle(color: Colors.red)),
        //         ]),
        //         textDirection: TextDirection.ltr,
        //       ),
        //     ),

        //     ListTile(
        //         leading: Icon(Icons.navigate_next, color: Colors.blue),
        //         trailing: Icon(Icons.send, color: Colors.blue),
        //         title: Text('同步代码异常处理'),
        //         subtitle: Text('try-catch-finally'),
        //         onTap: () {}),
        //     ListTile(
        //         leading: Icon(Icons.navigate_next, color: Colors.blue),
        //         trailing: Icon(Icons.send, color: Colors.blue),
        //         title: Text('异步代码/定时器/流异常处理'),
        //         subtitle: Text('runZonedGuarded'),
        //         onTap: () {}),
        //     ListTile(
        //         leading: Icon(Icons.navigate_next, color: Colors.blue),
        //         trailing: Icon(Icons.send, color: Colors.blue),
        //         title: Text('整个App异常处理'),
        //         subtitle: Text('FlutterError.onError'),
        //         onTap: () {}),
        //   ],
        // )),
        );
  }
}
