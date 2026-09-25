import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/reminders/add_new_reminder_container.dart';
import 'package:islamic/Features/Ui/reminders/nasiha_container.dart';
import 'package:islamic/Features/Ui/reminders/reminder_container.dart';
import 'package:islamic/Features/Ui/reminders/reminder_model.dart';
import 'package:islamic/Features/Ui/reminders/reminder_storage.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/reminders_inside_screen.dart';
import 'package:islamic/core/Services/notification_service.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({
    super.key,
  });

  @override
  State<RemindersPage> createState() =>
      _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {

// =========================================================
// REMINDERS LIST
// =========================================================

  List<ReminderModel> reminders = [];

// =========================================================
// INIT
// =========================================================

  @override
  void initState() {
    super.initState();

    loadReminders();
  }

// =========================================================
// LOAD REMINDERS
// =========================================================

  Future<void> loadReminders() async {
    final List<ReminderModel> savedReminders =
    await ReminderStorage.getReminders();

    if (!mounted) return;

    setState(() {
      reminders = savedReminders;
    });

// =======================================================
// IMPORTANT
// =======================================================
//
// SharedPreferences تحفظ البيانات.
//
// لكن لازم نعمل Schedule للإشعارات
// لما التطبيق يفتح.
//
// =======================================================

    for (int i = 0;
    i < savedReminders.length;
    i++) {
      final ReminderModel reminder =
      savedReminders[i];

      if (reminder.isEnabled) {
        await NotificationService.scheduleReminder(
          id: getReminderNotificationId(i),
          title: reminder.title,
          time: reminder.time,
          isDaily: reminder.isDaily,
        );
      }
    }
  }

// =========================================================
// NOTIFICATION ID
// =========================================================
//
// بنعمل IDs مختلفة عن IDs بتاعة الأذان.
//
// 1000+
// عشان مايحصلش تعارض مع إشعارات الصلاة.
//
// =========================================================

  int getReminderNotificationId(int index) {
    return 1000 + index;
  }

// =========================================================
// ADD REMINDER
// =========================================================

  Future<void> addReminder(ReminderModel reminder,) async {
    setState(() {
      reminders.add(reminder);
    });

// =======================================================
// SAVE
// =======================================================

    await ReminderStorage.saveReminders(
      reminders,
    );

// =======================================================
// SCHEDULE NOTIFICATION
// =======================================================

    final int notificationId =
    getReminderNotificationId(
      reminders.length - 1,
    );

    if (reminder.isEnabled) {
      await NotificationService.scheduleReminder(
        id: notificationId,
        title: reminder.title,
        time: reminder.time,
        isDaily: reminder.isDaily,
      );
    }
  }

// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [

// ===================================================
// HEADER
// ===================================================

          Container(
            width: double.infinity,
            height: 84.h,
            color: AppColors.DarkGreenColor,

            child: Padding(
              padding: EdgeInsets.all(24.w),

              child: Row(
                children: [

// ==========================================
// ADD BUTTON
// ==========================================

                  InkWell(
                    onTap: () async {
                      final ReminderModel?
                      reminder =
                      await Navigator.of(
                        context,
                      ).push(
                        MaterialPageRoute(
                          builder: (_) =>
                          const RemindersInsideScreen(),
                        ),
                      );

                      if (reminder != null) {
                        await addReminder(
                          reminder,
                        );
                      }
                    },

                    child: Container(
                      width: 36.w,
                      height: 36.h,

                      decoration:
                      BoxDecoration(
                        color:
                        AppColors.lightGreyColor,
                        borderRadius:
                        BorderRadius.circular(
                          30,
                        ),
                      ),

                      child: Icon(
                        Icons.add,
                        color:
                        AppColors.whiteColor,
                      ),
                    ),
                  ),

                  const Spacer(),

// ==========================================
// TITLE
// ==========================================

                  Text(
                    l10n.reminders,
                    style: TextStyle(
                      fontSize: 24,
                      color:
                      AppColors.whiteColor,
                      fontWeight:
                      FontWeight.w400,
                      fontFamily: 'Cairo',
                    ),
                  ),

                  SizedBox(
                    width: 12.w,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color:
                      AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

// =================================================
// REMINDERS LIST
// =================================================

          Expanded(
            child: reminders.isEmpty
                ? const SizedBox()
                : ListView.separated(
              padding:
              EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),

              itemCount:
              reminders.length,

              separatorBuilder:
                  (context, index) {
                return SizedBox(
                  height: 12.h,
                );
              },

              itemBuilder:
                  (context, index) {
                final ReminderModel
                reminder =
                reminders[index];

                return ReminderContainer(
                  reminderTitle:
                  reminder.title,

                  reminderTime:
                  reminder.time,

                  reminderIcon:
                  reminder.icon,

                  reminderColor:
                  reminder.color,

                  isEnabled:
                  reminder.isEnabled,
                );
              },
            ),
          ),

// =================================================
// ADD REMINDER CONTAINER
// =================================================

          AddNewReminderContainer(
            onReminderAdded:
            addReminder,
          ),

          SizedBox(
            height: 16.h,
          ),

// =================================================
// NASIHA
// =================================================

          const NasihaContainer(),

          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
