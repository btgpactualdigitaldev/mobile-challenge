package com.renderson.currency_converter.other

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build

fun getConnectType (context: Context): Boolean {
    var result = false

    val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        cm.run {
            cm.getNetworkCapabilities(cm.activeNetwork)?.run{
                result = when {
                    hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> {
                        true
                    }
                    hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> {
                        true
                    }
                    else -> {
                        false
                    }
                }
            }
        }
    } else {
        cm.run {
            cm.activeNetworkInfo?.run {
                result = when (type) {
                    ConnectivityManager.TYPE_WIFI -> {
                        true
                    }
                    ConnectivityManager.TYPE_MOBILE -> {
                        true
                    }
                    else -> {
                        false
                    }
                }
            }
        }
    }
    return  result
}