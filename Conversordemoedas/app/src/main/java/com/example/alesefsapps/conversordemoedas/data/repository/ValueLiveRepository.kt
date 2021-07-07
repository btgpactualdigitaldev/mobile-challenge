package com.example.alesefsapps.conversordemoedas.data.repository

import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult

interface ValueLiveRepository {
    fun getValueLive(valueResultCallback: (result: LiveValueResult) -> Unit)
}