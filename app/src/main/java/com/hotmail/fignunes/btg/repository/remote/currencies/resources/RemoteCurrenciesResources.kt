package com.hotmail.fignunes.btg.repository.remote.currencies.resources

import com.hotmail.fignunes.btg.repository.remote.currencies.responses.CurrenciesListResponses
import io.reactivex.Single
import retrofit2.Response

interface RemoteCurrenciesResources {
    fun getCurrenciesList(accessKey: String): Single<Response<CurrenciesListResponses>>
}