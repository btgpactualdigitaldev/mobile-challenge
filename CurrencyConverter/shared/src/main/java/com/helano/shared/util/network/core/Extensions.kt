package com.helano.shared.util.network.core

import android.app.Activity
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import com.helano.shared.util.network.ConnectivityStateHolder
import com.helano.shared.util.network.Event
import com.helano.shared.util.network.NetworkConnectivityListener
import com.helano.shared.util.network.NetworkEvents

internal object Constants {
    const val ID_KEY = "network.monitoring.previousState"
}

internal fun NetworkConnectivityListener.onListenerCreated() {
    NetworkEvents.observe(this as LifecycleOwner, Observer {
        if (previousState != null)
            networkConnectivityChanged(it)
    })
}

internal fun NetworkConnectivityListener.onListenerResume() {
    if (!shouldBeCalled || !checkOnResume) return

    val previousState = previousState
    val isConnected = ConnectivityStateHolder.isConnected

    this.previousState = isConnected

    val connectionLost = previousState != false && !isConnected
    val connectionBack = previousState == false && isConnected

    if (connectionLost || connectionBack) {
        networkConnectivityChanged(Event.ConnectivityEvent)
    }
}

internal var NetworkConnectivityListener.previousState: Boolean?
    get() {
        return when (this) {
            is Fragment -> arguments?.previousState
            is Activity -> intent.extras?.previousState
            else -> null
        }
    }
    set(value) {
        when (this) {
            is Fragment -> {
                val a = arguments ?: Bundle()
                a.previousState = value
                arguments = a
            }
            is Activity -> {
                val a = intent.extras ?: Bundle()
                a.previousState = value
                intent.replaceExtras(a)
            }
        }
    }

internal var Bundle.previousState: Boolean?
    get() = when (getInt(Constants.ID_KEY, -1)) {
        -1 -> null
        0 -> false
        else -> true
    }
    set(value) {
        putInt(Constants.ID_KEY, if (value == true) 1 else 0)
    }