import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:chat_app/services/auth_service.dart';

// UserService Provider
final userServiceProvider = Provider((ref) => UserService());

// Loading State Provider
final authStateProvider = StateProvider<bool>((ref) => false);

// AuthService Provider
final authProvider = Provider((ref) {
  final userService = ref.read(userServiceProvider);
  return AuthService(userService);
});
