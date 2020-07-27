package com.example.challengecpqi.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Update

@Dao
interface GenericDao<T> {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun save(value: T)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun save(values : List<T>)

    @Update
    fun update(value: T)

    @Update
    fun delete(value: T)
}