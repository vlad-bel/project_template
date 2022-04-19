// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../domain/comments/comments_repository.dart' as _i4;
import '../../domain/comments/default_comments_repository.dart' as _i5;
import '../../domain/users/db_users_repository.dart' as _i11;
import '../../domain/users/users_repository.dart' as _i10;
import '../../flows/app/datalist/datalist_cubit.dart' as _i6;
import '../../flows/app/user_details/user_details_cubit.dart' as _i14;
import '../../flows/auth/signin/bloc/signin_cubit.dart' as _i17;
import '../../flows/auth/signup/bloc/signup_cubit.dart' as _i18;
import '../../usecase/comments/comments_interactor.dart' as _i12;
import '../../usecase/comments/default_comments_interactor.dart' as _i13;
import '../../usecase/users/default_users_interactor.dart' as _i16;
import '../../usecase/users/users_interactor.dart' as _i15;
import '../db/db.dart' as _i7;
import '../network/api_manager.dart' as _i3;
import '../token_service/token_service.dart' as _i8;
import '../user_manager/user_manager.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ApiManager>(_i3.ApiManager());
  gh.singleton<_i4.CommentsRepository>(
      _i5.DefaultCommentsRepository(apiManager: get<_i3.ApiManager>()));
  gh.singleton<_i12.CommentsInteractor>(_i13.DefaultCommentsInteractor(
      repository: get<_i4.CommentsRepository>()));
  gh.singleton<_i6.DataListCubit>(_i6.DataListCubit());
  gh.singleton<_i7.MyDatabase>(_i7.MyDatabase());
  gh.singleton<_i8.TokenManager>(_i8.TokenManager());
  gh.singleton<_i9.UserManager>(_i9.UserManager());
  gh.singleton<_i10.UsersRepository>(
      _i11.DbUserRepository(database: get<_i7.MyDatabase>()));

  gh.singleton<_i14.UserDetailsCubit>(
      _i14.UserDetailsCubit(usersManager: get<_i9.UserManager>()));
  gh.singleton<_i15.UsersInteractor>(
      _i16.DefaultUsersInteractor(repository: get<_i10.UsersRepository>()));
  gh.singleton<_i17.SigninCubit>(_i17.SigninCubit(
      usersInteractor: get<_i15.UsersInteractor>(),
      userManager: get<_i9.UserManager>()));
  gh.singleton<_i18.SignupCubit>(_i18.SignupCubit(
      usersInteractor: get<_i15.UsersInteractor>(),
      userManager: get<_i9.UserManager>(),
      signinCubit: get<_i17.SigninCubit>()));
  return get;
}
