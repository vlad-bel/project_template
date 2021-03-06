import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_template/common/app_string.dart';
import 'package:project_template/domain/models/app_error.dart';
import 'package:project_template/flows/auth/signin/sigin_form.dart';
import 'package:project_template/services/user_manager/user_manager.dart';
import 'package:project_template/usecase/users/users_interactor.dart';
import 'package:project_template/utils/app_notifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SigninState {}

@singleton
class SigninCubit extends Cubit<SigninState> {
  SigninCubit({
    required this.usersInteractor,
    required this.userManager,
  }) : super(SigninState());

  final UsersInteractor usersInteractor;
  final UserManager userManager;

  final fbGroup = fb.group(
    <String, Object>{
      SigninForm.emailFormControlName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      SigninForm.passwordFormControlName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(8),
        ],
      ),
    },
  );

  Future signin(
    FormGroup group,
    VoidCallback signin,
  ) async {
    //get data from form
    final email = group.value[SigninForm.emailFormControlName] as String;
    final password = group.value[SigninForm.passwordFormControlName] as String;

    try {
      final user = await usersInteractor.getUserByEmail(email: email);

      if (user != null) {
        final passHash = password.hashCode.toString();
        if (user.password == passHash) {
          userManager.setUser(user);

          signin();

          return;
        }

        showMessage(
          message: AppString.wrongPassword,
          type: NotifyType.error,
        );
      }

      showMessage(
        message: AppString.userNotExists,
        type: NotifyType.error,
      );
    } on AppError catch (e) {
      showMessage(
        message: e.error,
        type: NotifyType.error,
      );
    }
  }
}
