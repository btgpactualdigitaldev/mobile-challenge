package com.geocdias.convecurrency.data.network.response

import androidx.lifecycle.LiveData
import androidx.lifecycle.liveData
import androidx.lifecycle.map
import com.geocdias.convecurrency.util.Resource
import com.geocdias.convecurrency.util.Status
import kotlinx.coroutines.Dispatchers

fun <T, A> performFetchOperation(databaseQuery: () -> LiveData<T>,
                                 networkCall: suspend () -> Resource<A>,
                                 saveCallResult: suspend (A) -> Unit): LiveData<Resource<T>> {

    return liveData(Dispatchers.IO) {
        emit(Resource.loading())

        val source = databaseQuery.invoke().map { Resource.success(it) }
        emitSource(source)

        val responseStatus = networkCall.invoke()
        if (responseStatus.status == Status.SUCCESS) {
            saveCallResult(responseStatus.data!!)

        } else if (responseStatus.status == Status.ERROR) {
            emit(Resource.error(responseStatus.message!!))
            emitSource(source)
        }
    }
}
