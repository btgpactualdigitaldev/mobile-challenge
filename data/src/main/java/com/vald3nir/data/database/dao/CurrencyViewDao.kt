package com.vald3nir.data.database.dao

import androidx.room.Dao
import androidx.room.Query
import com.vald3nir.data.database.model.CurrencyView

@Dao
interface CurrencyViewDao {

    @Query("SELECT flag.url AS url, currency.code AS code, currency.country AS description, exchange.value AS usdQuote FROM flag INNER JOIN currency INNER JOIN exchange ON flag.code = currency.code and (\"USD\" || currency.code) = exchange.quote")
    fun listAll(): List<CurrencyView>?

    @Query("SELECT flag.url AS url, currency.code AS code, currency.country AS description, exchange.value AS usdQuote FROM flag INNER JOIN currency INNER JOIN exchange ON flag.code = :code and currency.code = :code and (\"USD\" || currency.code) = exchange.quote")
    fun get(code: String?): CurrencyView?

}