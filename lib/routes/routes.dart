import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/pages/home_page.dart';
import 'package:imagine_app_linkedin/pages/login_page.dart';
import 'package:imagine_app_linkedin/pages/post_page.dart';

//Rutas de las paginas: Usadas en main.dart
final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login'     : (_) => LogInPage(),
  'home'      : (_) => HomePage(),
  'post'      : (_) => PostPage(),
};