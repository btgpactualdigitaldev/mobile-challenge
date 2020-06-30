package br.com.daccandido.currencyconverterapp.helper

import android.annotation.SuppressLint
import android.content.Context
import android.content.SharedPreferences
import br.com.daccandido.currencyconverterapp.data.model.*

@Suppress("NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS")
@SuppressLint("ApplySharedPref", "CommitPrefEdits")
class PreferencesHelper (context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences(PREFS_FILENAME, Context.MODE_PRIVATE)

    var currencyCodeCurrentSource: String
        get() {
            return prefs.getString(CURRENT_CURRENCY_CODE_FROM, "BRL")!!
        }
        set(value) {
            prefs.edit().putString(CURRENT_CURRENCY_CODE_FROM, value).commit()
        }

    var currencyCodeCurrentTarget: String
        get() {
            return prefs.getString(CURRENT_CURRENCY_CODE_TO, "USD")!!
        }
        set(value) {
            prefs.edit().putString(CURRENT_CURRENCY_CODE_TO, value).commit()
        }

    var currencyNameCurrentTarget : String
        get() {
            return prefs.getString(CURRENT_CURRENCY_NAME_TO, "United States Dollar")!!
        }
        set(value) {
            prefs.edit().putString(CURRENT_CURRENCY_NAME_TO, value).commit()
        }

    var currencyNameCurrentSource : String
         get() {
             return prefs.getString(CURRENT_CURRENCY_NAME_FROM, "Brazilian Real")!!
         }
         set(value) {
             prefs.edit().putString(CURRENT_CURRENCY_NAME_FROM, value).commit()
         }

    var isDownloadingInfo: Boolean
        get() {
            return  prefs.getBoolean(IS_DOWNLOADING, false)
        }
        set(value) {
            prefs.edit().putBoolean(IS_DOWNLOADING, value).commit()
        }
}