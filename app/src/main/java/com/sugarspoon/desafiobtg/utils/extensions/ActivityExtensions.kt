package com.sugarspoon.desafiobtg.utils.extensions

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Parcelable
import androidx.core.content.ContextCompat
import java.io.Serializable

inline fun <reified T : Activity> Context.intentFor(vararg args: Pair<String, Any?>): Intent {
    val intent = Intent(this, T::class.java)
    args.forEach { (key, value) ->
        when (value) {
            is Int -> intent.putExtra(key, value)
            is Short -> intent.putExtra(key, value)
            is Long -> intent.putExtra(key, value)
            is Float -> intent.putExtra(key, value)
            is Double -> intent.putExtra(key, value)
            is String -> intent.putExtra(key, value)
            is Boolean -> intent.putExtra(key, value)
            is Byte -> intent.putExtra(key, value)
            is Char -> intent.putExtra(key, value)
            is Parcelable -> intent.putExtra(key, value)
            is Serializable -> intent.putExtra(key, value)
        }
    }
    return intent
}