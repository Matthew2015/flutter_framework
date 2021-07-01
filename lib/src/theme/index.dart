/*
 * @Descripttion: app主题封装
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 18:16:11
 * @LastEditTime: 2021-05-20 18:22:06
 */
import 'package:flutter/material.dart';

class ThemeColors {
  static Color primary = Color.fromRGBO(148, 160, 255, 1);
  static Color primaryDark = Color.fromRGBO(120, 135, 245, 1);

  /// 半透明
  static Color primaryTransparent = Color.fromRGBO(148, 160, 255, 0.5);

  /// 边框颜色
  static Color border = Colors.black12;

  ///黑色字体
  static Color blackMainFont = Color(0xff333333);
  static Color blackSecondFont = Color(0xff666666);
  static Color blackThirdFont = Color(0xff999999);

  ///  灰色字体
  static Color greyFont = Colors.black45;

  static Color success = Color(0xff44bb00);
  static Color danger = Color(0xffff4444);
  static Color warning = Color(0xffff976a);
  static Color info = Color(0xff909399);

  ///输入框颜色
  static Color inputBg = Color(0xffF5F5F8);

  /// 页面背景色
  static Color pageBackground = Colors.white;

  static double fontSize = 16;
}
