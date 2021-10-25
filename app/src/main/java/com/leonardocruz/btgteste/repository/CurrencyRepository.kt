package com.leonardocruz.btgteste.repository

import com.leonardocruz.btgteste.model.CurrencyList
import com.leonardocruz.btgteste.model.CurrencyLive
import com.leonardocruz.btgteste.network.BtgApi
import com.leonardocruz.btgteste.network.BtgClient
import com.leonardocruz.util.Constants.BASE_URL
import retrofit2.Response

class CurrencyRepository {

    suspend fun getList() : Response<CurrencyList>{
        return BtgClient.Retrofit.getInstance<BtgApi>(BASE_URL).getApiList()
    }
    suspend fun getLive() : Response<CurrencyLive>{
        return BtgClient.Retrofit.getInstance<BtgApi>(BASE_URL).getApiLive()
    }
}