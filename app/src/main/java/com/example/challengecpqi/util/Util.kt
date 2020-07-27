package com.example.challengecpqi.util

import com.example.challengecpqi.model.Error
import com.example.challengecpqi.model.response.ErrorResponse
import com.example.challengecpqi.network.config.Result
import com.example.challengecpqi.dao.config.ResultLocal
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext
import retrofit2.HttpException
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*

const val BASE_URL = "http://apilayer.net/api/"
const val ACCESS_KEY = "bed048402103ae253c356da3717dbcbc"

// Exceptions
class NoConnectivityException: IOException()

//Call of Service
suspend fun <T> callService(dispatcher: CoroutineDispatcher, apiCall: suspend () -> T): Result<T> {
    return withContext(dispatcher) {
        try {
            Result.Success(apiCall())
        } catch (throwable: Throwable) {
            when (throwable) {
                is NoConnectivityException -> Result.NetworkError
                is IOException -> Result.NetworkError
                is HttpException -> {
                    Result.GenericError(
                        ErrorResponse (
                            error = Error(
                                throwable.code(),
                                throwable.message()
                            )
                        )
                    )
                }
                else -> {
                    Result.GenericError(null)
                }
            }
        }
    }
}

//Call of Local
suspend fun <T> callLocal(dispatcher: CoroutineDispatcher, localCall: suspend () -> T): ResultLocal<T> {
    return withContext(dispatcher) {
        try {
            ResultLocal.Success(localCall())
        } catch (throwable: Throwable) {
            ResultLocal.Error(throwable.message)
        }
    }
}

fun getDate(timestamp: Long) :String {
    val calendar = Calendar.getInstance(Locale.ENGLISH)
    calendar.timeInMillis = timestamp * 1000L
    val simpleDateFormat = SimpleDateFormat("dd/MM/yyyy HH:mm", Locale.getDefault())
    return simpleDateFormat.format(calendar.time)
}