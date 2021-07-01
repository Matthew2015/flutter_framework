/*
 * @Descripttion: Framework Log模块使用例子 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-24 17:22:03
 */
import 'package:flutter/material.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleLogPage extends StatefulWidget {
  ExampleLogPage({Key key}) : super(key: key);

  @override
  _ExampleLogPageState createState() => _ExampleLogPageState();
}

class _ExampleLogPageState extends State<ExampleLogPage> {
  String _log = '';
  @override
  void initState() {
    Log.setParms(lineLength: 200);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logger Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Log模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text: TextSpan(
                  text: "Framework Log 模块，封装了logger 和 path_provider 库，提供各种级别的日志方法，通过传参可通知是否将日志写本地文件，后续有远程日志系统，可以扩展将日志内容传到远端的日志系统，具体使用可参考下面例子",
                  style: TextStyle(color: Color(0xAA333333), fontSize: 16),
                  children: []),
              textDirection: TextDirection.ltr,
            ),
          ),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('Verbose'),
              onTap: () {
                Log.verbose('Verbose log');
                getLog();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('Debug'),
              onTap: () {
                Log.debug('Debug log');
                getLog();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('Info'),
              onTap: () {
                Log.info('Info log');
                getLog();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('Warning'),
              onTap: () {
                Log.warning('Warning log');
                getLog();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('Error'),
              onTap: () {
                Log.error('Error log');
                getLog();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('WTF'),
              onTap: () {
                Log.wtf('What a terrible failure log');
                getLog();
              }),
          Container(
              // width: 100,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              height: 200,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: RichText(
                    text: TextSpan(text: "日志：", style: TextStyle(color: Color(0xAA333333), fontSize: 18), children: [
                      TextSpan(text: _log, style: TextStyle(color: Color(0xAACE1928))),
                    ]),
                    textDirection: TextDirection.ltr,
                  ))),
        ],
      )),
    );
  }

  Future<String> getLog() {
    Future.delayed(Duration(seconds: 1), () async {
      String s = await Log.openConsole();
      setState(() {
        _log = s;
      });
    });
  }
}
