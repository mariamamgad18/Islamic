package com.example.islamic

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.media.MediaPlayer
import android.os.Build
import android.os.IBinder
import android.util.Log

class AthanService : Service() {

    companion object {

        private const val TAG = "AthanService"

        private const val CHANNEL_ID =
            "athan_playback_channel"

        private const val NOTIFICATION_ID = 2001

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
    }

    private var mediaPlayer: MediaPlayer? = null

    private var currentAthanId: Int = 0

    private var currentPrayerName: String = ""

    private var currentPrayerKey: String = ""

    override fun onCreate() {
        super.onCreate()

        Log.d(TAG, "================================")
        Log.d(TAG, "ATHAN SERVICE CREATED")
        Log.d(TAG, "================================")

        createNotificationChannel()
    }

    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int
    ): Int {

        if (intent == null) {
            return START_NOT_STICKY
        }

        when (intent.action) {

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

                Log.d(TAG, "START ATHAN")
                Log.d(TAG, "ID: $currentAthanId")
                Log.d(TAG, "Prayer: $currentPrayerName")
                Log.d(TAG, "Prayer Key: $currentPrayerKey")

                startForegroundWithNotification()

                playAthan()
            }

            ACTION_STOP -> {

                Log.d(
                    TAG,
                    "STOP ATHAN REQUESTED"
                )

                stopAthan()
            }
        }

        return START_NOT_STICKY
    }

    // =========================================================
    // START FOREGROUND SERVICE
    // =========================================================

    private fun startForegroundWithNotification() {

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

        activityIntent.addFlags(
            Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP
        )

        val fullScreenPendingIntent =
            PendingIntent.getActivity(
                this,
                currentAthanId,
                activityIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                        PendingIntent.FLAG_IMMUTABLE
            )

        val notificationManager =
            getSystemService(
                NotificationManager::class.java
            )

        /*
         * Android 14+:
         *
         * Full Screen Intent permission can be disabled
         * by the user/system.
         *
         * We check it here before attaching the
         * Full Screen Intent.
         */
        val canUseFullScreenIntent =
            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.UPSIDE_DOWN_CAKE
            ) {
                notificationManager.canUseFullScreenIntent()
            } else {
                true
            }

        Log.d(
            TAG,
            "CAN USE FULL SCREEN INTENT: " +
                    canUseFullScreenIntent
        )

        val notificationBuilder =
            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.O
            ) {

                Notification.Builder(
                    this,
                    CHANNEL_ID
                )

            } else {

                Notification.Builder(this)
            }

        notificationBuilder
            .setSmallIcon(
                R.mipmap.ic_launcher
            )
            .setContentTitle(
                "حان الآن وقت $currentPrayerName"
            )
            .setContentText(
                "الأذان"
            )
            .setCategory(
                Notification.CATEGORY_ALARM
            )
            .setPriority(
                Notification.PRIORITY_MAX
            )
            .setVisibility(
                Notification.VISIBILITY_PUBLIC
            )
            .setAutoCancel(false)
            .setOngoing(true)

        /*
         * This is the important part.
         *
         * If Full Screen Intent permission is enabled,
         * Android can launch AthanActivity immediately.
         */
        if (canUseFullScreenIntent) {

            notificationBuilder.setFullScreenIntent(
                fullScreenPendingIntent,
                true
            )

            Log.d(
                TAG,
                "FULL SCREEN INTENT ATTACHED"
            )

        } else {

            Log.w(
                TAG,
                "FULL SCREEN INTENT PERMISSION IS DISABLED"
            )
        }

        val notification =
            notificationBuilder.build()

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.Q
        ) {

            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo
                    .FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK
            )

        } else {

            @Suppress("DEPRECATION")
            startForeground(
                NOTIFICATION_ID,
                notification
            )
        }
    }

    // =========================================================
    // PLAY ATHAN
    // =========================================================

    private fun playAthan() {

        stopMediaPlayerOnly()

        try {

            mediaPlayer =
                MediaPlayer.create(
                    this,
                    R.raw.azan
                )

            if (mediaPlayer == null) {

                Log.e(
                    TAG,
                    "MEDIA PLAYER CREATION FAILED"
                )

                stopAthan()

                return
            }

            mediaPlayer?.setOnCompletionListener {

                Log.d(
                    TAG,
                    "ATHAN AUDIO FINISHED"
                )

                sendAthanFinished()

                stopAthan()
            }

            mediaPlayer?.setOnErrorListener { _,
                                              what,
                                              extra ->

                Log.e(
                    TAG,
                    "MEDIA PLAYER ERROR: " +
                            "what=$what extra=$extra"
                )

                sendAthanFinished()

                stopAthan()

                true
            }

            mediaPlayer?.start()

            Log.d(
                TAG,
                "ATHAN AUDIO STARTED"
            )

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ERROR PLAYING ATHAN",
                e
            )

            stopAthan()
        }
    }

    // =========================================================
    // STOP ATHAN
    // =========================================================

    private fun stopAthan() {

        stopMediaPlayerOnly()

        try {

            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.N
            ) {

                stopForeground(
                    STOP_FOREGROUND_REMOVE
                )

            } else {

                @Suppress("DEPRECATION")
                stopForeground(true)
            }

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ERROR STOPPING FOREGROUND",
                e
            )
        }

        stopSelf()

        Log.d(
            TAG,
            "ATHAN SERVICE STOPPED"
        )
    }

    // =========================================================
    // STOP MEDIA PLAYER ONLY
    // =========================================================

    private fun stopMediaPlayerOnly() {

        try {

            if (
                mediaPlayer?.isPlaying == true
            ) {
                mediaPlayer?.stop()
            }

        } catch (_: Exception) {
        }

        try {

            mediaPlayer?.release()

        } catch (_: Exception) {
        }

        mediaPlayer = null
    }

    // =========================================================
    // FINISHED BROADCAST
    // =========================================================

    private fun sendAthanFinished() {

        val finishedIntent =
            Intent(
                ACTION_ATHAN_FINISHED
            )

        finishedIntent.setPackage(
            packageName
        )

        finishedIntent.putExtra(
            EXTRA_ATHAN_ID,
            currentAthanId
        )

        sendBroadcast(
            finishedIntent
        )
    }

    // =========================================================
    // NOTIFICATION CHANNEL
    // =========================================================

    private fun createNotificationChannel() {

        if (
            Build.VERSION.SDK_INT <
            Build.VERSION_CODES.O
        ) {
            return
        }

        val channel =
            NotificationChannel(
                CHANNEL_ID,
                "أذان الصلاة",
                NotificationManager.IMPORTANCE_HIGH
            )

        channel.description =
            "تشغيل الأذان في وقت الصلاة"

        /*
         * Audio itself comes from MediaPlayer.
         * Therefore notification channel sound is disabled
         * to prevent duplicate audio.
         */
        channel.setSound(
            null,
            null
        )

        channel.enableVibration(true)

        val notificationManager =
            getSystemService(
                NotificationManager::class.java
            )

        notificationManager.createNotificationChannel(
            channel
        )
    }

    override fun onBind(
        intent: Intent?
    ): IBinder? {

        return null
    }

    override fun onDestroy() {

        Log.d(
            TAG,
            "ATHAN SERVICE DESTROYED"
        )

        stopMediaPlayerOnly()

        super.onDestroy()
    }
}
