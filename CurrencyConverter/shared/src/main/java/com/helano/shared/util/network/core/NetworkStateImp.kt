package com.helano.shared.util.network.core

import com.helano.shared.util.network.NetworkState

internal class NetworkStateImp(callback: (NetworkState, NetworkEvent) -> Unit) : NetworkState {

    private var notify: (NetworkEvent) -> Unit

    init {
        this.notify = { e: NetworkEvent -> callback(this, e) }
    }

    override var isAvailable: Boolean = false
        set(value) {
            val old = field
            field = value
            notify(NetworkEvent.AvailabilityEvent(this, old))
        }
}