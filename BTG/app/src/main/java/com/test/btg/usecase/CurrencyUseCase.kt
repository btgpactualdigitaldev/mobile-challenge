package com.test.btg.usecase

import com.test.btg.repository.CurrencyRepository
import com.test.core.model.Lives
import io.reactivex.disposables.Disposable

class CurrencyUseCase(private val repository: CurrencyRepository) {

    fun requestLive(
        successListener: (model: Lives?) -> Unit,
        failureListener: (exception: Throwable) -> Unit
    ): Disposable {
        return repository.searchLive(successListener, failureListener)
    }
}