package com.example.challengesavio.viewmodels

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.challengesavio.MyApplication
import com.example.challengesavio.R
import com.example.challengesavio.api.models.CurrenciesOutputs
import com.example.challengesavio.api.models.QuotesOutputs
import com.example.challengesavio.api.repositories.MainRepository
import com.example.challengesavio.data.entity.Currency
import com.example.challengesavio.data.entity.Quote
import com.example.challengesavio.utilities.CurrenciesListener
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrenciesViewModel constructor(private val repository: MainRepository)  : ViewModel() {

    val currenciesList = MutableLiveData<Map<String,String>>()
    val quotesList = MutableLiveData<HashMap<String,Double>>()
    var listener: CurrenciesListener?= null
    var context: Context?= null

    private fun getAllCurrencies(){

        val request = repository.getAllCurrencies()
        request.enqueue(object : Callback<CurrenciesOutputs?> {
            override fun onResponse(
                call: Call<CurrenciesOutputs?>,
                response: Response<CurrenciesOutputs?>
            ) {
                if (response.body() != null) {
                    if (response.body()?.currencies.isNullOrEmpty()) {
                        listener?.onCurrenciesError(context?.getString(R.string.load_error)!!)
                    } else {
                        currenciesList.value = response.body()?.currencies
                        currenciesList.value!!.forEach { (key, value) ->
                            val currency = Currency(null,key, value)
                            MyApplication.database?.currencyDao()?.insertCurrencies(currency)
                        }
                    }
                } else {
                    listener?.onCurrenciesError(context?.getString(R.string.load_error)!!)
                }
            }

            override fun onFailure(call: Call<CurrenciesOutputs?>, t: Throwable) {
                listener?.onCurrenciesError(context?.getString(R.string.load_error)!!)
            }
        })

    }

    private fun getAllQuotes() {

        val request = repository.getAllQuotes()
        request.enqueue(object : Callback<QuotesOutputs?> {
            override fun onResponse(
                call: Call<QuotesOutputs?>,
                response: Response<QuotesOutputs?>
            ) {
                if (response.body() != null) {
                    quotesList.value = response.body()?.quotes

                    quotesList.value!!.forEach { (key, value) ->
                        val quotes = Quote(null,key, value)
                        MyApplication.database?.currencyQuoteDao()?.insertQuotes(quotes)
                    }
                } else {
                    listener?.onQuotesError(context?.getString(R.string.load_error_quote)!!)
                }
            }
            override fun onFailure(call: Call<QuotesOutputs?>, t: Throwable) {
                listener?.onQuotesError(context?.getString(R.string.load_error_quote)!!)
            }
        })

    }

    fun init(listener: CurrenciesListener, context: Context) {
        this.context=context
        this.listener=listener

        if (repository.getCurrenciesLocal().isNullOrEmpty()) {
            getAllCurrencies()
        }else{
            val localList = repository.getCurrenciesLocal()
            val localListMap : Map<String,String> = localList.associateBy({ it.acronym!! }, { it.name!! })
            currenciesList.value= localListMap

            listener.onCurrenciesError(context.getString(R.string.error_offline))
        }

        if (repository.getQuotesLocal().isNullOrEmpty()) {
            getAllQuotes()
        }else{
            val localList = repository.getQuotesLocal()
            val localListMap : Map<String,Double> = localList.associateBy({ it.acronym!! }, { it.value!! })
            quotesList.value= localListMap as HashMap<String, Double>

            listener.onCurrenciesError(context.getString(R.string.error_offline))
        }

    }
}