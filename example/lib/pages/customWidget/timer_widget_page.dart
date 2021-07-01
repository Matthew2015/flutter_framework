/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-06-25 11:21:09
 * @LastEditTime: 2021-06-25 13:37:29
 */
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

class TimerWidgetPage extends StatefulWidget {
  TimerWidgetPage({Key key}) : super(key: key);
  @override
  _TimerWidgetPageState createState() => _TimerWidgetPageState();
}

class _TimerWidgetPageState extends State<TimerWidgetPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Router Example Page'),
      ),
      body: FlutterTimeCounter(bgColor: Colors.blue),
    );
  }
}
