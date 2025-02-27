class AuthService {
  bool login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Fields cannot be empty");
    }
    if (email == 'test@email.com' && password == 'password123') {
      return true;
    }
    throw Exception("Invalid Credentials");
  }
}