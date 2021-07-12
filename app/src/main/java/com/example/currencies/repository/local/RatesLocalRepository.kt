package com.example.currencies.repository.local

import android.content.Context
import com.example.currencies.model.room.CurrenciesDatabase
import com.example.currencies.model.room.RatesModelLocal

class RatesLocalRepository (context: Context){

     private val mDataBase = CurrenciesDatabase.getDatabase(context).RatesDAO()

    fun saveRates(model: RatesModelLocal) {
        return mDataBase.saveRates(model)
    }

    fun picRates(abbrev: String): RatesModelLocal {
        return mDataBase.picRates(abbrev)
    }
}