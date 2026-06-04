import 'package:flutter/material.dart';

import '../utils/palindrome_helper.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController palindromeController =
      TextEditingController();

  final Color primaryColor = const Color(0xFF2B637B);

  void checkPalindrome() {
    bool result = PalindromeHelper.isPalindrome(
      palindromeController.text,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              result
                  ? Icons.check_circle
                  : Icons.cancel,
              color: result
                  ? Colors.green
                  : Colors.red,
            ),
            const SizedBox(width: 10),
            Text(
              result
                  ? "Palindrome"
                  : "Not Palindrome",
            ),
          ],
        ),
        content: Text(
          result
              ? "This sentence is a palindrome."
              : "This sentence is not a palindrome.",
        ),
      ),
    );
  }

  void goNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SecondScreen(
          name: nameController.text,
        ),
      ),
    );
  }

  Widget buildTextField({
    required String hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildButton(
      String title,
      VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F9FC),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.08),
                      blurRadius: 15,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          primaryColor,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Suitmedia Test",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildTextField(
                      hint: "Name",
                      controller:
                          nameController,
                    ),
                    const SizedBox(height: 16),
                    buildTextField(
                      hint:
                          "Palindrome Sentence",
                      controller:
                          palindromeController,
                    ),
                    const SizedBox(height: 24),
                    buildButton(
                        "CHECK",
                        checkPalindrome),
                    const SizedBox(height: 12),
                    buildButton(
                        "NEXT", goNext),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}