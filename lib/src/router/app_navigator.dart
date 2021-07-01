/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:00:13
 * @LastEditTime: 2021-06-07 22:14:39
 */
import 'package:flutter/material.dart';
import './route_arguments.dart';

class APPNavigator {
  static pushNamed(BuildContext context, String routeId, {params, popCallback}) {
    RouteArguments routeArgument = new RouteArguments();
    routeArgument.params = params;
    Navigator.pushNamed(context, routeId, arguments: routeArgument).then((data) {
      if (popCallback != null) popCallback(data);
    });
  }

  static pushReplacement(BuildContext context, String routeId, {params}) {
    RouteArguments routeArgument = new RouteArguments();
    routeArgument.params = params;
    Navigator.pushReplacementNamed(context, routeId, arguments: routeArgument);
  }

  static pushNamedAndRemoveUntil(BuildContext context, String routeId, {params}) {
    RouteArguments routeArgument = new RouteArguments();
    routeArgument.params = params;
    Navigator.of(context).pushNamedAndRemoveUntil(routeId, (Route<dynamic> route) => false, arguments: routeArgument);
  }

  static pushNamedAndRemoveUntilName(BuildContext context, String newRouteId, String oldRouteId, {params}) {
    RouteArguments routeArgument = new RouteArguments();
    routeArgument.params = params;
    Navigator.of(context).pushNamedAndRemoveUntil(newRouteId, ModalRoute.withName('/oldRouteId'), arguments: routeArgument);
  }

  static popUtil(BuildContext context, String routeId) {
    Navigator.popUntil(context, ModalRoute.withName(routeId));
  }

  static pop(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}
