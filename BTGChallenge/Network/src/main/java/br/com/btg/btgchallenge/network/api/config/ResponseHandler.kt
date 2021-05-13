package br.com.btg.btgchallenge.network.api.config

import br.com.btg.btgchallenge.network.model.ApiResponse
import com.google.gson.Gson
import okhttp3.ResponseBody
import retrofit2.HttpException
import java.net.SocketTimeoutException
import java.lang.Exception
import java.lang.reflect.Type
import java.util.*


enum class ErrorCodes(val code: Int) {
    SocketTimeOut(-1)
}

open class ResponseHandler {
    fun <T : Any> handleSuccess(data: ApiResponse<T>): Resource<T> {
        return Resource.success(data)
    }

    fun <T : Any> handleException(e: Exception): Resource<T> {
        var apiResponse : ApiResponse<*>
        if(e is HttpException)
        {
            if(e.response()?.errorBody() != null && e.response()?.errorBody() != null) {
                val errorString = e.response()?.errorBody()?.string()
                apiResponse = Gson().fromJson(errorString, ApiResponse::class.java)
                return Resource.error(getErrorMessage(e.code()), apiResponse)
            }
        }
        return when (e) {
            is HttpException -> Resource.error(getErrorMessage(e.code()) , null)
            is SocketTimeoutException -> Resource.error(getErrorMessage( ErrorCodes.SocketTimeOut.code), null)
            else -> Resource.error(getErrorMessage(Int.MAX_VALUE), null)
        }
    }

    private fun getErrorMessage(code: Int): String {
        return when (code) {
            ErrorCodes.SocketTimeOut.code -> "Timeout"
            401 -> "Unauthorised"
            404 -> "Not found"
            else -> "Something went wrong"
        }
    }
}