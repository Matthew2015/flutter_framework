/*
 * @Descripttion: Framework http 网络请求封装使用例子
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:16:17
 * @LastEditTime: 2021-07-01 17:28:37
 */
import 'package:flutter/material.dart';
import 'package:framework/framework.dart'; // 引入framework

class ExampleHttpPage extends StatefulWidget {
  ExampleHttpPage({Key key}) : super(key: key);

  @override
  _ExampleHttpPageState createState() => _ExampleHttpPageState();
}

class _ExampleHttpPageState extends State<ExampleHttpPage> {
  @override
  void initState() {
    super.initState();
  }

  static Map<String, dynamic> params = {
    "headers":
        '{"X-Api-Client-App-Version": "2.3.0","X-Api-Client-Language": "zh_CN","X-Api-Client-Origin": "https://qa.xxxxxxxxxx.com","X-Api-Client-System": "pc","X-Api-Client-Terminal": "pc","X-Api-Client-Terminal-Version": 0,"X-Api-Client-Unit-Id": 487}',
    "host": "https://qa.xxxxxxxxxx.com",
    "userId": "123123",
    "accessToken":
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJtYWluUm9sZVR5cGUiOjEsInVzZXJfbmFtZSI6IjE4NjAyMDM3MDM0IiwidGVybWluYWwiOiJwYzNpY2xhc3MiLCJ1c2VySWQiOiIxMjQzNjUiLCJjbGllbnRfaWQiOiIxIiwiY3VycmVudFNvZnRTeXN0ZW0iOiJwY2xpdmUiLCJleHBpcmVUaW1lIjoxNjIwOTI3NzczODY5LCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXSwidXNlclN5c3RlbSI6ImJ1c2luZXNzIiwiZXhwIjoxNjIwOTI3NzczLCJqdGkiOiIzNjdhMjQ1ZS0yODI5LTQ5ODEtODk2Ni04OThmNWZjMTYyMzgiLCJjdXJyZW50RG9tYWluVHlwZSI6MSwiY3VycmVudFVuaXRJZCI6IjMifQ.LjpFKpO7zYf1U0xDd2MXFp1CBHF0s_QMqSs-Lnu_RSnNcg9pecJAubZy_S9gsDTvwWq_keco_NooU86n5-SLcdJg-JH6M_EyeU6Smcy_p89HIRbg7MgH7fzEEzSnzqYqMR7imOSqnicDHUAQ8AFHx8nbYpZLRG4W6pj57DwTrPsif3j3il_d3XjewVC5KDEzYX8NsjPJzP6CxTWidVZFB_CaDvZJG7t7-5X3pCxHFpwYERg4WnAOK0ert23MqlMQ6OUCYWqcxXIEbgS6iTacBoyzBDbsjFNuwov8Lumra7vfSDtvt7unRa_BpmfID40GbzxOJbkoqtbQHIjE2GLDHw"
  };
  final NativeParms initParams = NativeParms.fromJson(params);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Example Page'),
      ),
      body: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'HTTP模块',
                    style: TextStyle(fontSize: 24),
                  ))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: RichText(
              text: TextSpan(
                  text: "Framework HTTP 模块，封装了Dio 库，对上层应用提供设置Header、设置Bearer Token、设置BaseUrl方法，封装了GET、POST、PATCH等类型请求，具体使用可参考下面例子",
                  style: TextStyle(color: Color(0xAA333333), fontSize: 16),
                  children: []),
              textDirection: TextDirection.ltr,
            ),
          ),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('设置请求头'),
              onTap: () {
                setHeaders(initParams.headers.headers);
                toast(msg: initParams.headers.headers.toString());
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('设置accessToken'),
              onTap: () {
                setToken(initParams.accessToken);
                toast(msg: initParams.accessToken);
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('设置BaseUrl'),
              onTap: () {
                setBaseUrl(initParams.baseUrl);
                toast(msg: initParams.baseUrl);
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('get 请求'),
              onTap: () {
                getTest();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('post 请求'),
              onTap: () {
                postTest();
              }),
          ListTile(
              leading: Icon(Icons.navigate_next, color: Colors.blue),
              trailing: Icon(Icons.send, color: Colors.blue),
              title: Text('patch 请求'),
              onTap: () {
                patchTest();
              }),
          // ElevatedButton(
          //   child: Text('post'),
          //   onPressed: () {
          //     Map<String, dynamic> parm = {
          //       "headers":
          //           '{"X-Api-Client-App-Version": "2.3.0","X-Api-Client-Language": "zh_CN","X-Api-Client-Origin": "https://qa.xxxxxxxxxx.com","X-Api-Client-System": "pclive","X-Api-Client-Terminal": "pc3iclass","X-Api-Client-Terminal-Version": 0,"X-Api-Client-Unit-Id": 487}',
          //       "host": "https://qa.xxxxxxxxxx.com",
          //       "userId": "123123",
          //       "accessToken":
          //           "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJtYWluUm9sZVR5cGUiOjEsInVzZXJfbmFtZSI6IjE4NjAyMDM3MDM0IiwidGVybWluYWwiOiJwYzNpY2xhc3MiLCJ1c2VySWQiOiIxMjQzNjUiLCJjbGllbnRfaWQiOiIxIiwiY3VycmVudFNvZnRTeXN0ZW0iOiJwY2xpdmUiLCJleHBpcmVUaW1lIjoxNjIwOTI3NzczODY5LCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXSwidXNlclN5c3RlbSI6ImJ1c2luZXNzIiwiZXhwIjoxNjIwOTI3NzczLCJqdGkiOiIzNjdhMjQ1ZS0yODI5LTQ5ODEtODk2Ni04OThmNWZjMTYyMzgiLCJjdXJyZW50RG9tYWluVHlwZSI6MSwiY3VycmVudFVuaXRJZCI6IjMifQ.LjpFKpO7zYf1U0xDd2MXFp1CBHF0s_QMqSs-Lnu_RSnNcg9pecJAubZy_S9gsDTvwWq_keco_NooU86n5-SLcdJg-JH6M_EyeU6Smcy_p89HIRbg7MgH7fzEEzSnzqYqMR7imOSqnicDHUAQ8AFHx8nbYpZLRG4W6pj57DwTrPsif3j3il_d3XjewVC5KDEzYX8NsjPJzP6CxTWidVZFB_CaDvZJG7t7-5X3pCxHFpwYERg4WnAOK0ert23MqlMQ6OUCYWqcxXIEbgS6iTacBoyzBDbsjFNuwov8Lumra7vfSDtvt7unRa_BpmfID40GbzxOJbkoqtbQHIjE2GLDHw"
          //     };
          //     NativeParms p = NativeParms.fromJson(parm);
          //     print(p);
          //     ClassliveHeaders.setHeaders(p.headers.headers);
          //     DioClient.accessToken = p.accessToken;
          //     DioBase.setBaseUrl(p.baseUrl);
          //     postTest();
          //   },
          // ),
        ],
      )),
    );
  }

  /// @descripttion: 设置自定义Header
  /// @param {headers}
  /// @return {*}
  void setHeaders(Map<String, dynamic> headers) {
    ClassliveHeaders.setHeaders(initParams.headers.headers);
  }

  /// @descripttion: 设置accessToken
  /// @param {token}
  /// @return {*}
  void setToken(String token) {
    DioClient.accessToken = token;
  }

  /// @descripttion: 设置接口域名
  /// @param {baseUrl}
  /// @return {*}
  void setBaseUrl(String baseUrl) {
    DioBase.setBaseUrl(baseUrl);
  }

  /// @descripttion: POST 请求
  /// @param {*}
  /// @return {*}
  postTest() async {
    var requestParam = {
      'roomId': '0',
      'type': [700],
      'remark': 'password'
    };
    dynamic res = await handleException<dynamic>(LiveClassClient.post<dynamic>('/service/api/interactive/v1/logs', params: requestParam));
    print(res);
  }

  /// @descripttion: GET 请求
  /// @param {*}
  /// @return {*}
  getTest() async {
    dynamic res = await handleException<dynamic>(LiveClassClient.get<dynamic>('https://qa.xxxxxxxxxx.com/service/api/interactive/v1/update/windows?version=3.1.0&region='));
    print(res);
  }

  /// @descripttion: PATCH 请求
  /// @param {*}
  /// @return {*}
  patchTest() async {
    var requestParam = {'competitionId': '0'};
    dynamic res = await handleException<dynamic>(LiveClassClient.patch<dynamic>('/service/api/interactive/v1/competition/:competitionId/closing', params: requestParam));
    print(res);
  }
}
