package com.carlos.silva.desafiobtg.interfaces

import android.view.View

interface CurrencieClickListener {
    fun onClick (pair: Pair<String, String>, view: View?)
}