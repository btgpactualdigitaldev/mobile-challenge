package br.com.cauejannini.btgmobilechallenge.commons

import android.content.Context
import android.content.SharedPreferences
import androidx.preference.PreferenceManager
import br.com.cauejannini.btgmobilechallenge.activities.seletordemoeda.CurrencyRecyclerViewAdapter
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.lang.reflect.Type


class SharedPreferencesHelper(context: Context) {

    private val SP_KEY_CURRENCY_MAP = "SP_KEY_CURRENCY_MAP"

    private var sp: SharedPreferences = PreferenceManager.getDefaultSharedPreferences(context)

    fun putCurrencyList(currencyList: List<Currency>) {
        val json = Gson().toJson(currencyList)
        sp.edit().putString(SP_KEY_CURRENCY_MAP, json).apply()
    }

    fun getCurrencyList(): List<Currency>? {
        sp.getString(SP_KEY_CURRENCY_MAP, null)?.let {json ->

            val list : List<Currency> = Gson().fromJson(json, object: TypeToken<List<Currency?>?>(){}.type)
            return list
        }
        return null
    }
}