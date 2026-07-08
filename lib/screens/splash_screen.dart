// import 'package:flutter/material.dart';
// import 'package:flutter_basic/providers/auth_provider.dart';
// import 'package:flutter_basic/screens/login_screen.dart';
// import 'package:flutter_basic/screens/user_list_screen.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkLogin();
//   }

//   Future<void> checkLogin() async {
//     final authProvider = context.read<AuthProvider>();

//     await Future.wait([
//       authProvider.checkLogin(),
//       Future<void>.delayed(const Duration(seconds: 3)),
//     ]);

//     await authProvider.checkLogin();

//     if (!mounted) return;

//     if (authProvider.isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const UserListScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset("assets/images/image-removebg-preview.png"),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_basic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final auth = context.read<AuthProvider>();

    await auth.checkLogin();

    if (!mounted) return;

    if (auth.isLoggedIn) {
      Navigator.pushReplacementNamed(context, "/user");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}