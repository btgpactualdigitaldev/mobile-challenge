package com.desafio.btgpactual.repositories

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.desafio.btgpactual.baseasync.BaseAsyncTask
import com.desafio.btgpactual.database.dao.CurrencyDao
import com.desafio.btgpactual.http.RetrofitConfig
import com.desafio.btgpactual.http.responses.CurrencyResponse
import com.desafio.btgpactual.http.service.ApiService
import com.desafio.btgpactual.shared.models.CurrencyModel
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrencyRepository(
    private val currencyDao: CurrencyDao,
    private val service: ApiService = RetrofitConfig().apiService()
) {

    fun callCurrencies(
        sucess: (List<CurrencyModel>) -> Unit,
        error: (erro: String?) -> Unit
    ) {
        val call = service.list()
        call.enqueue(object : Callback<CurrencyResponse> {
            override fun onResponse(
                call: Call<CurrencyResponse?>,
                response: Response<CurrencyResponse>?
            ) {
                val list = response
                    ?.body()
                    ?.currencies?.map { CurrencyModel(it.key, it.value) }

                list?.let {
                    sucess(it)
                    insertCurrencyDatabase(it)
                }
            }

            override fun onFailure(
                call: Call<CurrencyResponse>?,
                t: Throwable?
            ) {
                Log.d("CurrencyRepository", t.toString())
                getAllCurrencies {
                    sucess(it)
                }
            }
        })

    }

    private fun insertCurrencyDatabase(currencies: List<CurrencyModel>) {
        BaseAsyncTask(
            executeTask = {
                currencyDao.insertCurrencies(currencies)
            }, finishTask = {
                Log.d("CurrencyRepository", "Finish Insert Currency DB")
            }
        ).execute()
    }

    private fun getAllCurrencies(sucess: (List<CurrencyModel>) -> Unit) {
        BaseAsyncTask(
            executeTask = {
                currencyDao.getAllCurrencies()
            }, finishTask = sucess
        ).execute()
    }


}