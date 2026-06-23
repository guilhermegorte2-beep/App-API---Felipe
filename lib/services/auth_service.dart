class AuthService {

  final String validUser = 'guiguis';
  final String validPassword = '123456';

  bool login(String user, String password) {

    return user == validUser &&
        password == validPassword;
  }
}