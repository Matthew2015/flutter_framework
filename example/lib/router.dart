/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:11:30
 * @LastEditTime: 2021-06-25 11:23:08
 */
import 'package:example/pages/customWidget/timer_widget_page.dart';
import 'package:framework/framework.dart';
import 'pages/blank_page.dart';
import 'pages/example_route_page.dart';

Map<String, Function> route = <String, Function>{
  RouterConstants.ROUTER_EXAMPLE: (context, {arguments}) => ExampleRoutePage(),
  RouterConstants.BLANK: (context, {arguments}) => BlankPage(params: arguments),
  RouterConstants.BLANK_WITH_ARGUMENTS: (context, {arguments}) => BlankPage(params: arguments),
  RouterConstants.BLANK_WITH_CALLBACK: (context, {arguments}) => BlankPage(params: arguments),
  RouterConstants.UI_TIMER: (context, {arguments}) => TimerWidgetPage(),
};

class LiveRoute {
  LiveRoute._() {
    LiveRoute();
  }

  static LiveRoute _instance;

  static LiveRoute get singleton {
    if (_instance == null) {
      _instance = LiveRoute._();
    }
    return _instance;
  }

  LiveRoute();

  register() {
    AppRoute.registePage(route);
  }
}

class RouterConstants {
  static const ROUTER_EXAMPLE = '/RouteExample';
  static const BLANK = '/Blank';
  static const BLANK_WITH_ARGUMENTS = '/BlankWithArguments';
  static const BLANK_WITH_CALLBACK = '/BlankWithCallback';
  static const UI_TIMER = '/TimerWidget';
}
