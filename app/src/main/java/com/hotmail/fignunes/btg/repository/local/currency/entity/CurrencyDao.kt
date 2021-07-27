package com.hotmail.fignunes.btg.repository.local.currency.entity

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import io.reactivex.Maybe

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM ${CurrencyBean.TABLE}")
    fun getCurrencyBean(): Maybe<List<CurrencyBean>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(currencyBean: List<CurrencyBean>)

    @Query("DELETE FROM ${CurrencyBean.TABLE}")
    fun deleteAll()
}