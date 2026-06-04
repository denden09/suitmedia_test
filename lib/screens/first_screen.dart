import 'package:flutter/material.dart';

import '../utils/palindrome_helper.dart';
import 'second_screen.dart';

class FirstScreen
    extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() =>
      _FirstScreenState();
}

class _FirstScreenState
    extends State<FirstScreen> {
  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      palindromeController =
      TextEditingController();

  void checkPalindrome() {
    bool result =
        PalindromeHelper.isPalindrome(
            palindromeController.text);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(
          result
              ? 'isPalindrome'
              : 'not palindrome',
        ),
      ),
    );
  }

  void goNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SecondScreen(
          name:
              nameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("First Screen"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center,
          children: [
            TextField(
              controller:
                  nameController,
              decoration:
                  const InputDecoration(
                hintText:
                    "Name",
              ),
            ),
            const SizedBox(
                height: 16),
            TextField(
              controller:
                  palindromeController,
              decoration:
                  const InputDecoration(
                hintText:
                    "Palindrome",
              ),
            ),
            const SizedBox(
                height: 24),
            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton(
                onPressed:
                    checkPalindrome,
                child: const Text(
                    "CHECK"),
              ),
            ),
            const SizedBox(
                height: 12),
            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton(
                onPressed:
                    goNext,
                child: const Text(
                    "NEXT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}