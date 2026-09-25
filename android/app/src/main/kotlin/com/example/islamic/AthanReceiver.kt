package com.example.islamic

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.content.ContextCompat

class AthanReceiver : BroadcastReceiver() {

    companion object {

        private const val TAG =
            "AthanReceiver"

        private const val PREFS_NAME =
            "athan_prefs"

        private const val ATHAN_IDS_KEY =
            "athan_ids"

        const val NATIVE_MASTER_ENABLED_KEY =
            "athan_master_enabled_native"
    }

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {

        val prefs =
            context.getSharedPreferences(
                PREFS_NAME,
                Context.MODE_PRIVATE
            )

        /*
         * Default = ON
         *
         * This is intentionally native so the alarm can
         * make the decision even when Flutter is not running.
         */
        val masterEnabled =
            prefs.getBoolean(
                NATIVE_MASTER_ENABLED_KEY,
                true
            )

        Log.d(
            TAG,
            "NATIVE MASTER ATHAN: $masterEnabled"
        )

        /*
         * MASTER OFF
         *
         * Do not start audio.
         * Do not open AthanScreen.
         */
        if (!masterEnabled) {

            Log.d(
                TAG,
                "MASTER OFF => IGNORING ATHAN ALARM"
            )

            val athanId =
                intent.getIntExtra(
                    "athan_id",
                    0
                )

            removeFiredAlarm(
                context,
                athanId
            )

            return
        }

        val athanId =
            intent.getIntExtra(
                "athan_id",
                0
            )

        val prayerName =
            intent.getStringExtra(
                "prayer_name"
            ) ?: ""

        val prayerKey =
            intent.getStringExtra(
                "prayer_key"
            ) ?: ""

        Log.d(
            TAG,
            "================================"
        )

        Log.d(
            TAG,
            "ATHAN RECEIVED"
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
            "================================"
        )

        // =====================================================
        // REMOVE FIRED ALARM FROM SAVED ALARMS
        // =====================================================

        removeFiredAlarm(
            context,
            athanId
        )

        // =====================================================
        // START ATHAN FOREGROUND SERVICE
        // =====================================================

        val serviceIntent =
            Intent(
                context,
                AthanService::class.java
            )

        serviceIntent.action =
            AthanService.ACTION_START

        serviceIntent.putExtra(
            AthanService.EXTRA_ATHAN_ID,
            athanId
        )

        serviceIntent.putExtra(
            AthanService.EXTRA_PRAYER_NAME,
            prayerName
        )

        serviceIntent.putExtra(
            AthanService.EXTRA_PRAYER_KEY,
            prayerKey
        )

        try {

            ContextCompat.startForegroundService(
                context,
                serviceIntent
            )

            Log.d(
                TAG,
                "ATHAN SERVICE STARTED SUCCESSFULLY"
            )

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ERROR STARTING ATHAN SERVICE",
                e
            )
        }
    }

    // =====================================================
    // REMOVE FIRED ALARM
    // =====================================================

    private fun removeFiredAlarm(
        context: Context,
        athanId: Int
    ) {

        if (athanId == 0) {
            return
        }

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
