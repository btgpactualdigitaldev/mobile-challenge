package com.example.currencies.repository.local

import android.content.Context
import com.example.currencies.model.remote.CurrenciesModelRemote
import com.example.currencies.model.room.CurrenciesDatabase
import com.example.currencies.model.room.CurrenciesModelLocal

class CurrenciesLocalRepository (context: Context) {

    private val mDataBase = CurrenciesDatabase.getDatabase(context).CurrenciesDAO()

    fun saveCurrencies(model: CurrenciesModelLocal) {
        return mDataBase.saveCurrencies(model)
    }

    fun getAll(): List<CurrenciesModelLocal> {
        return mDataBase.getAllCurrencies()
    }

}
