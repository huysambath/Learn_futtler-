import 'package:flutter/material.dart';
import 'package:flutter_basic/providers/auth_provider.dart';
import 'package:flutter_basic/providers/user_provider.dart';
import 'package:flutter_basic/screens/home_screen.dart';
import 'package:flutter_basic/screens/login_screen.dart' show LoginScreen;
import 'package:flutter_basic/screens/splash_screen.dart';
import 'package:flutter_basic/screens/user_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/splash": (_) => const SplashScreen(),
        "/login": (_) => const LoginScreen(),
        "/home": (_) => const HomeScreen(),
        "/user": (_) => const UserListScreen()
      },
    );
  }
}
