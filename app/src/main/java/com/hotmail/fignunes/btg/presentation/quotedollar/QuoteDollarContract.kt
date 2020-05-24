package com.hotmail.fignunes.btg.presentation.quotedollar

interface QuoteDollarContract {
    fun message(error: String)
    fun source()
    fun destiny()
    fun hideKeyboard()
    fun progressbar(visible: Boolean)
}