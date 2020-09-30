package com.btgpactual.currencyconverter.data.framework.roomdatabase.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.CurrencyEntity

@Dao
interface CurrencyDAO {

    @Insert
    suspend fun insert(conversion: CurrencyEntity): Long

    @Update
    suspend fun update(conversion: CurrencyEntity)

    @Query("DELETE FROM currency WHERE id = :id")
    suspend fun delete(id: Long)

    @Query("DELETE FROM currency")
    suspend fun deleteAll()

    @Query("SELECT * FROM currency")
    suspend fun getAll(): List<CurrencyEntity>

    @Query("SELECT count(id) FROM currency")
    suspend fun getCount(): Int

    @Query("SELECT * FROM currency WHERE codigo LIKE :code LIMIT 1")
    suspend fun getByCode(code:String): CurrencyEntity?

    @Query("SELECT * FROM currency LIMIT 1")
    suspend fun getFirst(): CurrencyEntity
}