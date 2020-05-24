package com.hotmail.fignunes.btg.repository.remote.quotedollar.resources

import com.hotmail.fignunes.btg.repository.remote.quotedollar.responses.QuoteDollarResponses
import io.reactivex.Single
import retrofit2.Response

interface RemoteQuoteDollarResources {
    fun getQuoteDollar(accessKey: String, currencies: String): Single<Response<QuoteDollarResponses>>
}