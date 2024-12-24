import 'package:chat_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final UserService _userService;

  AuthService(this._userService);

  Future<void> signup(String name, String email, String password) async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.toLowerCase(),
      password: password,
    );
    await _userService.createUser(
      userCredential.user!.uid,
      name,
      email.toLowerCase(),
    );
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.toLowerCase(),
      password: password,
    );
  }
}
