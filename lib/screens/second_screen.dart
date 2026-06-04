import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  final String name;

  const SecondScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F9FC),
      appBar: AppBar(
        title:
            const Text("Second Screen"),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding:
                const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style:
                      const TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width:
                      double.infinity,
                  padding:
                      const EdgeInsets
                          .all(24),
                  decoration:
                      BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius
                            .circular(
                                20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors
                            .black12,
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Selected User",
                        style:
                            TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),
                      const SizedBox(
                          height: 12),
                      Text(
                        provider
                            .selectedUser,
                        textAlign:
                            TextAlign
                                .center,
                        style:
                            const TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width:
                      double.infinity,
                  height: 55,
                  child:
                      ElevatedButton(
                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          const Color(
                              0xFF2B637B),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ThirdScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Choose a User",
                      style:
                          TextStyle(
                        color: Colors
                            .white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}