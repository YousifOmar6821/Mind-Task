import '../models/user.dart';
import '../web_services/authentication_web_service.dart';

class AuthenticationRepository {
  final AuthenticationWebService authenticationWebService;

  AuthenticationRepository(this.authenticationWebService);

  Future<User> login(String email, String password) async {
    try {
      final fetchedUser = await authenticationWebService.login(email, password);
      return User.fromJson(fetchedUser);
    } catch (e) {
      rethrow;
    }
  }
}