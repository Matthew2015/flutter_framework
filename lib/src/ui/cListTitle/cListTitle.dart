/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-06-30 16:47:35
 * @LastEditTime: 2021-07-01 15:40:39
 */

import 'package:flutter/material.dart';

class CListTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData leadIcon;
  final IconData trailIcon;
  final Function callback;
  final double fontSize;
  final double fontSizeSub;
  CListTitle({this.title, this.subTitle = '', this.leadIcon, this.trailIcon, this.callback, this.fontSize = 16, this.fontSizeSub = 14});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(leadIcon, size: fontSize),
              Container(width: 10),
              Text(
                title,
                style: TextStyle(fontSize: fontSize),
              ),
            ]),
            Row(children: [
              Text(subTitle,
                  style: TextStyle(
                    fontSize: fontSizeSub,
                    color: Colors.grey,
                  )),
              Container(width: 10),
              Icon(trailIcon, size: fontSize)
            ]),
          ])),
      onTap: () {
        callback();
      },
    );
    // ListTile(
    //     leading: Icon(leadIcon, size: fontSize),
    //     trailing: Icon(trailIcon, size: fontSize),
    //     title: _listTitleAlign(title),
    //     onTap: () {
    //       callback();
    //     });
  }

  // Widget _listTitleAlign(String title) {
  //   return Align(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(fontSize: fontSize),
  //         ),
  //         Text(subTitle,
  //             style: TextStyle(
  //               fontSize: fontSizeSub,
  //               color: Colors.grey,
  //             ))
  //       ],
  //     ),
  //     alignment: const Alignment(-1.2, 0),
  //   );
  // }
}
