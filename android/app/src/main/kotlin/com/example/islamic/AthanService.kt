package com.example.islamic

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.media.MediaPlayer
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat

class AthanService : Service() {

    companion object {

        const val ACTION_START =
            "com.example.islamic.ACTION_START_ATHAN"

        const val ACTION_STOP =
            "com.example.islamic.ACTION_STOP_ATHAN"

        const val ACTION_ATHAN_FINISHED =
            "com.example.islamic.ACTION_ATHAN_FINISHED"

        const val EXTRA_ATHAN_ID =
            "athan_id"

        const val EXTRA_PRAYER_NAME =
            "prayer_name"

        const val EXTRA_PRAYER_KEY =
            "prayer_key"

        private const val CHANNEL_ID =
            "athan_playback_channel"

        private const val CHANNEL_NAME =
            "Athan"

        private const val NOTIFICATION_ID =
            2001
    }

    private var mediaPlayer: MediaPlayer? = null

    private var currentAthanId = 0

    private var currentPrayerName = ""

    private var currentPrayerKey = ""

    // =========================================================
    // ON CREATE
    // =========================================================

    override fun onCreate() {
        super.onCreate()

        createNotificationChannel()
    }

    // =========================================================
    // ON START COMMAND
    // =========================================================

    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int
    ): Int {

        when (intent?.action) {

            ACTION_START -> {

                currentAthanId =
                    intent.getIntExtra(
                        EXTRA_ATHAN_ID,
                        0
                    )

                currentPrayerName =
                    intent.getStringExtra(
                        EXTRA_PRAYER_NAME
                    ) ?: ""

                currentPrayerKey =
                    intent.getStringExtra(
                        EXTRA_PRAYER_KEY
                    ) ?: ""

                startAthan()
            }

            ACTION_STOP -> {
                stopAthan()
            }
        }

        return START_NOT_STICKY
    }

    // =========================================================
    // START ATHAN
    // =========================================================

    private fun startAthan() {

        // Stop any previous athan
        stopMediaPlayer()

        // Start foreground service
        startForeground(
            NOTIFICATION_ID,
            createNotification()
        )

        // =====================================================
        // PLAY AZAN
        // =====================================================

        try {

            mediaPlayer =
                MediaPlayer.create(
                    this,
                    R.raw.azan
                )

            if (mediaPlayer == null) {

                sendAthanFinished()

                stopAthan()

                return
            }

            mediaPlayer?.setOnCompletionListener {

                sendAthanFinished()

                stopAthan()
            }

            mediaPlayer?.start()

        } catch (e: Exception) {

            e.printStackTrace()

            sendAthanFinished()

            stopAthan()
        }
    }

    // =========================================================
    // CREATE NOTIFICATION
    // =========================================================

    private fun createNotification(): Notification {

        val activityIntent =
            Intent(
                this,
                AthanActivity::class.java
            )

        activityIntent.putExtra(
            EXTRA_ATHAN_ID,
            currentAthanId
        )

        activityIntent.putExtra(
            EXTRA_PRAYER_NAME,
            currentPrayerName
        )

        activityIntent.putExtra(
            EXTRA_PRAYER_KEY,
            currentPrayerKey
        )

        activityIntent.flags =
            Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP

        val activityPendingIntent =
            PendingIntent.getActivity(
                this,
                currentAthanId,
                activityIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                        PendingIntent.FLAG_IMMUTABLE
            )

        return NotificationCompat.Builder(
            this,
            CHANNEL_ID
        )
            .setSmallIcon(
                android.R.drawable.ic_lock_idle_alarm
            )
            .setContentTitle(
                "حان الآن موعد الأذان"
            )
            .setContentText(
                "أذان $currentPrayerName"
            )
            .setPriority(
                NotificationCompat.PRIORITY_MAX
            )
            .setCategory(
                NotificationCompat.CATEGORY_ALARM
            )
            .setOngoing(true)
            .setAutoCancel(false)
            .setContentIntent(
                activityPendingIntent
            )
            .setFullScreenIntent(
                activityPendingIntent,
                true
            )
            .setVisibility(
                NotificationCompat.VISIBILITY_PUBLIC
            )
            .build()
    }

    // =========================================================
    // NOTIFICATION CHANNEL
    // =========================================================

    private fun createNotificationChannel() {

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.O
        ) {

            val channel =
                NotificationChannel(
                    CHANNEL_ID,
                    CHANNEL_NAME,
                    NotificationManager.IMPORTANCE_HIGH
                )

            channel.description =
                "Athan playback notification"

            // Notification itself has no sound.
            // The actual athan is played by MediaPlayer.
            channel.setSound(
                null,
                null
            )

            channel.enableVibration(true)

            val manager =
                getSystemService(
                    Context.NOTIFICATION_SERVICE
                ) as NotificationManager

            manager.createNotificationChannel(
                channel
            )
        }
    }

    // =========================================================
    // STOP MEDIA PLAYER
    // =========================================================

    private fun stopMediaPlayer() {

        try {
            mediaPlayer?.stop()
        } catch (_: Exception) {
        }

        try {
            mediaPlayer?.release()
        } catch (_: Exception) {
        }

        mediaPlayer = null
    }

    // =========================================================
    // STOP ATHAN
    // =========================================================

    private fun stopAthan() {

        stopMediaPlayer()

        val manager =
            getSystemService(
                Context.NOTIFICATION_SERVICE
            ) as NotificationManager

        manager.cancel(
            NOTIFICATION_ID
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            stopForeground(
                STOP_FOREGROUND_REMOVE
            )
        } else {
            @Suppress("DEPRECATION")
            stopForeground(true)
        }

        stopSelf()
    }

    // =========================================================
    // ATHAN FINISHED
    // =========================================================

    private fun sendAthanFinished() {

        val intent =
            Intent(
                ACTION_ATHAN_FINISHED
            )

        intent.setPackage(
            packageName
        )

        intent.putExtra(
            EXTRA_ATHAN_ID,
            currentAthanId
        )

        sendBroadcast(
            intent
        )
    }

    // =========================================================
    // ON DESTROY
    // =========================================================

    override fun onDestroy() {

        stopMediaPlayer()

        val manager =
            getSystemService(
                Context.NOTIFICATION_SERVICE
            ) as NotificationManager

        manager.cancel(
            NOTIFICATION_ID
        )

        super.onDestroy()
    }

    // =========================================================
    // ON BIND
    // =========================================================

    override fun onBind(
        intent: Intent?
    ): IBinder? {
        return null
    }
}