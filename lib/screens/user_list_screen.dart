import 'package:flutter/material.dart';
import 'package:flutter_basic/providers/user_provider.dart';
import 'package:flutter_basic/screens/create_user_screen.dart';
import 'package:flutter_basic/screens/update_user_screen.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

void _confirmDelete(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete User"),
        content: const Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              await context.read<UserProvider>().deleteUser(id);
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UserProvider>().loadUsers(refresh: true);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateUserScreen()),
              );

              context.read<UserProvider>().loadUsers(refresh: true);
            },
          ),
        ],
      ),

      body: Column(
        children: [
          /// Search Box
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search user...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final provider = context.read<UserProvider>();
                provider.search = value;

                provider.loadUsers(refresh: true);
              },
            ),
          ),

          /// Loading
          if (provider.isLoading && provider.users.isEmpty)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          /// Error
          else if (provider.error != null)
            Expanded(child: Center(child: Text(provider.error!)))
          /// User List
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<UserProvider>().loadUsers(refresh: true);
                },
                child: ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    final user = provider.users[index];

                    return ListTile(
                      title: Text(user.userName),
                      subtitle: Text(user.email),

                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditUserScreen(user: user),
                          ),
                        );

                        context.read<UserProvider>().loadUsers(refresh: true);
                      },

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDelete(context, user.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
