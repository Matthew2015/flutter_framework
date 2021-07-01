/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-05-20 19:00:13
 * @LastEditTime: 2021-05-20 19:21:34
 */
class AppRoute {
  static Map<String, Function> allPages = new Map<String, Function>();

  static registePage(Map<String, Function> pages) {
    allPages.addAll(pages);
  }

  static getAllRoute() {
    return allPages;
  }
}
