package com.hotmail.fignunes.btg.presentation.quotedollar.actions

import com.hotmail.fignunes.btg.common.exceptions.EmptyReturnException
import com.hotmail.fignunes.btg.repository.Repository
import com.hotmail.fignunes.btg.repository.remote.quotedollar.responses.QuoteDollarResponses
import io.reactivex.Single
import retrofit2.HttpException

class GetQuoteDollar(private val repository: Repository) {

    fun execute(accessKey: String, currencies: String): Single<QuoteDollarResponses> {
        return repository.remote.quoteDollar.getQuoteDollar(accessKey, currencies)
            .map {
                when (it.code()) {
                    200 -> it?.body() ?: throw EmptyReturnException()
                    else -> throw HttpException(it)
                }
            }
    }
}