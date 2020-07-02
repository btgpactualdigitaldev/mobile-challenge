package com.test.btg.repository

import com.test.core.doRemoteStorageRequest
import com.test.core.model.Lives
import com.test.core.request.createApi
import io.reactivex.disposables.Disposable

class CurrencyRemoteRepository : CurrencyRepository {

    override fun searchLive(
        successListener: (model: Lives?) -> Unit,
        failureListener: (exception: Throwable) -> Unit
    ): Disposable {
        return doRemoteStorageRequest(
            { createApi<CurrencyApi>().requestLive() },
            successListener, failureListener
        )
    }
}