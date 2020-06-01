package br.com.cauejannini.btgmobilechallenge.commons.integracao

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo

object ConnectionUtils {

    fun isConnected(context: Context?): Boolean {
        context?.let { contextNonNull ->
            val connectivityManager = contextNonNull.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            connectivityManager.activeNetworkInfo?.let { networkInfo ->
                return networkInfo.isConnected
            }
            return false
        }
        return true
    }

}