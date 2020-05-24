package com.hotmail.fignunes.btg.presentation.common

import android.content.Context
import android.net.ConnectivityManager

class CheckIsOnline(private val context: Context) {

    fun execute(): Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val networkInfo = connectivityManager.activeNetworkInfo
        return networkInfo != null && networkInfo.isConnected
    }
}