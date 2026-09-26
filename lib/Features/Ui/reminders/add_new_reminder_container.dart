import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/reminders/reminder_model.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/reminders_inside_screen.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class AddNewReminderContainer extends StatelessWidget {
  final Function(ReminderModel) onReminderAdded;

  const AddNewReminderContainer({
    super.key,
    required this.onReminderAdded,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () async {
        final ReminderModel? reminder =
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RemindersInsideScreen(),
          ),
        );

        if (reminder != null) {
          onReminderAdded(reminder);
        }
      },
      child: Container(
        width: 382.w,
        height: 76.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(
            color: AppColors.lightGreyColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.addNewReminder,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.GreyColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.add,
              size: 16,
              color: AppColors.GreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
