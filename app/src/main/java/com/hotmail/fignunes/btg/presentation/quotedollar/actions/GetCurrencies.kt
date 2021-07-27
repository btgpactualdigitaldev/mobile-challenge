package com.hotmail.fignunes.btg.presentation.quotedollar.actions

import com.hotmail.fignunes.btg.common.exceptions.EmptyReturnException
import com.hotmail.fignunes.btg.repository.Repository
import com.hotmail.fignunes.btg.repository.remote.currencies.responses.CurrenciesListResponses
import io.reactivex.Single
import retrofit2.HttpException

class GetCurrencies(private val repository: Repository) {

    fun execute(accessKey: String): Single<CurrenciesListResponses> {
        return repository.remote.currencies.getCurrenciesList(accessKey)
            .map {
                when (it.code()) {
                    200 -> it?.body() ?: throw EmptyReturnException()
                    else -> throw HttpException(it)
                }
            }
    }
}