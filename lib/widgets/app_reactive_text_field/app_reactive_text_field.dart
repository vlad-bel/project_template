import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_template/common/colors.dart';
import 'package:project_template/common/resources.dart';
import 'package:project_template/common/styles.dart';
import 'package:project_template/widgets/app_reactive_text_field/logic/reactive_text_field_cubit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppReactiveTextField extends StatelessWidget {
  const AppReactiveTextField({
    Key? key,
    required this.formControlName,
    required this.validationMessages,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.labelText,
    this.passwordMode = false,
    this.obscureText = false,
    this.readOnly,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.prefixText,
    this.prefixStyle,
  }) : super(key: key);

  final String formControlName;
  final Map<String, String> Function(FormControl<String>) validationMessages;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final String? labelText;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;

  /// Set to [true] if you want to show eye icon as a suffixIcon
  final bool passwordMode;
  final bool obscureText;
  final String? prefixText;
  final TextStyle? prefixStyle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReactiveTextFieldCubit(obscureText),
      child: BlocBuilder<ReactiveTextFieldCubit, ReactiveTextFieldState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<ReactiveTextFieldCubit>(context);

          final suffixButton = CupertinoButton(
            onPressed: cubit.toggleObscureText,
            child: SvgPicture.asset(
              state.obscureText ? Resources.eyeCrossedIcon : Resources.eyeIcon,
            ),
          );

          return ReactiveTextField<String>(
            formControlName: formControlName,
            validationMessages: validationMessages,
            textInputAction: textInputAction,
            obscureText: state.obscureText,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            readOnly: readOnly ?? false,
            style: AppTextStyles.bodyS,
            maxLines: maxLines,
            minLines: minLines,
            ///default decoration
            ///change if need
            decoration: InputDecoration(
              border: _inputBorder,
              enabledBorder: _inputBorder,
              focusedBorder: _inputBorder.copyWith(
                borderSide: BorderSide(color: AppColors.green),
              ),
              errorBorder: _inputBorder.copyWith(
                borderSide: BorderSide(color: AppColors.red),
              ),
              labelText: labelText,
              labelStyle: AppTextStyles.bodyS,
              errorStyle: AppTextStyles.captionNormal.copyWith(
                color: AppColors.red,
              ),
              suffixIcon: passwordMode ? suffixButton : null,
              prefixText: prefixText,
              prefixStyle: prefixStyle,
            ),
          );
        },
      ),
    );
  }

  static const _inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: AppColors.lightGrey,
      width: 0.5,
    ),
  );
}
