package com.example.desafiobtg.base

import com.example.desafiobtg.network.response.GetResponseApi
import retrofit2.Response

open class BaseResponse {

    fun <T> responseBase(myFunction: Response<T>): GetResponseApi {

        return try {
            if (myFunction.isSuccessful) {
                GetResponseApi.ResponseSuccess(myFunction.body())
            } else {
                if (myFunction.code() == 404) {
                    GetResponseApi.ResponseError("Dado não Encontrado")
                } else {
                    GetResponseApi.ResponseError("Erro ao carregar os Dados")
                }
            }
        } catch (exception: Exception) {
            GetResponseApi.ResponseError("Erro ao carergar os dados")
        }
    }
}