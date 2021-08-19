package com.example.roomdatabase.dao

import androidx.room.*
import com.example.challengesavio.data.entity.Currency

@Dao
interface CurrencyDao {

    @Query("SELECT * FROM currency") fun getAllCurrencies() : List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE) fun insertCurrencies(vararg currencies: Currency)

}