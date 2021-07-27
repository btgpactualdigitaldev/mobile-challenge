package com.hotmail.fignunes.btg.repository.remote.quotedollar

import com.hotmail.fignunes.btg.repository.remote.quotedollar.resources.RemoteQuoteDollarResources
import com.hotmail.fignunes.btg.repository.remote.quotedollar.responses.QuoteDollarResponses
import com.hotmail.fignunes.btg.repository.remote.quotedollar.services.QuoteDollarServices
import io.reactivex.Single
import retrofit2.Response

class RemoteQuoteDollarRepository(private val quoteDollarServices: QuoteDollarServices) : RemoteQuoteDollarResources {
    override fun getQuoteDollar(accessKey: String, currencies: String): Single<Response<QuoteDollarResponses>> =
        quoteDollarServices.getQuoteDollar(accessKey, currencies)
}