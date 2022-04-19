import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:project_template/domain/models/user.dart';
import 'package:project_template/services/user_manager/user_manager.dart';

class UserDetailsState extends Equatable {
  final User? user;

  const UserDetailsState({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

@singleton
class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit({
    required this.usersManager,
  }) : super(UserDetailsState(user: usersManager.user)) {
    init();
  }

  final UserManager usersManager;

  void init() async {
    var user = await usersManager.getUser();
    emit(UserDetailsState(user: user));
  }

  void logout({
    required VoidCallback logout,
  }) {
    usersManager.removeUser();
    logout();
  }
}
