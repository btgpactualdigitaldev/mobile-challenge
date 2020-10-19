package com.btgpactual.teste.mobile_challenge.util

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build

/**
 * Created by Carlos Souza on 16,October,2020
 */
object Connection {

    fun hasInternet(context: Context): Boolean {
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            cm.getNetworkCapabilities(cm.activeNetwork)!!.hasCapability(
                NetworkCapabilities.NET_CAPABILITY_INTERNET
            )
        } else {
            cm.activeNetworkInfo != null && cm.activeNetworkInfo!!.isAvailable && cm.activeNetworkInfo!!.isConnected
        }
    }
}