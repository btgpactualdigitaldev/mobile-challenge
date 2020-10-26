package com.helano.shared.util.network

import androidx.lifecycle.LiveData

object NetworkEvents : LiveData<Event>() {
    fun notify(event: Event) {
        postValue(event)
    }
}