package com.btg.convertercurrency.data_local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.btg.convertercurrency.data_local.entity.SettingsDb

@Dao
interface SettingsDao {

    @Insert
    fun insertAll(vararg settingsDb: SettingsDb)

    @Query("SELECT * FROM SettingsDb ORDER BY `key`")
    suspend fun getSettings(): Array<SettingsDb>


    @Query("UPDATE SettingsDb SET value=:value WHERE `key` = :key")
    suspend fun update(value: String, key: String)

}