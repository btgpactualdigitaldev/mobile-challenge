package com.example.desafiobtg.network.response

import com.example.desafiobtg.base.BaseResponse
import com.example.desafiobtg.network.api.BtgApiService

class ResponseCall: BaseResponse() {

    suspend fun responseCallList(): GetResponseApi {
        val response = returnListOfCurrency()
        return responseBase(response)
    }

    suspend fun responseCallPrice(): GetResponseApi {
        val response = returnLivePrice()
        return responseBase(response)
    }

    private suspend fun returnListOfCurrency() = BtgApiService.btgApi.getListOfCurrency()
    private suspend fun returnLivePrice() = BtgApiService.btgApi.getlivePrice()
}