package com.example.desafiobtg.repositories

import com.example.desafiobtg.base.BaseRepository
import com.example.desafiobtg.network.response.GetResponseApi
import com.example.desafiobtg.network.response.ResponseTreatment
import org.koin.core.KoinComponent
import org.koin.core.get

class ConvertRepository(var responseTreatment: ResponseTreatment) : BaseRepository, KoinComponent {

    init {
        responseTreatment = get<ResponseTreatment>()
    }

    override suspend fun getListOfCurrencies(): GetResponseApi {
        return responseTreatment.getListOfCurrency()
    }

    override suspend fun getLivePrice(): GetResponseApi {
        return responseTreatment.getLivePrice()
    }
}