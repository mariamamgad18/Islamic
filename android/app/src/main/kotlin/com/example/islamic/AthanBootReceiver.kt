package com.example.islamic

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class AthanBootReceiver :
    BroadcastReceiver() {

    companion object {

        private const val TAG =
            "AthanBootReceiver"

        private const val PREFS_NAME =
            "athan_prefs"

        private const val ATHAN_IDS_KEY =
            "athan_ids"

        private const val MASTER_KEY =
            "athan_master_enabled_native"
    }

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {

        Log.d(
            TAG,
            "Received: ${intent.action}"
        )

        val prefs =
            context.getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        val masterEnabled =
            prefs.getBoolean(
                MASTER_KEY,
                false
            )

        // =====================================================
        // MASTER OFF
        // =====================================================

        if (!masterEnabled) {
            Log.d(
                TAG,
                "MASTER OFF => DO NOT RESTORE ATHAN"
            )

            return
        }

        restoreFutureAlarms(
            context
        )
    }

    private fun restoreFutureAlarms(
        context: Context
    ) {

        val prefs =
            context.getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        val ids =
            prefs.getStringSet(
                ATHAN_IDS_KEY,
                emptySet()
            )?.toMutableSet()
                ?: mutableSetOf()

        if (ids.isEmpty()) {
            Log.d(
                TAG,
                "NO SAVED ATHAN ALARMS"
            )

            return
        }

        val alarmManager =
            context.getSystemService(
                Context.ALARM_SERVICE
            ) as AlarmManager

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.S
        ) {
            if (
                !alarmManager
                    .canScheduleExactAlarms()
            ) {
                Log.e(
                    TAG,
                    "EXACT ALARM PERMISSION NOT GRANTED"
                )

                return
            }
        }

        val now =
            System.currentTimeMillis()

        val validIds =
            mutableSetOf<String>()

        for (idString in ids) {

            val athanId =
                idString.toIntOrNull()
                    ?: continue

            val timestamp =
                prefs.getLong(
                    "timestamp_$athanId",
                    0L
                )

            val prayerName =
                prefs.getString(
                    "prayer_name_$athanId",
                    ""
                ) ?: ""

            val prayerKey =
                prefs.getString(
                    "prayer_key_$athanId",
                    ""
                ) ?: ""

            if (
                timestamp <= now ||
                prayerKey.isEmpty()
            ) {
                continue
            }

            val receiverIntent =
                Intent(
                    context,
                    AthanReceiver::class.java
                )

            receiverIntent.putExtra(
                "athan_id",
                athanId
            )

            receiverIntent.putExtra(
                "prayer_name",
                prayerName
            )

            receiverIntent.putExtra(
                "prayer_key",
                prayerKey
            )

            val pendingIntent =
                PendingIntent.getBroadcast(
                    context,
                    athanId,
                    receiverIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or
                            PendingIntent.FLAG_IMMUTABLE
                )

            try {

                alarmManager.setExactAndAllowWhileIdle(
                    AlarmManager.RTC_WAKEUP,
                    timestamp,
                    pendingIntent
                )

                validIds.add(
                    idString
                )

                Log.d(
                    TAG,
                    "RESTORED ATHAN: $athanId"
                )

            } catch (e: SecurityException) {

                Log.e(
                    TAG,
                    "SECURITY ERROR RESTORING ATHAN",
                    e
                )

                return
            }
        }

        prefs.edit()
            .putStringSet(
                ATHAN_IDS_KEY,
                validIds
            )
            .apply()
    }
}