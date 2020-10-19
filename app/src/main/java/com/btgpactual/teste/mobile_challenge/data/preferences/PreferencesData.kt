package com.btgpactual.teste.mobile_challenge.data.preferences

import android.content.Context
import androidx.core.content.edit
import com.btgpactual.teste.mobile_challenge.MainApplication
import javax.inject.Inject

/**
 * Created by Carlos Souza on 16,October,2020
 */
class PreferencesData @Inject constructor(mainApplication: MainApplication): IPreferences {

    private val preferences = mainApplication.getSharedPreferences("currency_converter", Context.MODE_PRIVATE)

    private val LAST_UPDATE = "last_update"
    private val ORIGIN = "origin"
    private val TARGET = "target"
    private val QUOTATION = "quotation"

    override fun setLastUpdate(value: String) {
        preferences.edit(commit = true) {
            putString(LAST_UPDATE, value)
        }
    }

    override fun getLastUpdate(): String {
        return preferences.getString(LAST_UPDATE, "") ?: ""
    }

    override fun setOrigin(value: String) {
        preferences.edit(commit = true) {
            putString(ORIGIN, value)
        }
    }

    override fun getOrigin(): String {
        return preferences.getString(ORIGIN, "USD") ?: "USD"
    }

    override fun setTarget(value: String) {
        preferences.edit(commit = true) {
            putString(TARGET, value)
        }
    }

    override fun getTarget(): String {
        return preferences.getString(TARGET, "USD") ?: "USD"
    }

    override fun setQuotation(value: Float) {
        preferences.edit(commit = true) {
            putFloat(QUOTATION, value)
        }
    }

    override fun getQuotation(): Float {
        return preferences.getFloat(QUOTATION, 0F)
    }
}