package com.hotmail.fignunes.btg.repository.remote.currencies

import com.hotmail.fignunes.btg.repository.remote.currencies.resources.RemoteCurrenciesResources
import com.hotmail.fignunes.btg.repository.remote.currencies.responses.CurrenciesListResponses
import com.hotmail.fignunes.btg.repository.remote.currencies.services.CurrenciesServices
import io.reactivex.Single
import retrofit2.Response

class RemoteCurrenciesRepository(private val currenciesServices: CurrenciesServices) : RemoteCurrenciesResources {
    override fun getCurrenciesList(accessKey: String): Single<Response<CurrenciesListResponses>> =
        currenciesServices.getCurrenciesList(accessKey)
}