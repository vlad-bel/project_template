import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_template/common/app_string.dart';
import 'package:project_template/domain/models/app_error.dart';
import 'package:project_template/flows/auth/signin/bloc/signin_cubit.dart';
import 'package:project_template/flows/auth/signin/sigin_form.dart';
import 'package:project_template/flows/auth/signup/signup_form.dart';
import 'package:project_template/services/user_manager/user_manager.dart';
import 'package:project_template/usecase/users/users_interactor.dart';
import 'package:project_template/utils/app_notifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignupState {}

@singleton
class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    required this.usersInteractor,
    required this.userManager,
    required this.signinCubit,
  }) : super(SignupState());

  final UsersInteractor usersInteractor;
  final UserManager userManager;
  final SigninCubit signinCubit;

  final fbGroup = fb.group(
    <String, Object>{
      SignupForm.emailFormControlName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      SignupForm.passwordFormControlName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(8),
        ],
      ),
    },
  );

  Future signup({
    required FormGroup group,
    required VoidCallback registerSuccess,
  }) async {
    //get data from form
    final email = group.value[SignupForm.emailFormControlName] as String;
    final password = group.value[SignupForm.passwordFormControlName] as String;
    try {
      //check if it already exist
      var user = await usersInteractor.getUserByEmail(email: email);

      //register
      if (user == null) {
        //register user
        user = await usersInteractor.createUser(
          email: email,
          password: password,
          registerTime: DateTime.now(),
        );

        showMessage(
          message: AppString.emailRegistered,
          type: NotifyType.success,
        );

        fbGroup.value = {
          SignupForm.emailFormControlName: "",
          SignupForm.passwordFormControlName: "",
        };

        signinCubit.fbGroup.value = {
          SigninForm.emailFormControlName: email,
          SigninForm.passwordFormControlName: password,
        };
        registerSuccess();
        return;
      }

      showMessage(
        message: AppString.userExists,
        type: NotifyType.error,
      );
      // add already exist error
    } on AppError catch (e) {
      //add creation error
      showMessage(message: e.error, type: NotifyType.error);
    }
  }
}
