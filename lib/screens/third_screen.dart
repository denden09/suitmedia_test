import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ThirdScreen
    extends StatefulWidget {
  const ThirdScreen(
      {super.key});

  @override
  State<ThirdScreen> createState() =>
      _ThirdScreenState();
}

class _ThirdScreenState
    extends State<ThirdScreen> {
  final ScrollController
      _scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        final provider =
            context.read<
                UserProvider>();

        if (provider.users
            .isEmpty) {
          provider.fetchUsers();
        }
      },
    );

    _scrollController
        .addListener(() {
      if (_scrollController
              .position.pixels >=
          _scrollController
              .position
              .maxScrollExtent) {
        context
            .read<UserProvider>()
            .loadMore();
      }
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Third Screen"),
      ),
      body: Consumer<
          UserProvider>(
        builder: (
          context,
          provider,
          child,
        ) {
          if (provider.isLoading &&
              provider.users
                  .isEmpty) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (provider.users
              .isEmpty) {
            return RefreshIndicator(
              onRefresh: provider
                  .refreshUsers,
              child: ListView(
                children: const [
                  SizedBox(
                    height: 300,
                  ),
                  Center(
                    child: Text(
                        "No Users Found"),
                  )
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh:
                provider.refreshUsers,
            child: ListView.builder(
              controller:
                  _scrollController,
              itemCount:
                  provider.users.length,
              itemBuilder:
                  (context, index) {
                final user =
                    provider
                        .users[index];

                return ListTile(
                  leading:
                      CircleAvatar(
                    backgroundImage:
                        NetworkImage(
                      user.avatar,
                    ),
                  ),
                  title: Text(
                    user.fullName,
                  ),
                  subtitle: Text(
                    user.email,
                  ),
                  onTap: () {
                    provider
                        .setSelectedUser(
                      user.fullName,
                    );

                    Navigator.pop(
                        context);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}