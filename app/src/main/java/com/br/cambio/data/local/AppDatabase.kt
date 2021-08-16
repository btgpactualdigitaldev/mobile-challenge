package com.br.cambio.data.local

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.model.PriceDomain

@Database(entities = [CurrencyDomain::class, PriceDomain::class], version = 1, exportSchema = false)
@TypeConverters()
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao

    abstract fun priceDao(): PriceDao
}