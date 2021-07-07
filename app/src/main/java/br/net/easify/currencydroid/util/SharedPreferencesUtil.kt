package br.net.easify.currencydroid.util

import android.content.Context
import androidx.preference.PreferenceManager
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class SharedPreferencesUtil @Inject constructor(context: Context) {

    private val prefs =
        PreferenceManager.getDefaultSharedPreferences(context.applicationContext)

    private val lastRateUpdate = "lastRateUpdate"
    private val fromCurrency = "fromCurrency"
    private val toCurrency = "toCurrency"

    fun setLastRateUpdate(value: Long) {
        prefs.edit().putLong(lastRateUpdate, value).apply()
    }

    fun getLastRateUpdate(): Long {
        return if (prefs != null) {
            prefs.getLong(lastRateUpdate, 0)!!
        } else {
            0
        }
    }

    fun setFromCurrency(value: String) {
        prefs.edit().putString(fromCurrency, value).apply()
    }

    fun getFromCurrency(): String {
        return if (prefs != null) {
            prefs.getString(fromCurrency, Constants.defaultFromCurrency)!!
        } else {
            Constants.defaultFromCurrency
        }
    }

    fun setToCurrency(value: String) {
        prefs.edit().putString(toCurrency, value).apply()
    }

    fun getToCurrency(): String {
        return if (prefs != null) {
            prefs.getString(toCurrency, Constants.defaultToCurrency)!!
        } else {
            Constants.defaultToCurrency
        }
    }
}