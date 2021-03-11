import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imagine App LinkedIn',
      initialRoute: 'home',
      routes: appRoutes,
    );
  }
}