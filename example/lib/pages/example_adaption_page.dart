/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-24 18:46:42
 */
import 'package:flutter/material.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleAdaptionPage extends StatefulWidget {
  ExampleAdaptionPage({Key key}) : super(key: key);

  @override
  _ExampleAdaptionPageState createState() => _ExampleAdaptionPageState();
}

class _ExampleAdaptionPageState extends State<ExampleAdaptionPage> {
  var _switchValue = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Adaption Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '屏幕适配测试模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text:
                  TextSpan(text: "Framework 屏幕适配测试模块，集成device_preview工具，可以查看在各种设备中的应用的UI表现，具体使用可参考下面例子。PS: ", style: TextStyle(color: Color(0xAA333333), fontSize: 16), children: [
                TextSpan(text: '切换开关后，需要重启app才能看到效果', style: TextStyle(color: Colors.red)),
              ]),
              textDirection: TextDirection.ltr,
            ),
          ),
          SwitchListTile(
            title: Text('是否打开设备预览'),
            value: _switchValue ?? false,
            onChanged: (value) {
              setState(() {
                setLoacalAdaption(value);
              });
            },
          )
        ],
      )),
    );
  }

  void setLoacalAdaption(value) {
    Storage.set('adaption', value);
    setState(() {
      _switchValue = value;
    });
    toast(msg: '已设置，重启app生效', position: Position.CENTER);
  }
}
