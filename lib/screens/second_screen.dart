import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'third_screen.dart';

class SecondScreen
    extends StatelessWidget {
  final String name;

  const SecondScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Second Screen"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Consumer<
            UserProvider>(
          builder: (
            context,
            provider,
            child,
          ) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                    "Welcome"),
                const SizedBox(
                    height: 8),
                Text(
                  name,
                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    provider
                        .selectedUser,
                    style:
                        const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double
                      .infinity,
                  child:
                      ElevatedButton(
                    onPressed:
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ThirdScreen(),
                        ),
                      );
                    },
                    child: const Text(
                        "Choose a User"),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}