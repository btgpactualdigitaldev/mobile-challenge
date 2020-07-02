package com.test.btg.repository

import com.test.core.model.Lives
import io.reactivex.disposables.Disposable

interface CurrencyRepository {
    fun searchLive(
        successListener: (model: Lives?) -> Unit,
        failureListener: (exception: Throwable) -> Unit
    ): Disposable
}