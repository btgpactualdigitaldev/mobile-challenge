package com.btg.converter.domain.entity.currency

import android.content.Context
import com.btg.converter.R
import java.io.Serializable

data class Currency(
    val code: String,
    val name: String
) : Serializable {

    fun getFormattedString(context: Context) =
        context.getString(R.string.currency_template, name, code)
}