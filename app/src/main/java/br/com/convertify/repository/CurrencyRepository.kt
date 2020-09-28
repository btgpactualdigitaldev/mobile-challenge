package br.com.convertify.repository

import androidx.lifecycle.MutableLiveData
import br.com.convertify.api.*
import br.com.convertify.api.calls.CurrencyApiInterface
import br.com.convertify.api.responses.CurrencyApiResponse
import br.com.convertify.models.CurrencyItem
import br.com.convertify.util.CurrencyUtils
import retrofit2.Call
import retrofit2.Response
import java.lang.Exception
import javax.security.auth.callback.Callback

class CurrencyRepository {
    public fun fetchAvailableCurrencies(): MutableLiveData< DataState<Array<CurrencyItem>> > {
        val currencyLiveDataState: MutableLiveData<DataState<Array<CurrencyItem>>> = MutableLiveData()

        val currencyApi = ApiClient.getRetrofitClient().create(CurrencyApiInterface::class.java)
        val resource = DataState<Array<CurrencyItem>>()

        currencyApi.getAvailableCurrencies(Constants.API_KEY).enqueue(object : Callback,
            retrofit2.Callback<CurrencyApiResponse> {
            override fun onResponse(
                call: Call<CurrencyApiResponse>,
                response: Response<CurrencyApiResponse>
            ) {
                try {
                    val currencyListMap = response.body()?.currencies!!
                    val currencyList = CurrencyUtils.currencyMapToCurrencyList(currencyListMap)
                    resource.data = currencyList

                }catch (e: Exception){
                    resource.isError = true
                    resource.errorMessage = e.message
                }
                currencyLiveDataState.value = resource
            }

            override fun onFailure(call: Call<CurrencyApiResponse>, t: Throwable) {
                resource.isError = true
                resource.errorMessage = t.message
                currencyLiveDataState.value = resource

            }

        })

        return currencyLiveDataState
    }
}