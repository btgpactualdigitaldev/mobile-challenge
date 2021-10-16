package com.helano.shared.util.network

import android.app.Application
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import com.helano.shared.util.network.core.ActivityLifecycleCallbacksImp
import com.helano.shared.util.network.core.NetworkCallbackImp
import com.helano.shared.util.network.core.NetworkEvent
import com.helano.shared.util.network.core.NetworkStateImp

object ConnectivityStateHolder : ConnectivityState {

    private val mutableSet: MutableSet<NetworkState> = mutableSetOf()

    override val networkStats: Iterable<NetworkState>
        get() = mutableSet

    private fun networkEventHandler(state: NetworkState, event: NetworkEvent) {
        when (event) {
            is NetworkEvent.AvailabilityEvent -> {
                if (isConnected != event.oldNetworkAvailability) {
                    NetworkEvents.notify(Event.ConnectivityEvent)
                }
            }
        }
    }

    fun Application.registerConnectivityBroadcaster() {
        registerActivityLifecycleCallbacks(ActivityLifecycleCallbacksImp())

        val connManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        listOf(
            NetworkRequest.Builder().addTransportType(NetworkCapabilities.TRANSPORT_CELLULAR)
                .build(),
            NetworkRequest.Builder().addTransportType(NetworkCapabilities.TRANSPORT_WIFI).build()
        ).forEach {
            val stateHolder = NetworkStateImp { a, b -> networkEventHandler(a, b) }
            mutableSet.add(stateHolder)
            connManager.registerNetworkCallback(it, NetworkCallbackImp(stateHolder))
        }
    }
}