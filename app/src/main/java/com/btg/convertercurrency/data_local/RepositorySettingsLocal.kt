package com.btg.convertercurrency.data_local

import com.btg.convertercurrency.data_local.database.AppDatabase
import com.btg.convertercurrency.data_local.entity.SettingsDb
import kotlinx.coroutines.coroutineScope

class RepositorySettingsLocal(db: AppDatabase) {

    private val settingsDao = db.settingsDao()

    suspend fun getSettigs(): Array<SettingsDb> {
        return coroutineScope {
            settingsDao.getSettings()
        }
    }


    suspend fun updateSettigs(value: String, key: String) {
        return coroutineScope {
            val teste = settingsDao.update(value, key)
        }
    }
}