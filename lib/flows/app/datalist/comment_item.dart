import 'package:flutter/material.dart';
import 'package:project_template/common/colors.dart';
import 'package:project_template/common/styles.dart';
import 'package:project_template/domain/models/comment.dart';
import 'package:sizer/sizer.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.conifer,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.name ?? "",
                style: AppTextStyles.bodyBold.copyWith(
                  color: AppColors.darkGrey,
                  // fontSize: 18,
                  fontSize: 16.sp,
                ),

              ),
              Text(
                comment.email ?? "",
                style: AppTextStyles.bodySBold.copyWith(
                  color: AppColors.darkGrey,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                comment.body ?? "",
                style: AppTextStyles.bodyS.copyWith(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
