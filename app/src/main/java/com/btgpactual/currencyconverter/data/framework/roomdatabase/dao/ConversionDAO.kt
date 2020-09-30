package com.btgpactual.currencyconverter.data.framework.roomdatabase.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.ConversionEntity

@Dao
interface ConversionDAO {

    @Insert
    suspend fun insert(conversion: ConversionEntity): Long

    @Update
    suspend fun update(conversion: ConversionEntity)

    @Query("DELETE FROM conversion WHERE id = :id")
    suspend fun delete(id: Long)

    @Query("DELETE FROM conversion")
    suspend fun deleteAll()

    @Query("SELECT * FROM conversion ORDER BY dataHora DESC")
    suspend fun getAll(): List<ConversionEntity>
}