package com.example.desafiobtg.utils

import android.content.Context
import android.net.ConnectivityManager
import com.google.android.material.dialog.MaterialAlertDialogBuilder

class ConnectionDetector(private val context: Context) {
    val isConnectingToInternet: Boolean
        get() {
            val connectivity =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetworkInfo = connectivity.activeNetworkInfo
            return activeNetworkInfo != null && activeNetworkInfo.isConnected
        }

    fun isConnectingToInternet(withAlert: Boolean): Boolean {
        if (isConnectingToInternet) {
            return true
        }
        MaterialAlertDialogBuilder(context)
            .setTitle("Sem conexão com a internet")
            .setMessage("Por favor, conecte com uma rede e tente novamente.")
            .setNeutralButton(
                "OK"
            ) { dialog, which -> dialog.dismiss() }.show()
        return false
    }

}