/*
 * @Descripttion: Framework toast 封装使用例子
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-24 15:30:51
 */
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleToastPage extends StatefulWidget {
  ExampleToastPage({Key key}) : super(key: key);

  @override
  _ExampleToastPageState createState() => _ExampleToastPageState();
}

class _ExampleToastPageState extends State<ExampleToastPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toast Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Toast模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text: TextSpan(text: "Framework Toast 模块，封装了Flutter_toast 库，对上层应用提供上、中、下三个位置的弹出消息  PS：", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: [
                TextSpan(text: 'Android 10和11 flutter_toast有bug，设置位置和style无效，后续考虑使用flutter_easyloading来替换', style: TextStyle(color: Colors.red)),
              ]),
              textDirection: TextDirection.ltr,
            ),
          ),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('上方弹出'),
              onTap: () {
                toast(msg: '上方toast', position: Position.TOP);
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('居中弹出'),
              onTap: () {
                toast(msg: '居中toast');
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('底部弹出'),
              onTap: () {
                toast(msg: '底部toast', position: Position.BOTTOM);
              }),
        ],
      )),
    );
  }
}
