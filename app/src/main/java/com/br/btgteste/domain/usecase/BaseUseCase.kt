package com.br.btgteste.domain.usecase

import com.br.btgteste.domain.model.ApiResult
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.async
import kotlinx.coroutines.cancelChildren
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlin.coroutines.CoroutineContext

internal typealias ResponseBlock<Response> = (ApiResult<Response>)->Unit

@Suppress("UNCHECKED_CAST")
abstract class BaseUseCase <in Params, Response> where Response : Any, Params : Any {

    private var parentJob: Job = Job()
    private var backgroundContext = Dispatchers.IO
    private var foregroundContext = Dispatchers.Main

    abstract suspend fun executeAsyncTasks(request: Params): ApiResult<Response>
    protected suspend fun <UNKNOWN> runAsync(block: suspend () -> UNKNOWN): Deferred<UNKNOWN> =
        CoroutineScope(backgroundContext).async { block() }

    operator fun invoke (params: Params = Any() as Params, onResult: (ApiResult<Response>) -> Unit) {

        val exceptionHandler = CoroutineExceptionHandler {
                _: CoroutineContext, throwable: Throwable ->
            onResult(ApiResult.Error(throwable))
        }
        unsubscribe()
        parentJob = Job()
        CoroutineScope(foregroundContext + parentJob + exceptionHandler).launch {
            val result = withContext(backgroundContext) {
                executeAsyncTasks(params)
            }
            onResult(result)
        }
    }

    fun unsubscribe() {
        parentJob.apply {
            cancelChildren()
            cancel()
        }
    }
}