import 'package:flutter/material.dart';
import 'package:project_template/common/colors.dart';
import 'package:project_template/common/styles.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

enum NotifyType {
  success,
  error,
}

void showMessage({
  required String message,
  required NotifyType type,
}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style: AppTextStyles.sfProDisplaySemiBold17.copyWith(
        color: AppColors.white,
      ),
    ),
    backgroundColor:
        type == NotifyType.success ? AppColors.darkGreen : AppColors.darkRed,
  );

  snackbarKey.currentState?.showSnackBar(snackBar);
}
