package com.sugarspoon.desafiobtg.app

import android.app.Application
import com.sugarspoon.data.local.database.BtgDataBase
import com.sugarspoon.data.local.database.Migration
import com.sugarspoon.data.local.repositories.RepositoryLocal
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob

class App : Application() {

    lateinit var repositoryLocal: RepositoryLocal

    override fun onCreate() {
        super.onCreate()
        val applicationScope = CoroutineScope(SupervisorJob())
        Migration(this)
        val database = BtgDataBase.getDatabase(this)
        repositoryLocal = RepositoryLocal(database.currencyDao(), database.quotationDao())
    }
}