/*
 * @Descripttion: fluttertoast封装
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 18:09:31
 * @LastEditTime: 2021-06-30 14:05:00
 */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Position { TOP, BOTTOM, CENTER }

/// @descripttion: 弹消息
/// @param {String msg 消息内容，Position position 位置信息}
/// @return {*}
void toast({@required String msg, Position position = Position.CENTER}) {
  ToastGravity gravity;
  switch (position) {
    case Position.TOP:
      gravity = ToastGravity.TOP;
      break;
    case Position.CENTER:
      gravity = ToastGravity.CENTER;
      break;
    case Position.BOTTOM:
      gravity = ToastGravity.BOTTOM;
      break;
    default:
      gravity = ToastGravity.CENTER;
  }
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: gravity, timeInSecForIosWeb: 1, backgroundColor: Colors.grey, textColor: Colors.black, fontSize: 16.0);
  // backgroundColor: ThemeColors.primary,
  // textColor: ThemeColors.greyFont,
  // fontSize: ThemeColors.fontSize);
}
