class ForgotPasswordService {
  Future<bool> sendPasswordResetEmail(String email) async {
    // Implement your password reset logic here
    // This is a mock implementation
    await Future.delayed(const Duration(seconds: 2));
    return true; // Return false for failure
  }
}
