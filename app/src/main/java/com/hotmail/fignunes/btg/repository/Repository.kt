package com.hotmail.fignunes.btg.repository

import android.content.Context
import com.autopass.rechargeapp.repository.local.LocalRepository
import com.autopass.rechargeapp.repository.local.attendant.LocalFactory
import com.hotmail.fignunes.btg.repository.remote.RemoteFactory
import com.hotmail.fignunes.btg.repository.remote.RemoteRepository

class Repository(applicationContext: Context) : RepositoryFactory {

    override val remote: RemoteFactory = RemoteRepository()
    override val local: LocalFactory = LocalRepository(applicationContext)
}