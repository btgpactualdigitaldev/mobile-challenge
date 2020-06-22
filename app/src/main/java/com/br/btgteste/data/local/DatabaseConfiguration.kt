package com.br.btgteste.data.local

import android.content.Context
import androidx.room.Room
import com.br.btgteste.data.local.db.CurrencyDao
import com.br.btgteste.data.local.db.CurrencyLayerDataBase

class DatabaseConfiguration {
    fun createDatabase(context: Context) : CurrencyDao {
        return Room
            .databaseBuilder(context, CurrencyLayerDataBase::class.java,"ConverterCurrencyApp.db")
            .build()
            .currencyCacheDao()
    }
}