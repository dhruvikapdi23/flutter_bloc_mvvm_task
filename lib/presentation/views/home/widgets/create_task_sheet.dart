import 'package:dhruvi_todo_task/constants/app_colors.dart';
import 'package:dhruvi_todo_task/constants/app_fonts.dart';
import 'package:dhruvi_todo_task/constants/app_img.dart';
import 'package:dhruvi_todo_task/constants/extension/spacing.dart';
import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/views/widgets/text_field_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTaskSheet extends StatelessWidget {
  final String? title;
  final TextEditingController? titleCtrl, descCtrl;
  final GestureTapCallback? onTap;

  const CreateTaskSheet({super.key, this.title, this.descCtrl, this.titleCtrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: AppColors.greyColor)),
                ),
                const HSpace(16),
                Text(AppFonts.whatsInYourMind,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: AppColors.greyColor))
              ],
            ).paddingDirectional(horizontal: 42),
            const VSpace(32),
            TextFieldCommon(
              controller: titleCtrl,
              hintText: AppFonts.title,
              prefixIcon:  SvgPicture.asset(AppSvg.edit,
                      fit: BoxFit.scaleDown,),
              isMaxLine: true,
            ).paddingDirectional(horizontal: 30),
            TextFieldCommon(
              controller: descCtrl,
              hintText: AppFonts.addNote,
              prefixIcon:  SvgPicture.asset(AppSvg.edit,
                      fit: BoxFit.scaleDown,),
              isMaxLine: true,
            ).paddingDirectional(horizontal: 30),
            const VSpace(48),
            Text(AppFonts.create,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)).inkWell(onTap: onTap)
                .alignment(Alignment.centerRight)
                .paddingDirectional(horizontal: 42),
            const VSpace(200),
          ],
        ),
      ),
    );
  }
}
