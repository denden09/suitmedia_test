class PalindromeHelper {
  static bool isPalindrome(String text) {
    String cleaned =
        text.replaceAll(' ', '').toLowerCase();

    return cleaned ==
        cleaned.split('').reversed.join();
  }
}