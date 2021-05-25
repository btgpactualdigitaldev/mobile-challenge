package br.com.btg.test.base

import br.com.btg.test.data.Resource
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.cancellable
import kotlinx.coroutines.flow.flowOn


abstract class BaseUseCase<in P, R>(private val coroutineDispatcher: CoroutineDispatcher) {

    operator fun invoke(parameters: P): Flow<Resource<R>> {
        return execute(parameters)
            .cancellable()
            .flowOn(coroutineDispatcher)
    }

    abstract fun execute(parameters: P): Flow<Resource<R>>
}