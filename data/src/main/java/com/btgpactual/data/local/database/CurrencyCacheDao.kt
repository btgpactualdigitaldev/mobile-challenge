package com.btgpactual.data.local.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Transaction
import com.btgpactual.data.local.model.CurrencyCache
import io.reactivex.Single

@Dao
interface CurrencyCacheDao {
    @Query("SELECT * from tbl_currency")
    fun getCurrencies() : Single<List<CurrencyCache>>

    @Transaction
    fun updateData(currencies : List<CurrencyCache>){
        deleteAll()
        insertAll(currencies)
    }

    @Insert
    fun insertAll(currencies: List<CurrencyCache>)

    @Query("DELETE FROM tbl_currency")
    fun deleteAll()

}