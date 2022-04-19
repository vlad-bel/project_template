import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/flows/auth/signin/sigin_form.dart';
import 'package:project_template/navigation/app_state_cubit/app_state_cubit.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  static const path = "/";

  @override
  Widget build(BuildContext context) {
    final appStateCubit = BlocProvider.of<AppStateCubit>(context);

    return const SigninForm();
  }
}
