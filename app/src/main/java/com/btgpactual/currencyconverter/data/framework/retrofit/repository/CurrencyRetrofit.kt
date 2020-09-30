package com.btgpactual.currencyconverter.data.framework.retrofit.repository

import com.btgpactual.currencyconverter.data.framework.retrofit.response.CurrencyListResponse
import com.btgpactual.currencyconverter.data.framework.retrofit.response.QuoteListResponse
import com.btgpactual.currencyconverter.data.model.CurrencyModel
import com.btgpactual.currencyconverter.data.repository.CurrencyExternalRepository
import com.btgpactual.currencyconverter.data.framework.retrofit.CurrencyLayerAPI
import com.btgpactual.currencyconverter.data.framework.retrofit.CurrencyLayerService
import com.btgpactual.currencyconverter.data.framework.retrofit.NetworkConnectionInterceptor
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import okhttp3.OkHttpClient
import retrofit2.*
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import java.util.*

class CurrencyRetrofit : CurrencyExternalRepository {

    override suspend fun getCurrencyModelList(networkConnectionInterceptor: NetworkConnectionInterceptor, callback: (result: CurrencyExternalRepository.CurrencyModelListResult) -> Unit){

        val api = CurrencyLayerAPI(networkConnectionInterceptor).service

        val responseCurrencyList:Response<CurrencyListResponse> = api.getCurrencyList().awaitResponse()

        if(!responseCurrencyList.isSuccessful) {
            callback(CurrencyExternalRepository.CurrencyModelListResult.RequestError(responseCurrencyList.code()))
            return
        }

        val responseQuoteList:Response<QuoteListResponse> = api.getQuoteList().awaitResponse()

        if(!responseQuoteList.isSuccessful) {
            callback(CurrencyExternalRepository.CurrencyModelListResult.RequestError(responseQuoteList.code()))
            return
        }

        val currencyMap: Map<String,String>? = responseCurrencyList.body()?.currencies
        val quoteMap: Map<String,Double>? = responseQuoteList.body()?.quotes

        val currencyModelList = currencyMap?.map { it: Map.Entry<String, String> ->
            val valor  = quoteMap?.get("USD${it.key}")
            CurrencyModel(it.key,it.value,valor,Calendar.getInstance().timeInMillis)
        }

        if(currencyModelList==null){
            callback(CurrencyExternalRepository.CurrencyModelListResult.UnhandledError)
            return
        }

        callback(CurrencyExternalRepository.CurrencyModelListResult.RequestSuccess(currencyModelList))
    }

}