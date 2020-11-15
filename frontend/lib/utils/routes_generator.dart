import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/company_student_list/company_student_list.dart';
import 'package:frontend/screens/new_placement/new_placement.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:frontend/screens/student_placement_list/student_placement_list.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        {
          return MaterialPageRoute(builder: (_) => FirstPage());
        }
      case '/student-list':
        {
          return MaterialPageRoute(builder: (_) => StudentCardsList());
        }
      case '/placement-list':
        {
          return MaterialPageRoute(builder: (_) => PlacementCardsList());
        }
      case '/new-placement':
        {
          return MaterialPageRoute(builder: (_) => NewPlacement());
        }
      case '/new-student':
        {
          return MaterialPageRoute(builder: (_) => NewStudent());
        }  
      default:
        {
          return _errorRoute();
        }
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("ERROR IN ROUTING"),
        ),
      );
    });
  }
}
