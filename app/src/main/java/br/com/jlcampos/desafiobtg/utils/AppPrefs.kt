package br.com.jlcampos.desafiobtg.utils

import android.content.Context
import android.content.SharedPreferences

class AppPrefs (context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences(Constants.IDENTIFICATION, Context.MODE_PRIVATE)
    private val editor: SharedPreferences.Editor = prefs.edit()

    fun setListCurrencies(currencies: String?) {
        editor.putString(Constants.list_currencies, currencies)
        editor.commit()
    }

    fun getListCurrencies() = prefs.getString(Constants.list_currencies, "")

    fun setMyQuotes(quotes: String?) {
        editor.putString(Constants.live_quotes, quotes)
        editor.commit()
    }

    fun getMyQuotes() = prefs.getString(Constants.live_quotes, "{}")
}