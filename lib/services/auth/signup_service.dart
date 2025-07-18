class SignupService {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required String userType,
  }) async {
    // Implement your registration logic here
    // This is a mock implementation
    await Future.delayed(const Duration(seconds: 2));
    return true; // Return false for failure
  }
}
