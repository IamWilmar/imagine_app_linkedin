import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
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
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
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