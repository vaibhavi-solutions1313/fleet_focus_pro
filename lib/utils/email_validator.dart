bool isValidEmail(String email) {
  // Use a regular expression to validate the email format
  // You can adjust this regular expression to your specific requirements
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}
