package com.example.desafiobtg.network.response

abstract class GetResponseApi {
    class ResponseSuccess(val data: Any?) : GetResponseApi()
    class ResponseError(val message: String) : GetResponseApi()
}