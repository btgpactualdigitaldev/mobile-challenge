package com.example.currencyconverter.utils

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build

class Connection {

    fun connected(context: Context): Boolean {
        val connection: ConnectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
            val netInfo = connection.activeNetwork ?: return false
            val network = connection.getNetworkCapabilities(netInfo) ?: return false
            return when{
                network.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
                network.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
                network.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> true
                network.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH) -> true
                else -> false
            }
        } else{
            return connection.activeNetworkInfo?.isConnected ?: false
        }
    }
}