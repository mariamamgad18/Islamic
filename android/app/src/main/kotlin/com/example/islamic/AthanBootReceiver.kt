package com.example.islamic

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class AthanBootReceiver : BroadcastReceiver() {

    companion object {

        private const val TAG =
            "AthanBootReceiver"

        private const val PREFS_NAME =
            "athan_prefs"

        private const val ATHAN_IDS_KEY =
            "athan_ids"
    }

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {

        Log.d(
            TAG,
            "================================"
        )

        Log.d(
            TAG,
            "SYSTEM EVENT"
        )

        Log.d(
            TAG,
            "Action: ${intent.action}"
        )

        Log.d(
            TAG,
            "RESTORING ATHAN ALARMS"
        )

        Log.d(
            TAG,
            "================================"
        )

        // =====================================================
        // GET SAVED DATA
        // =====================================================

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

        // =====================================================
        // ALARM MANAGER
        // =====================================================

        val alarmManager =
            context.getSystemService(
                Context.ALARM_SERVICE
            ) as AlarmManager

        val now =
            System.currentTimeMillis()

        val expiredIds =
            mutableListOf<String>()

        // =====================================================
        // RESTORE EVERY ATHAN
        // =====================================================

        for (idString in ids) {

            val athanId =
                idString.toIntOrNull()

            if (athanId == null) {
                continue
            }

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

            val timestamp =
                prefs.getLong(
                    "timestamp_$athanId",
                    0L
                )

            // =================================================
            // INVALID TIMESTAMP
            // =================================================

            if (timestamp <= 0L) {

                Log.d(
                    TAG,
                    "INVALID TIMESTAMP: $athanId"
                )

                expiredIds.add(
                    idString
                )

                continue
            }

            // =================================================
            // EXPIRED ALARM
            // =================================================

            if (timestamp <= now) {

                Log.d(
                    TAG,
                    "SKIPPING EXPIRED ALARM"
                )

                Log.d(
                    TAG,
                    "ID: $athanId"
                )

                expiredIds.add(
                    idString
                )

                continue
            }

            // =================================================
            // EXACT ALARM PERMISSION
            // =================================================

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

                    continue
                }
            }

            // =================================================
            // CREATE RECEIVER INTENT
            // =================================================

            val athanIntent =
                Intent(
                    context,
                    AthanReceiver::class.java
                )

            athanIntent.putExtra(
                "athan_id",
                athanId
            )

            athanIntent.putExtra(
                "prayer_name",
                prayerName
            )

            athanIntent.putExtra(
                "prayer_key",
                prayerKey
            )

            // =================================================
            // PENDING INTENT
            // =================================================

            val pendingIntent =
                PendingIntent.getBroadcast(
                    context,
                    athanId,
                    athanIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or
                            PendingIntent.FLAG_IMMUTABLE
                )

            // =================================================
            // RESTORE EXACT ALARM
            // =================================================

            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                timestamp,
                pendingIntent
            )

            Log.d(
                TAG,
                "ATHAN RESTORED SUCCESSFULLY"
            )

            Log.d(
                TAG,
                "ID: $athanId"
            )

            Log.d(
                TAG,
                "Prayer: $prayerName"
            )

            Log.d(
                TAG,
                "Prayer Key: $prayerKey"
            )

            Log.d(
                TAG,
                "Timestamp: $timestamp"
            )
        }

        // =====================================================
        // REMOVE EXPIRED ALARMS
        // =====================================================

        for (idString in expiredIds) {

            ids.remove(
                idString
            )

            val athanId =
                idString.toIntOrNull()
                    ?: continue

            prefs.edit()
                .remove(
                    "prayer_name_$athanId"
                )
                .remove(
                    "prayer_key_$athanId"
                )
                .remove(
                    "timestamp_$athanId"
                )
                .apply()
        }

        prefs.edit()
            .putStringSet(
                ATHAN_IDS_KEY,
                ids
            )
            .apply()

        Log.d(
            TAG,
            "================================"
        )

        Log.d(
            TAG,
            "RESTORE FINISHED"
        )

        Log.d(
            TAG,
            "================================"
        )
    }
}