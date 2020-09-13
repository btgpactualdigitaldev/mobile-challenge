package br.com.rcp.currencyconverter.database.dao.base

import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Update

abstract class BaseDAO<T> {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    abstract fun save(entity : T)

    @Update(onConflict = OnConflictStrategy.REPLACE)
    abstract fun update(entity : T)

    @Delete
    abstract fun remove(entity : T)
}