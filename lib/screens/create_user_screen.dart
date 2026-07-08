import 'package:flutter/material.dart';
import 'package:flutter_basic/models/user_create_request.dart';
import 'package:flutter_basic/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isAdmin = false;

  Future<void> saveUser() async {
    final request = UserCreateRequest(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      userName: usernameController.text,
      email: emailController.text,
      password: passwordController.text,

      roleName: "Admin",
      roleId: 1,
      isAdmin: isAdmin,
      statusId: 1,
    );

    try {
      await context.read<UserProvider>().createUser(request);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Create User Success"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<UserProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text("Create User")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),

            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            CheckboxListTile(
              title: const Text("Admin"),

              value: isAdmin,

              onChanged: (value) {
                setState(() {
                  isAdmin = value ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : saveUser,

              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
