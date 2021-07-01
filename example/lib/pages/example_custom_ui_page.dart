/*
 * @Descripttion: Framework toast 封装使用例子
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-25 11:24:20
 */
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleCustomUIPage extends StatefulWidget {
  ExampleCustomUIPage({Key key}) : super(key: key);

  @override
  _ExampleCustomUIPageState createState() => _ExampleCustomUIPageState();
}

class _ExampleCustomUIPageState extends State<ExampleCustomUIPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom UI Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '客制化UI组件模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text: TextSpan(text: "Framework 客制化UI组件 模块，将项目中特殊的组件抽象，方便移植其他项目", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: []),
              textDirection: TextDirection.ltr,
            ),
          ),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('计时器'),
              onTap: () {
                APPNavigator.pushNamed(context, '/TimerWidget');
              }),
        ],
      )),
    );
  }
}
