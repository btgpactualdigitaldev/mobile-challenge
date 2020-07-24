package com.desafio.btgpactual.repositories

import android.util.Log
import com.desafio.btgpactual.baseasync.BaseAsyncTask
import com.desafio.btgpactual.database.dao.QuoteDao
import com.desafio.btgpactual.http.RetrofitConfig
import com.desafio.btgpactual.http.responses.QuotesResponse
import com.desafio.btgpactual.http.service.ApiService
import com.desafio.btgpactual.shared.models.QuotesModel
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class QuoteRepository(
    private val quoteDao: QuoteDao,
    private val service: ApiService = RetrofitConfig().apiService()
) {
    fun callQuotes(
        sucess: (List<QuotesModel>) -> Unit,
        error: (erro: String?) -> Unit
    ) {
        val call = service.live()
        call.enqueue(object : Callback<QuotesResponse> {
            override fun onResponse(
                call: Call<QuotesResponse?>,
                response: Response<QuotesResponse>?
            ) {
                val list = response
                    ?.body()
                    ?.quotes
                    ?.map {
                        QuotesModel(it.key, it.value)
                    }

                list?.let {
                    sucess(it)
                    insertQuotesDatabase(it)
                }
            }

            override fun onFailure(
                call: Call<QuotesResponse>?,
                t: Throwable?
            ) {
                Log.d("QuoteRepository", t.toString())
                getAllQuotes {
                    sucess(it)
                }
            }
        })

    }

    private fun insertQuotesDatabase(quotes: List<QuotesModel>) {
        BaseAsyncTask(
            executeTask = {
                quoteDao.insertQuotes(quotes)
            }, finishTask = {
                Log.d("QuoteRepository", "Finish Insert Quote DB")
            }
        ).execute()
    }

    private fun getAllQuotes(sucess: (List<QuotesModel>) -> Unit) {
        BaseAsyncTask(
            executeTask = {
                quoteDao.getAllQuotes()
            }, finishTask = sucess
        ).execute()
    }

    fun toDolar() {

    }



}