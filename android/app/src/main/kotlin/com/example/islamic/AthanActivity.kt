package com.example.islamic

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class AthanActivity : FlutterActivity() {

    companion object {

        private const val CHANNEL =
            "athan_activity_channel"
    }

    private var athanId: Int = 0

    private var prayerName: String = ""

    private var prayerKey: String = ""

    private val athanFinishedReceiver =
        object : BroadcastReceiver() {

            override fun onReceive(
                context: Context?,
                intent: Intent?
            ) {

                if (
                    intent?.action ==
                    AthanService.ACTION_ATHAN_FINISHED
                ) {

                    val finishedId =
                        intent.getIntExtra(
                            AthanService.EXTRA_ATHAN_ID,
                            0
                        )

                    if (
                        finishedId == athanId
                    ) {

                        finish()
                    }
                }
            }
        }

    override fun onCreate(
        savedInstanceState: Bundle?
    ) {

        super.onCreate(
            savedInstanceState
        )

        readAthanData(intent)

        // =====================================================
        // SHOW OVER LOCK SCREEN
        // =====================================================

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.O_MR1
        ) {

            setShowWhenLocked(true)

            setTurnScreenOn(true)
        }

        window.addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
        )

        window.addFlags(
            WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )

        window.addFlags(
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
        )

        /*
         * Dismiss keyguard when possible.
         *
         * This allows the Athan screen to be visible immediately
         * instead of staying behind the lock screen.
         */
        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.O
        ) {

            window.addFlags(
                WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
            )
        }

        registerAthanFinishedReceiver()
    }

    // =========================================================
    // READ ATHAN DATA
    // =========================================================

    private fun readAthanData(
        intent: Intent?
    ) {

        if (intent == null) {
            return
        }

        athanId =
            intent.getIntExtra(
                AthanService.EXTRA_ATHAN_ID,
                0
            )

        prayerName =
            intent.getStringExtra(
                AthanService.EXTRA_PRAYER_NAME
            ) ?: ""

        prayerKey =
            intent.getStringExtra(
                AthanService.EXTRA_PRAYER_KEY
            ) ?: ""
    }

    // =========================================================
    // REGISTER RECEIVER
    // =========================================================

    private fun registerAthanFinishedReceiver() {

        val filter =
            IntentFilter(
                AthanService.ACTION_ATHAN_FINISHED
            )

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.TIRAMISU
        ) {

            registerReceiver(
                athanFinishedReceiver,
                filter,
                Context.RECEIVER_NOT_EXPORTED
            )

        } else {

            @Suppress("DEPRECATION")
            registerReceiver(
                athanFinishedReceiver,
                filter
            )
        }
    }

    // =========================================================
    // FLUTTER CHANNEL
    // =========================================================

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

                "getAthanData" -> {

                    result.success(
                        mapOf(
                            "athanId" to athanId,
                            "prayerName" to prayerName,
                            "prayerKey" to prayerKey
                        )
                    )
                }

                "stopAthan" -> {

                    stopAthanService()

                    closeAthanScreen()

                    result.success(true)
                }

                else -> {

                    result.notImplemented()
                }
            }
        }
    }

    // =========================================================
    // STOP ATHAN SERVICE
    // =========================================================

    private fun stopAthanService() {

        val serviceIntent =
            Intent(
                this,
                AthanService::class.java
            )

        serviceIntent.action =
            AthanService.ACTION_STOP

        try {

            startService(
                serviceIntent
            )

        } catch (_: Exception) {
        }
    }
// =========================================================
// CLOSE ATHAN SCREEN
// =========================================================

    private fun closeAthanScreen() {

        try {

            finishAndRemoveTask()

        } catch (_: Exception) {

            finish()
        }
    }
    // =========================================================
    // HANDLE NEW INTENT
    // =========================================================

    override fun onNewIntent(
        intent: Intent
    ) {

        super.onNewIntent(intent)

        setIntent(intent)

        readAthanData(intent)
    }

    // =========================================================
    // DESTROY
    // =========================================================

    override fun onDestroy() {

        try {

            unregisterReceiver(
                athanFinishedReceiver
            )

        } catch (_: Exception) {
        }

        super.onDestroy()
    }

    override fun getInitialRoute(): String {

        return "/athan"
    }
}
