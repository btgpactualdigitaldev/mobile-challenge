package com.br.btgteste.data.local.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.br.btgteste.data.local.entity.CurrencyTb

@Dao
interface CurrencyDao {

    @Query("SELECT * from tb_currency")
    fun retrieve() : List<CurrencyTb>

    @Insert
    fun save(currencies : List<CurrencyTb>)

    @Query("DELETE FROM tb_currency")
    fun deleteAll()
}