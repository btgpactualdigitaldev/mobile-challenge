package com.lucasnav.desafiobtg.modules.currencyConverter.database

import androidx.room.*
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import io.reactivex.Observable

@Dao
interface CurrenciesDao {

    @Query("SELECT * FROM currencies")
    fun getCurrencies(): Observable<List<Currency>>

    @Transaction
    fun deleteAndInsert(currencies: List<Currency>) {
        deleteCurrencies()
        insertAll(currencies)
    }

    @Query("DELETE FROM currencies")
    fun deleteCurrencies()

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(currencies: List<Currency>)

    @Query("SELECT * FROM currencies WHERE ID=:id")
    fun getCurrency(id: String): Observable<Currency>

    @Query("SELECT * FROM currencies WHERE name LIKE :query OR symbol LIKE :query")
    fun searchCurrencies(query: String): Observable<List<Currency>>
}