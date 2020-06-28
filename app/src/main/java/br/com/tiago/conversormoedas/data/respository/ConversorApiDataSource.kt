package br.com.tiago.conversormoedas.data.respository

import br.com.tiago.conversormoedas.data.ApiService
import br.com.tiago.conversormoedas.data.ConversionRepository
import br.com.tiago.conversormoedas.data.ConversionResult
import br.com.tiago.conversormoedas.data.response.ConversorBodyResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ConversorApiDataSource: ConversionRepository {

    override fun getRates(currency: String, conversionResultsCallback: (result: ConversionResult) -> Unit) {
        ApiService.service.getRates(currencies = currency).enqueue(object : Callback<ConversorBodyResponse> {
            override fun onResponse(
                call: Call<ConversorBodyResponse>,
                response: Response<ConversorBodyResponse>
            ) {
                when {
                    response.isSuccessful -> {
                        var rates = 0F

                        response.body()?.let { conversorBodyResponse ->
                            for (result in conversorBodyResponse.quotes){
                                rates = result.value
                            }
                        }

                        conversionResultsCallback(ConversionResult.Success(rates))
                    }
                    else -> conversionResultsCallback(ConversionResult.ApiError(response.code()))
                }
            }

            override fun onFailure(call: Call<ConversorBodyResponse>, t: Throwable) {
                conversionResultsCallback(ConversionResult.ServerError)
            }
        })
    }
}