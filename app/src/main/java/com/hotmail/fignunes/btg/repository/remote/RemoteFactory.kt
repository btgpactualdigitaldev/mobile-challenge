package com.hotmail.fignunes.btg.repository.remote

import com.hotmail.fignunes.btg.repository.remote.currencies.resources.RemoteCurrenciesResources
import com.hotmail.fignunes.btg.repository.remote.quotedollar.resources.RemoteQuoteDollarResources

interface RemoteFactory {
    val quoteDollar: RemoteQuoteDollarResources
    val currencies : RemoteCurrenciesResources
}