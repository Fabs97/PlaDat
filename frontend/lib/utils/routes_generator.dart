import 'package:flutter/material.dart';
import 'package:frontend/screens/company_placement_list/company_placement_list.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:frontend/screens/company_student_list/company_student_list.dart';
import 'package:frontend/screens/login/login.dart';
import 'package:frontend/screens/new_employer/new_employer.dart';
import 'package:frontend/screens/new_placement/new_placement.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:frontend/screens/profile/profile.dart';
import 'package:frontend/screens/registration/registration.dart';
import 'package:frontend/screens/student_matches_list/student_matches_list.dart';
import 'package:frontend/screens/student_placement_list/student_placement_list.dart';
import 'package:frontend/services/auth_service.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
      case '/profile':
        {
          return _createRoute(Profile(profile: settings.arguments), settings);
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
      case "/employer-home":
        {
          return _createRoute(StudentCardsList(), settings);
        }
      case "/student-home":
        {
          return _createRoute(PlacementCardsList(), settings);
        }
      case '/new-employer':
        {
          return _createRoute(NewEmployer(), settings);
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
          centerTitle: true,
          title: Text("Error"),
          elevation: 0,
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
  static final currentState = navigatorKey.currentState;
}
