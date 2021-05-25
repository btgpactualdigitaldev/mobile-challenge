package com.vald3nir.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.vald3nir.data.database.model.Flag

@Dao
interface FlagDao {

    @Query("DELETE FROM flag")
    fun deleteAll()

    @Query("SELECT * FROM flag")
    fun getAll(): List<Flag>?

    @Query("SELECT * FROM flag WHERE code IN (:code)")
    fun loadById(code: String?): Flag?

    @Insert
    fun insertAll(flags: List<Flag>)
}