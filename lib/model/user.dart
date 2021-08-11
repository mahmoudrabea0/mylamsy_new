class User {
  String userName, email, password, firstName, lastName;

  User(this.userName, this.email, this.password, this.firstName, this.lastName);

  Map<String, dynamic> userToRegister(
      String userName, email, password, firstName, lastName) {
    return {
      'username': userName,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  Map<String, dynamic> userToLogin(String userName, password) {
    return {
      'username': userName,
      'password': password,
    };
  }
}
