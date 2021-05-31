package com.example.desafiobtg.network.response

import com.example.desafiobtg.model.listofcurrencymodel.CurrencyListModel
import com.example.desafiobtg.model.liveprice.LivePriceModel
import org.koin.core.KoinComponent
import org.koin.core.get

class ResponseTreatment(private var responseCall: ResponseCall): KoinComponent {

    init {
        responseCall = get<ResponseCall>()
    }

    suspend fun getListOfCurrency(): GetResponseApi {
        val response = responseCall.responseCallList()

        return if (response is GetResponseApi.ResponseSuccess) {
            val list = response.data as CurrencyListModel?

            GetResponseApi.ResponseSuccess(list)
        } else {
            response
        }
    }

    suspend fun getLivePrice(): GetResponseApi {
        val response = responseCall.responseCallPrice()

        return if (response is GetResponseApi.ResponseSuccess) {
            val prices = response.data as LivePriceModel?

            GetResponseApi.ResponseSuccess(prices)
        } else {
            response
        }

    }
}