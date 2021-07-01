/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-06-07 22:14:58
 */
import 'package:example/router.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

class BlankPage extends StatefulWidget {
  dynamic params;
  BlankPage({Key key, this.params}) : super(key: key);
  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // RichText(
          //   textAlign: TextAlign.end,
          //   text: TextSpan(children: <InlineSpan>[
          //     TextSpan(text: '路由入参：'),
          //     TextSpan(
          //       text: widget.params.params == null ? '未传参' : widget.params?.params['p1test'],
          //     ),
          //   ]),
          // )
          RichText(
            text: TextSpan(text: "路由入参：", style: TextStyle(color: Color(0xAA333333), fontSize: 18), children: [
              TextSpan(text: widget.params.params == null ? '未传参' : widget.params?.params['p1test'], style: TextStyle(color: Color(0xAACE1928))),
            ]),
            textDirection: TextDirection.ltr,
          ),
          ElevatedButton(
              onPressed: () {
                APPNavigator.pop(context);
              },
              child: Text('跳转（带返回）')),
        ]),
      ),
    );
  }
}
