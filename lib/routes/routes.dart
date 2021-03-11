import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/pages/home_page.dart';
import 'package:imagine_app_linkedin/pages/login_page.dart';
import 'package:imagine_app_linkedin/pages/post_page.dart';
import 'package:imagine_app_linkedin/pages/register_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login'     : (_) => LogInPage(),
  'register'  : (_) => RegisterPage(),
  'home'      : (_) => HomePage(),
  'post'      : (_) => PostPage(),
};