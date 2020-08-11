package com.svm.btgmoneyconverter.utils

import android.content.Context
import com.svm.btgmoneyconverter.data.database.CurrencyDB
import com.svm.btgmoneyconverter.data.database.QuoteDB

class DBAccess {

    companion object {
        lateinit var quotesAccess: QuoteDB
        lateinit var currenciesAccess: CurrencyDB

        fun initAccess(context: Context) {
            this.quotesAccess = QuoteDB(context)
            this.currenciesAccess = CurrencyDB(context)
        }

    }
}

