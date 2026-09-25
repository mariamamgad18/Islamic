package com.example.islamic

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {

        private const val CHANNEL =
            "athan_scheduler_channel"

        private const val PREFS_NAME =
            "athan_prefs"

        private const val ATHAN_IDS_KEY =
            "athan_ids"

        private const val NATIVE_MASTER_ENABLED_KEY =
            "athan_master_enabled_native"
    }

    override fun onCreate(
        savedInstanceState: Bundle?
    ) {

        super.onCreate(savedInstanceState)

        window.addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
        )

        window.addFlags(
            WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )
    }

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(
            flutterEngine
        )

        MethodChannel(
            flutterEngine
                .dartExecutor
                .binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call,
                                 result ->

            when (call.method) {

                // =================================================
                // SCHEDULE ATHAN
                // =================================================

                "scheduleAthan" -> {

                    val athanId =
                        call.argument<Int>(
                            "athanId"
                        )

                    val prayerName =
                        call.argument<String>(
                            "prayerName"
                        )

                    val prayerKey =
                        call.argument<String>(
                            "prayerKey"
                        )

                    val timestamp =
                        call.argument<Long>(
                            "timestamp"
                        )

                    if (
                        athanId == null ||
                        prayerName == null ||
                        prayerKey == null ||
                        timestamp == null
                    ) {

                        result.error(
                            "INVALID_DATA",
                            "Missing athan data",
                            null
                        )

                        return@setMethodCallHandler
                    }

                    try {

                        scheduleAthan(
                            athanId = athanId,
                            prayerName = prayerName,
                            prayerKey = prayerKey,
                            timestamp = timestamp
                        )

                        saveAthan(
                            athanId = athanId,
                            prayerName = prayerName,
                            prayerKey = prayerKey,
                            timestamp = timestamp
                        )

                        result.success(true)

                    } catch (
                        e: SecurityException
                    ) {

                        result.error(
                            "EXACT_ALARM_PERMISSION_DENIED",
                            "Exact alarm permission is not granted",
                            null
                        )

                    } catch (
                        e: Exception
                    ) {

                        result.error(
                            "SCHEDULE_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                // =================================================
                // CANCEL ONE ATHAN BY ID
                // =================================================

                "cancelAthan" -> {

                    val athanId =
                        call.argument<Int>(
                            "athanId"
                        )

                    if (athanId == null) {

                        result.error(
                            "INVALID_ID",
                            "Athan ID is missing",
                            null
                        )

                        return@setMethodCallHandler
                    }

                    try {

                        cancelAthan(athanId)

                        removeSavedAthan(athanId)

                        result.success(true)

                    } catch (
                        e: Exception
                    ) {

                        result.error(
                            "CANCEL_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                // =================================================
                // CANCEL ALL ATHAN FOR PRAYER
                // =================================================

                "cancelAthanPrayer" -> {

                    val prayerKey =
                        call.argument<String>(
                            "prayerKey"
                        )

                    if (prayerKey == null) {

                        result.error(
                            "INVALID_PRAYER",
                            "Prayer key is missing",
                            null
                        )

                        return@setMethodCallHandler
                    }

                    try {

                        cancelAthanPrayer(prayerKey)

                        result.success(true)

                    } catch (
                        e: Exception
                    ) {

                        result.error(
                            "CANCEL_PRAYER_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                // =================================================
                // CANCEL ALL ATHAN
                // =================================================

                "cancelAllAthan" -> {

                    try {

                        cancelAllAthan()

                        result.success(true)

                    } catch (
                        e: Exception
                    ) {

                        result.error(
                            "CANCEL_ALL_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                // =================================================
                // NATIVE MASTER STATE
                // =================================================

                "setNativeAthanMasterEnabled" -> {

                    val enabled =
                        call.argument<Boolean>(
                            "enabled"
                        )

                    if (enabled == null) {

                        result.error(
                            "INVALID_MASTER_STATE",
                            "Master state is missing",
                            null
                        )

                        return@setMethodCallHandler
                    }

                    setNativeAthanMasterEnabled(
                        enabled
                    )

                    result.success(true)
                }

                // =================================================
                // FULL SCREEN INTENT PERMISSION
                // =================================================

                "canUseFullScreenIntent" -> {

                    result.success(
                        canUseFullScreenIntent()
                    )
                }

                // =================================================
                // OPEN FULL SCREEN INTENT SETTINGS
                // =================================================

                "openFullScreenIntentSettings" -> {

                    openFullScreenIntentSettings()

                    result.success(true)
                }

                // =================================================
                // EXACT ALARM PERMISSION
                // =================================================

                "canScheduleExactAlarms" -> {

                    val alarmManager =
                        getSystemService(
                            Context.ALARM_SERVICE
                        ) as AlarmManager

                    if (
                        Build.VERSION.SDK_INT >=
                        Build.VERSION_CODES.S
                    ) {

                        result.success(
                            alarmManager
                                .canScheduleExactAlarms()
                        )

                    } else {

                        result.success(true)
                    }
                }

                // =================================================
                // OPEN EXACT ALARM SETTINGS
                // =================================================

                "openExactAlarmSettings" -> {

                    if (
                        Build.VERSION.SDK_INT >=
                        Build.VERSION_CODES.S
                    ) {

                        val settingsIntent =
                            Intent(
                                Settings
                                    .ACTION_REQUEST_SCHEDULE_EXACT_ALARM
                            )

                        settingsIntent.data =
                            Uri.parse(
                                "package:$packageName"
                            )

                        settingsIntent.addFlags(
                            Intent.FLAG_ACTIVITY_NEW_TASK
                        )

                        startActivity(
                            settingsIntent
                        )
                    }

                    result.success(true)
                }

                else -> {

                    result.notImplemented()
                }
            }
        }
    }

    // =========================================================
    // NATIVE MASTER STATE
    // =========================================================

    private fun setNativeAthanMasterEnabled(
        enabled: Boolean
    ) {

        val prefs =
            getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        prefs.edit()
            .putBoolean(
                NATIVE_MASTER_ENABLED_KEY,
                enabled
            )
            .apply()
    }

    // =========================================================
    // FULL SCREEN INTENT PERMISSION
    // =========================================================

    private fun canUseFullScreenIntent(): Boolean {

        if (
            Build.VERSION.SDK_INT <
            Build.VERSION_CODES.UPSIDE_DOWN_CAKE
        ) {
            return true
        }

        val notificationManager =
            getSystemService(
                NotificationManager::class.java
            )

        return notificationManager
            .canUseFullScreenIntent()
    }

    // =========================================================
    // OPEN FULL SCREEN INTENT SETTINGS
    // =========================================================

    private fun openFullScreenIntentSettings() {

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.UPSIDE_DOWN_CAKE
        ) {

            try {

                val intent =
                    Intent(
                        Settings
                            .ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT
                    )

                intent.data =
                    Uri.parse(
                        "package:$packageName"
                    )

                intent.addFlags(
                    Intent.FLAG_ACTIVITY_NEW_TASK
                )

                startActivity(intent)

            } catch (e: Exception) {

                /*
                 * Fallback to general application details
                 * if the device doesn't expose the dedicated
                 * Full Screen Intent settings page.
                 */

                val fallbackIntent =
                    Intent(
                        Settings.ACTION_APPLICATION_DETAILS_SETTINGS
                    )

                fallbackIntent.data =
                    Uri.parse(
                        "package:$packageName"
                    )

                fallbackIntent.addFlags(
                    Intent.FLAG_ACTIVITY_NEW_TASK
                )

                startActivity(
                    fallbackIntent
                )
            }
        }
    }

    // =========================================================
    // SCHEDULE ATHAN
    // =========================================================

    private fun scheduleAthan(
        athanId: Int,
        prayerName: String,
        prayerKey: String,
        timestamp: Long
    ) {

        val alarmManager =
            getSystemService(
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

                throw SecurityException(
                    "Exact alarm permission is not granted"
                )
            }
        }

        val intent =
            Intent(
                this,
                AthanReceiver::class.java
            )

        intent.putExtra(
            "athan_id",
            athanId
        )

        intent.putExtra(
            "prayer_name",
            prayerName
        )

        intent.putExtra(
            "prayer_key",
            prayerKey
        )

        val pendingIntent =
            PendingIntent.getBroadcast(
                this,
                athanId,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                        PendingIntent.FLAG_IMMUTABLE
            )

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            timestamp,
            pendingIntent
        )
    }

    // =========================================================
    // CANCEL ONE ATHAN
    // =========================================================

    private fun cancelAthan(
        athanId: Int
    ) {

        val alarmManager =
            getSystemService(
                Context.ALARM_SERVICE
            ) as AlarmManager

        val intent =
            Intent(
                this,
                AthanReceiver::class.java
            )

        val pendingIntent =
            PendingIntent.getBroadcast(
                this,
                athanId,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                        PendingIntent.FLAG_IMMUTABLE
            )

        alarmManager.cancel(
            pendingIntent
        )

        pendingIntent.cancel()
    }

    // =========================================================
    // CANCEL ALL ATHAN FOR PRAYER
    // =========================================================

    private fun cancelAthanPrayer(
        prayerKey: String
    ) {

        val prefs =
            getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        val ids =
            prefs.getStringSet(
                ATHAN_IDS_KEY,
                emptySet()
            )?.toMutableSet()
                ?: mutableSetOf()

        val idsToRemove =
            mutableListOf<String>()

        for (idString in ids) {

            val athanId =
                idString.toIntOrNull()
                    ?: continue

            val savedPrayerKey =
                prefs.getString(
                    "prayer_key_$athanId",
                    ""
                ) ?: ""

            if (
                savedPrayerKey == prayerKey
            ) {

                cancelAthan(athanId)

                idsToRemove.add(
                    idString
                )
            }
        }

        for (id in idsToRemove) {

            ids.remove(id)
        }

        val editor =
            prefs.edit()

        editor.putStringSet(
            ATHAN_IDS_KEY,
            ids
        )

        for (idString in idsToRemove) {

            val athanId =
                idString.toIntOrNull()
                    ?: continue

            editor.remove(
                "prayer_name_$athanId"
            )

            editor.remove(
                "prayer_key_$athanId"
            )

            editor.remove(
                "timestamp_$athanId"
            )
        }

        editor.apply()
    }

    // =========================================================
    // CANCEL ALL ATHAN
    // =========================================================

    private fun cancelAllAthan() {

        val prefs =
            getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        val ids =
            prefs.getStringSet(
                ATHAN_IDS_KEY,
                emptySet()
            ) ?: emptySet()

        for (idString in ids) {

            val athanId =
                idString.toIntOrNull()
                    ?: continue

            cancelAthan(athanId)
        }

        // =====================================================
        // STOP CURRENT ATHAN SERVICE TOO
        // =====================================================

        val serviceIntent =
            Intent(
                this,
                AthanService::class.java
            )

        serviceIntent.action =
            AthanService.ACTION_STOP

        try {

            startService(serviceIntent)

        } catch (_: Exception) {
        }

        /*
         * IMPORTANT:
         *
         * We intentionally DO NOT change the native master
         * state here.
         *
         * cancelAllAthan() can be called while Master is ON.
         */
        prefs.edit()
            .clear()
            .putBoolean(
                NATIVE_MASTER_ENABLED_KEY,
                prefs.getBoolean(
                    NATIVE_MASTER_ENABLED_KEY,
                    true
                )
            )
            .apply()
    }

    // =========================================================
    // SAVE ATHAN
    // =========================================================

    private fun saveAthan(
        athanId: Int,
        prayerName: String,
        prayerKey: String,
        timestamp: Long
    ) {

        val prefs =
            getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        val ids =
            prefs.getStringSet(
                ATHAN_IDS_KEY,
                emptySet()
            )?.toMutableSet()
                ?: mutableSetOf()

        ids.add(
            athanId.toString()
        )

        prefs.edit()
            .putStringSet(
                ATHAN_IDS_KEY,
                ids
            )
            .putString(
                "prayer_name_$athanId",
                prayerName
            )
            .putString(
                "prayer_key_$athanId",
                prayerKey
            )
            .putLong(
                "timestamp_$athanId",
                timestamp
            )
            .apply()
    }

    // =========================================================
    // REMOVE SAVED ATHAN
    // =========================================================

    private fun removeSavedAthan(
        athanId: Int
    ) {

        val prefs =
            getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        val ids =
            prefs.getStringSet(
                ATHAN_IDS_KEY,
                emptySet()
            )?.toMutableSet()
                ?: mutableSetOf()

        ids.remove(
            athanId.toString()
        )

        prefs.edit()
            .putStringSet(
                ATHAN_IDS_KEY,
                ids
            )
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
}
