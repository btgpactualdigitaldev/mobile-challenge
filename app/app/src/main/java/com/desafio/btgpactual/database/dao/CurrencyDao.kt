package com.desafio.btgpactual.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.desafio.btgpactual.shared.models.CurrencyModel
import com.desafio.btgpactual.shared.models.QuotesModel

@Dao
interface CurrencyDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertCurrencies(quotes: List<CurrencyModel>)

    @Query("SELECT * FROM currencyModel")
    fun getAllCurrencies(): List<CurrencyModel>
}