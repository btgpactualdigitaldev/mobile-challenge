package com.helano.shared.util.network

interface NetworkConnectivityListener {

    val shouldBeCalled: Boolean
        get() = true

    val checkOnResume: Boolean
        get() = true

    fun networkConnectivityChanged(event: Event)
}