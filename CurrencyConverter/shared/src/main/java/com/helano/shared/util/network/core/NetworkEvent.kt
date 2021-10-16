package com.helano.shared.util.network.core

import com.helano.shared.util.network.NetworkState

sealed class NetworkEvent {
    abstract val state: NetworkState

    class AvailabilityEvent(
        override val state: NetworkState,
        val oldNetworkAvailability: Boolean
    ) : NetworkEvent()
}