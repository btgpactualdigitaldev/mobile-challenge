package com.geocdias.convecurrency.data.network

import com.geocdias.convecurrency.util.CurrencyErrorHandler
import com.geocdias.convecurrency.util.Resource
import retrofit2.Response
import java.net.UnknownHostException

abstract class BaseDataSource {

    protected suspend fun <T> getResult(call: suspend () -> Response<T>): Resource<T> {
        try {
            val response = call()
            if (response.isSuccessful) {
                val body = response.body()
                if (body != null) return Resource.success(body)
            }
            return error(CurrencyErrorHandler.handleError(response.code()))
        }catch (e: UnknownHostException) {
            return error(CurrencyErrorHandler.unknowHostError())
        }
        catch (e: Exception) {
            println(e)
            return error(e.message ?: e.toString())
        }
    }

    private fun <T> error(message: String): Resource<T> {
        return Resource.error("A chamada de rede falhou pelo seguinte motivo: $message")
    }

}
