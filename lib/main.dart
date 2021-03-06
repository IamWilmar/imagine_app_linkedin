import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/providers/custom_tabbar_provider.dart';
import 'package:imagine_app_linkedin/providers/login_provider.dart';
import 'package:imagine_app_linkedin/providers/post_list_provider.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
import 'package:imagine_app_linkedin/providers/radio_button_provider.dart';
import 'package:imagine_app_linkedin/providers/users_provider.dart';
import 'package:imagine_app_linkedin/routes/routes.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => CustomtabBarProvider()),
        ChangeNotifierProvider(create: (_) => PostListProvider()),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Imagine App LinkedIn',
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
