import 'package:injectable/injectable.dart';
import 'package:project_template/domain/models/user.dart';
import 'package:project_template/domain/users/users_repository.dart';
import 'package:project_template/usecase/users/users_interactor.dart';

@Singleton(as: UsersInteractor)
class DefaultUsersInteractor implements UsersInteractor {
  final UsersRepository repository;

  DefaultUsersInteractor({
    required this.repository,
  });

  @override
  Future<User?> createUser({
    required String email,
    required String password,
    required DateTime registerTime,
  }) {
    return repository.createUser(
      email: email,
      password: password,
      registerTime: registerTime,
    );
  }

  @override
  Future<User?> getUser({
    required int userId,
  }) {
    return repository.getUser(
      userId: userId,
    );
  }

  @override
  Future<User?> getUserByEmail({
    required String email,
  }) {
    return repository.getUserByEmail(
      email: email,
    );
  }
}
