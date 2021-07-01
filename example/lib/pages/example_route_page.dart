/*
 * @Descripttion: Framework 路由模块使用例子
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-24 15:37:20
 */
import 'package:example/router.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleRoutePage extends StatefulWidget {
  ExampleRoutePage({Key key}) : super(key: key);

  @override
  _ExampleRoutePageState createState() => _ExampleRoutePageState();
}

class _ExampleRoutePageState extends State<ExampleRoutePage> {
  @override
  void initState() {
    super.initState();
    LiveRoute.singleton.register(); // 注册路由
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Router Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Router 模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text: TextSpan(
                  text: "Framework Router 模块，封装了 Navigator 库，对上层应用提供不带参数跳转、带参数跳转、带回调跳转，具体使用可参考下面例子", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: []),
              textDirection: TextDirection.ltr,
            ),
          ),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('跳转（不带参数）'),
              onTap: () {
                APPNavigator.pushNamed(context, '/Blank');
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('跳转（带参数）'),
              onTap: () {
                APPNavigator.pushNamed(context, '/Blank', params: {'p1test': 'p1test'});
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('跳转（带返回）'),
              onTap: () {
                APPNavigator.pushNamed(context, '/Blank', popCallback: callbackExample);
              }),
        ],
      )),
    );
  }

  void callbackExample(data) {
    toast(msg: '返回的回调消息', position: Position.CENTER);
  }
}
