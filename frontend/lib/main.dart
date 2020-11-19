import 'package:flutter/material.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: Nav.navigatorKey,
      initialRoute: "/home",
      onGenerateRoute: RoutesGenerator.generateRoute,
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "PlaDat"),
      drawer: CustomDrawer.createDrawer(context),
      body: Center(
        child: Text("Welcome to PlaDat!"),
      ),
    );
  }
}
