package clcmo.com.btgcurrency.util

import android.content.Context
import clcmo.com.btgcurrency.repository.data.local.AppDB
import clcmo.com.btgcurrency.repository.data.remote.retrofit.RFConfig
import clcmo.com.btgcurrency.repository.data.source.LocalDS
import clcmo.com.btgcurrency.repository.data.source.RemoteDS
import clcmo.com.btgcurrency.repository.domain.repository.CRepository
import clcmo.com.btgcurrency.repository.domain.uc.CUserCase

object AppInject {

    private var userCase: CUserCase? = null

    fun getUserCase(context: Context): CUserCase = userCase ?:let{
        val local = LocalDS(AppDB.createDB(context))
        val remote = RemoteDS(RFConfig().getRFConfig(context))
        val repo = CRepository(local, remote)
        CUserCase(repo).also{ userCase = it }
    }
}