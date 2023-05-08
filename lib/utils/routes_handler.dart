import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/utils/routes_name.dart';
import 'package:untitled7/views/setting/setting_page.dart';

Route<dynamic> generateRoutes(RouteSettings settings){
  switch(settings.name){
    case RoutesName.homePage:
      return MaterialPageRoute(builder: (context)=> Setting());

    default:
      return MaterialPageRoute(builder: (context)=> Setting());


  }
}