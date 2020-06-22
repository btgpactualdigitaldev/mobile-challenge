package com.br.btgteste.data.local.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.br.btgteste.data.local.entity.CurrencyTb

@Database(version = 1, entities = [CurrencyTb::class])
abstract class CurrencyLayerDataBase : RoomDatabase() {
    abstract fun currencyCacheDao() : CurrencyDao
}