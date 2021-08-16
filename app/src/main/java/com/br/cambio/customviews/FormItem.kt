package com.br.cambio.customviews

import android.content.Context
import android.util.TypedValue
import android.view.View
import com.br.cambio.R

interface FormItem {

    companion object {
        const val FIELD_TYPE_NONE = 0
        const val FIELD_TYPE_CPF = 1
        const val FIELD_TYPE_NAME = 2
        const val FIELD_TYPE_DATE = 3
        const val FIELD_TYPE_EMAIL = 4
        const val FIELD_TYPE_PHONE = 5
        const val FIELD_TYPE_CURRENCY = 6
        const val FIELD_TYPE_PASSWORD = 7
        const val FIELD_TYPE_CEP = 8
        const val FIELD_TYPE_CNPJ = 10
        const val FIELD_TYPE_SPINNER = 11
        const val FIELD_TYPE_RADIOGROUP = 19
        const val FIELD_TYPE_NUMBER = 77
        const val FIELD_TYPE_TEXT = 88
        const val FIELD_TYPE_DATE_MM_YYYY = 99
        const val FIELD_TYPE_CURRENCY_REQUIRED = 97
        const val FIELD_TYPE_RG = 31
        const val FIELD_TYPE_CNH = 32
        const val FIELD_TYPE_RNE = 33
        const val FIELD_TYPE_ADDRESS = 34
        const val FIELD_TYPE_CITY_DISTRICT = 35
        const val FIELD_TYPE_COMPLEMENT = 36
        const val FIELD_TYPE_CURRENCY_INCOME = 37
        const val FIELD_TYPE_COMPANY_NAME = 55
    }
}