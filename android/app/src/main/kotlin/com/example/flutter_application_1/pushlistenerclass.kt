package com.example.flutter_application_1

import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.util.Log
import com.moengage.pushbase.push.PushMessageListener


class pushlistenerclass : PushMessageListener() {
    override fun onNotificationClick(
        activity: Activity,
        payload: Bundle
    ): Boolean {
         super.onNotificationClick(
            activity,
            payload
        )

        Log.d("Abhi", "I clicked the notifffff")

        return true;
    }

    override fun onNotificationReceived(
        context: Context,
        payload: Bundle
    ) {
        super.onNotificationReceived(
            context,
            payload
        )
        Log.d("Abhi", "I clicked the notifffff")

    }

}