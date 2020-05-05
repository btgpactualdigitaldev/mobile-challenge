package com.btg.conversormonetario.business.database

import android.app.Application
import android.content.Context
import com.btg.conversormonetario.di.BTG_PREFERENCES
import com.btg.conversormonetario.di.getSharedPrefs

open class DataManager(var application: Application) {
    private val sharedPreferencesEdit = getSharedPrefs(application).edit()

    companion object {
        const val ORIGIN_CURRENCY_CODE = "ORIGIN_CURRENCY_CODE"
        const val TARGET_CURRENCY_CODE = "TARGET_CURRENCY_CODE"
    }

    fun saveOriginCurrencyCode(code: String) {
        sharedPreferencesEdit.putString(ORIGIN_CURRENCY_CODE, code)
        sharedPreferencesEdit.apply()
    }

    fun saveTargetCurrencyCode(code: String) {
        sharedPreferencesEdit.putString(TARGET_CURRENCY_CODE, code)
        sharedPreferencesEdit.apply()
    }

    fun getOriginCurrencyCode(): String? =
        application.getSharedPreferences(BTG_PREFERENCES, Context.MODE_PRIVATE).getString(
            ORIGIN_CURRENCY_CODE,
            ""
        ) ?: ""

    fun getTargetCurrencyCode(): String? =
        application.getSharedPreferences(BTG_PREFERENCES, Context.MODE_PRIVATE).getString(
            TARGET_CURRENCY_CODE,
            ""
        ) ?: ""

}