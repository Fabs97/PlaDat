import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/company_placement_list/company_placement_list.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:frontend/screens/company_student_list/company_student_list.dart';
import 'package:frontend/screens/login/login.dart';
import 'package:frontend/screens/new_placement/new_placement.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:frontend/screens/registration/registration.dart';
import 'package:frontend/screens/student_matches_list/student_matches_file.dart';
import 'package:frontend/screens/student_placement_list/student_placement_list.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        {
          return _createRoute(FirstPage(), settings);
        }
      case '/student-list':
        {
          return _createRoute(StudentCardsList(), settings);
        }
      case '/placement-list':
        {
          return _createRoute(PlacementCardsList(), settings);
        }
      case '/new-placement':
        {
          return _createRoute(NewPlacement(), settings);
        }
      case '/new-student':
        {
          return _createRoute(NewStudent(), settings);
        }
      case '/company-placements':
        {
          return _createRoute(MyPlacements(), settings);
        }
      case '/registration':
        {
          return _createRoute(Registration(), settings);
        }
      case '/student-matches':
        {
          return _createRoute(StudentMatches(), settings);
        }
      case '/chat-screen':
        {
          return _createRoute(
              ChatScreen(
                args: settings.arguments,
              ),
              settings);
        }
      case "/login":
        {
          return _createRoute(
              Login(
                isAfterAuthError: settings.arguments ?? false,
              ),
              settings);
        }
      default:
        {
          return _errorRoute();
        }
    }
  }

  static Route<dynamic> _createRoute(Widget screen, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
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

class Nav {
  static final navigatorKey = GlobalKey<NavigatorState>();
}
