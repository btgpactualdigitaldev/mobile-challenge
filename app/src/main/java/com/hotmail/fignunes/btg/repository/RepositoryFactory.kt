package com.hotmail.fignunes.btg.repository

import com.autopass.rechargeapp.repository.local.attendant.LocalFactory
import com.hotmail.fignunes.btg.repository.remote.RemoteFactory

interface RepositoryFactory {
    val remote: RemoteFactory
    val local: LocalFactory
}