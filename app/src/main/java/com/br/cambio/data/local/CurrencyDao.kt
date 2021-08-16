package com.br.cambio.data.local

import androidx.room.*
import com.br.cambio.data.model.Currency
import com.br.cambio.domain.model.CurrencyDomain

@Dao
interface CurrencyDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCurrencyList(currency: List<CurrencyDomain>)

    @Query("SELECT * FROM Currency")
    suspend fun getCurrencyList(): List<CurrencyDomain>
}