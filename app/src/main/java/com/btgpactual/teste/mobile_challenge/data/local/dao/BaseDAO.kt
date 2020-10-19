package com.btgpactual.teste.mobile_challenge.data.local.dao

import androidx.room.*

interface BaseDAO<T> {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(data: T): Long?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(data: List<T>): List<Long>?

    @Update
    suspend fun update(data: T): Int?

    @Delete
    suspend fun delete(data: T)
}