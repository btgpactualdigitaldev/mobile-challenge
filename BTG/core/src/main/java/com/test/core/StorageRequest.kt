package com.test.core

import com.test.core.extension.alternateThreadAndBackToMain
import io.reactivex.Observable
import io.reactivex.disposables.Disposable
import retrofit2.Response

fun <T> doRemoteStorageRequest(
    callStorageRequest: () -> Observable<Response<T>>,
    successListener: (model: T?) -> Unit,
    failureListener: (exception: Throwable) -> Unit
): Disposable {

    return callStorageRequest()
        .alternateThreadAndBackToMain()
        .subscribe({
            if (it.isSuccessful) {
                successListener(it.body())
            } else {
                failureListener(ResponseCodeException(it.code()))
            }

        }) {
            failureListener(it)
        }
}

