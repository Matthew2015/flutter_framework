/*
 * @Descripttion: Framework Storage 使用例子
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-24 19:06:47
 */
import 'package:flutter/material.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleStoragePage extends StatefulWidget {
  ExampleStoragePage({Key key}) : super(key: key);

  @override
  _ExampleStoragePageState createState() => _ExampleStoragePageState();
}

class _ExampleStoragePageState extends State<ExampleStoragePage> {
  var _radioGroupValue = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '本地存储模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text:
                  TextSpan(text: "Framework 本地存储模块，封装了shared_preferences 库，对上层应用提供Get,Set两个方法，具体使用可参考下面例子", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: []),
              textDirection: TextDirection.ltr,
            ),
          ),
          Column(children: [
            RadioListTile(
              title: Text('set storage = value1 where key= key 1'),
              value: 'value1',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setValue(value);
              },
            ),
            RadioListTile(
              title: Text('set storage = value2 where key= key 1'),
              value: 'value2',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setValue(value);
              },
            ),
            RadioListTile(
              title: Text('set storage = value3 where key= key 1'),
              value: 'value3',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setValue(value);
              },
            ),
          ]),
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: ElevatedButton(
              child: Text('Get storage value where key = key1'),
              onPressed: () async {
                var s = await Storage.get('key1');
                toast(msg: s.toString(), position: Position.CENTER);
              },
            ),
          )
        ],
      )),
    );
  }

  void setValue(value) {
    setState(() {
      _radioGroupValue = value;
    });
    Storage.set('key1', value);
  }
}
