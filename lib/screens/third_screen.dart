import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

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
        .addPostFrameCallback((_) {
      final provider =
          context.read<UserProvider>();

      if (provider.users.isEmpty) {
        provider.fetchUsers();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController
              .position.pixels >=
          _scrollController.position
              .maxScrollExtent) {
        context
            .read<UserProvider>()
            .loadMore();
      }
    });
  }

  Widget buildUserCard(
      UserProvider provider,
      int index) {
    final user =
        provider.users[index];

    return GestureDetector(
      onTap: () {
        provider.setSelectedUser(
          user.fullName,
        );

        Navigator.pop(context);
      },
      child: Container(
        margin:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding:
            const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  18),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.08),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(
                user.avatar,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    user.fullName,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  const SizedBox(
                      height: 4),
                  Text(
                    user.email,
                    style:
                        TextStyle(
                      color: Colors
                          .grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F9FC),
      appBar: AppBar(
        title:
            const Text("Choose User"),
      ),
      body: Consumer<UserProvider>(
        builder:
            (context, provider, _) {
          if (provider.isLoading &&
              provider.users
                  .isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                      "Loading users...")
                ],
              ),
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
                    height: 250,
                  ),
                  Icon(
                    Icons.person_off,
                    size: 80,
                    color:
                        Colors.grey,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      "No Users Found",
                    ),
                  ),
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
                return buildUserCard(
                  provider,
                  index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}