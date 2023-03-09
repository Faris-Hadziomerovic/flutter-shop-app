class AuthData {
  String? username;
  String? email;
  String? password;

  AuthData({this.username, this.email, this.password});

  @override
  String toString() {
    return '''{
      username: $username, 
      email: $email, 
      password: $password, \n}''';
  }
}
