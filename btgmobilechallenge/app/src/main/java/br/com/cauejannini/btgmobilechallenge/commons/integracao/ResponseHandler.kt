package br.com.cauejannini.btgmobilechallenge.commons.integracao

import br.com.cauejannini.btgmobilechallenge.commons.integracao.domains.ApiError
import br.com.cauejannini.btgmobilechallenge.commons.integracao.domains.ApiResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

abstract class ResponseHandler<T> : Callback<T> {

    val erroGenerico = "Ocorreu algum erro"

    override fun onFailure(call: Call<T>, t: Throwable) {
        val message = t.message
        if (message != null) {
            onFailure(message)
        } else {
            onFailure(erroGenerico)
        }
    }

    override fun onResponse(call: Call<T>, response: Response<T>) {
        val body = response.body()

        if (body != null) {
            (body as? ApiResponse)?.let { apiResponse ->
                if (apiResponse.success) {
                    onSuccess(body)
                    return
                } else {
                    (apiResponse.error)?.let{
                        tratarErroApi(it)
                        return
                    }
                }
            }
        }
        onFailure(erroGenerico)
    }

    fun tratarErroApi(apiError: ApiError) {
        onFailure(apiError.info!!)
    }

    abstract fun onFailure(messageToUser: String)

    abstract fun onSuccess(response: T)

}