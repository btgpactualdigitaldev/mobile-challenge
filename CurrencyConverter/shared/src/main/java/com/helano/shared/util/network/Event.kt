package com.helano.shared.util.network

sealed class Event {
    object ConnectivityEvent : Event()
}