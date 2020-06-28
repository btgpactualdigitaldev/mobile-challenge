package br.com.tiago.conversormoedas.data.respository

import android.content.Context
import br.com.tiago.conversormoedas.data.ApiService
import br.com.tiago.conversormoedas.data.CoinsRepository
import br.com.tiago.conversormoedas.data.CoinsResult
import br.com.tiago.conversormoedas.data.model.Coin
import br.com.tiago.conversormoedas.data.response.CoinsBodyResponse
import br.com.tiago.conversormoedas.data.respository.database.DatabaseHelper
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CoinsApiDataSource(private val context: Context): CoinsRepository {

    override fun getCoins(coinsResultsCallback: (result: CoinsResult) -> Unit) {
        ApiService.service.getCoins().enqueue(object : Callback<CoinsBodyResponse>{
            override fun onResponse(
                call: Call<CoinsBodyResponse>,
                response: Response<CoinsBodyResponse>
            ) {
                when {
                    response.isSuccessful -> {
                        val coins : MutableList<Coin> = mutableListOf()

                        response.body()?.let { coinsBodyResponse ->
                            for (result in coinsBodyResponse.currencies){
                                val coin = Coin(0, result.key, result.value)

                                val dbManager = DatabaseHelper(context = context)
                                dbManager.insertOrReplaceCoin(coin = coin)

                                coins.add(coin)
                            }
                        }

                        coinsResultsCallback(CoinsResult.Success(coins))
                    }
                    else -> coinsResultsCallback(CoinsResult.ApiError(response.code()))
                }
            }

            override fun onFailure(call: Call<CoinsBodyResponse>, t: Throwable) {
                coinsResultsCallback(CoinsResult.ServerError)
            }
        })
    }

    override fun getCoinsDB(coinsResultsCallback: (result: CoinsResult) -> Unit) {
        val dbManager = DatabaseHelper(context = context)
        val coins = dbManager.getCoins()
        if (coins != null && coins.isNotEmpty()){
            coinsResultsCallback(CoinsResult.Success(coins))
        } else {
            coinsResultsCallback(CoinsResult.DBError)
        }
    }
}