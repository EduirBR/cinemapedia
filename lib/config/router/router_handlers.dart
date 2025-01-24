import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///Add a view for any user
RouteBase addRoute(
    {required String path,
    required String name,
    Widget? view,
    GoRouterPageBuilder? builder}) {
  return GoRoute(
    name: name,
    path: path,
    // builder: (context, state) => view, // this is the default way
    pageBuilder: builder ??
        (context, state) {
          if (view == null) {
            throw Exception('view must be defined if builder inst');
          }
          return customTransitionBuild(view);
        },
  );
}

///Transition build if needed
CustomTransitionPage<dynamic> customTransitionBuild(Widget view) {
  return CustomTransitionPage(
      transitionDuration: Duration.zero, //used to mute the transitions
      reverseTransitionDuration: Duration.zero, //used to mute the transitions
      child: view, //view is the widget to show
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      });
}
