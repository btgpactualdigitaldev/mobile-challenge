package com.helano.shared.util.network.core

import android.net.ConnectivityManager
import android.net.Network

internal class NetworkCallbackImp(private val stateHolder: NetworkStateImp) :
    ConnectivityManager.NetworkCallback() {

    override fun onAvailable(network: Network) {
        stateHolder.isAvailable = true
    }

    override fun onLost(network: Network) {
        stateHolder.isAvailable = false
    }
}