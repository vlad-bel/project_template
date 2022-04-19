import 'package:project_template/domain/models/user.dart';

abstract class UsersRepository {
  Future<User?> createUser({
    required String email,
    required String password,
    required DateTime registerTime,
  });

  Future<User?> getUser({
    required int userId,
  });

  Future<User?> getUserByEmail({
    required String email,
  });
}
