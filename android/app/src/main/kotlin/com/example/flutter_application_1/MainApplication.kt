package com.example.flutter_application_1

import android.util.Log
import com.moengage.core.DataCenter
import com.moengage.core.LogLevel
import com.moengage.core.config.LogConfig
import com.moengage.core.MoEngage

import com.moengage.core.config.NotificationConfig
import com.moengage.firebase.MoEFireBaseHelper
import com.moengage.flutter.MoEInitializer
import io.flutter.app.FlutterApplication
import com.moengage.core.config.FcmConfig
import com.moengage.pushbase.MoEPushHelper

class MainApplication : FlutterApplication(){
    override fun onCreate() {
        super.onCreate()

        MoEFireBaseHelper.getInstance().addTokenListener{
            Log.d("Abhi",it.pushToken.toString())
        }
        val moEngage: MoEngage.Builder = MoEngage.Builder(this,"OXTAVQZDWWAROL2ESF8FWE8G",DataCenter.DATA_CENTER_1)
        .configureLogs(
            LogConfig(LogLevel.VERBOSE)
        )
            .configureNotificationMetaData(
                NotificationConfig(R.drawable.ic_launcher_foreground, R.drawable.ic_launcher_foreground)
            ).configureFcm(FcmConfig(true))

        MoEInitializer.initialiseDefaultInstance(context = this, builder = moEngage)

        MoEPushHelper.getInstance().registerMessageListener(pushlistenerclass())
    }
}