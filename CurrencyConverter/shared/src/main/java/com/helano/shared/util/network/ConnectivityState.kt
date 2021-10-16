package com.helano.shared.util.network

interface ConnectivityState {
    val isConnected: Boolean
        get() = networkStats.any {
            it.isAvailable
        }

    val networkStats: Iterable<NetworkState>
}