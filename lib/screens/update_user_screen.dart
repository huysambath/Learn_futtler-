import 'package:flutter/material.dart';
import 'package:flutter_basic/models/user.dart';
import 'package:flutter_basic/models/user_update_request.dart';
import 'package:flutter_basic/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController roleNameController;
  late TextEditingController roleIdController;
  late TextEditingController statusIdController;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    usernameController = TextEditingController(text: widget.user.userName);
    emailController = TextEditingController(text: widget.user.email);
    roleNameController = TextEditingController(text: widget.user.roleName);
    roleIdController = TextEditingController(
      text: widget.user.roleId.toString(),
    );
    statusIdController = TextEditingController(text: "1");
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    roleNameController.dispose();
    roleIdController.dispose();
    statusIdController.dispose();

    super.dispose();
  }

  Future<void> updateUser() async {
    if (!_formKey.currentState!.validate()) return;

    final request = UserUpdateRequest(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      userName: usernameController.text,
      email: emailController.text,
      roleName: roleNameController.text,
      roleId: int.parse(roleIdController.text),
      statusId: int.parse(statusIdController.text),
    );

    try {
      await context.read<UserProvider>().updateUser(widget.user.id, request);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User Updated")));

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField(firstNameController, "First Name"),

              buildTextField(lastNameController, "Last Name"),

              buildTextField(usernameController, "Username"),

              buildTextField(emailController, "Email"),

              buildTextField(roleNameController, "Role Name"),

              buildTextField(roleIdController, "Role ID"),

              buildTextField(statusIdController, "Status ID"),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : updateUser,
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
