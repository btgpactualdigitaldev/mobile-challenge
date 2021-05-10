@file:Suppress("DEPRECATION")

package com.geocdias.convecurrency.util

import android.net.*
import android.os.Build
import androidx.lifecycle.LiveData

class NetworkConnectionLiveData (private val connectivityManager: ConnectivityManager): LiveData<Boolean>() {

//    @RequiresPermission(android.Manifest.permission.ACCESS_NETWORK_STATE)
//    constructor(application: Application) : this(application.getSystemService(Context.CONNECTIVITY_SERVICE)
//            as ConnectivityManager)

    private val networkRequest = NetworkRequest.Builder()
        .addTransportType(NetworkCapabilities.TRANSPORT_CELLULAR)
        .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
        .build()

    private val networkCallback = object : ConnectivityManager.NetworkCallback() {

        override fun onAvailable(network: Network) {

           postValue(true)
        }

        override fun onLost(network: Network) {
           postValue(false)
        }
    }

    override fun onActive() {
        super.onActive()

        val activeNetwork: NetworkInfo? = connectivityManager.activeNetworkInfo
        postValue(activeNetwork?.isConnectedOrConnecting == true)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            connectivityManager.registerDefaultNetworkCallback(networkCallback)
        } else {
            connectivityManager.registerNetworkCallback(networkRequest, networkCallback)
        }
    }

    override fun onInactive() {
        super.onInactive()
        connectivityManager.unregisterNetworkCallback(networkCallback)
    }
 }
