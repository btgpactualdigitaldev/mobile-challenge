package com.gui.antonio.testebtg.datasource

import androidx.databinding.ObservableInt
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.JsonObject
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes
import com.gui.antonio.testebtg.model.IAccessDatabase
import com.gui.antonio.testebtg.retrofit.RetrofitClient
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import javax.inject.Inject

class AccessDataSource @Inject constructor(val db: IAccessDatabase) : IAccessDataSource {

    override fun getListCurrency(): LiveData<List<Currencies>> {
        val data = MutableLiveData<List<Currencies>>()
        RetrofitClient.client.getListCurrency().enqueue(object : Callback<JsonObject> {
            override fun onFailure(call: Call<JsonObject>, t: Throwable) {}
            override fun onResponse(call: Call<JsonObject>, response: Response<JsonObject>) {
                response.let { result ->
                    if (result.isSuccessful) {
                        val currenciesData = ArrayList<Currencies>()
                        val currencies = response.body()?.getAsJsonObject("currencies")
                        currencies.let {
                            val iterator = it!!.keySet().iterator()
                            while (iterator.hasNext()) {
                                val key = iterator.next()
                                val value = currencies?.get(key)!!.asString
                                currenciesData.add(Currencies(symbol = key, name = value))
                            }
                        }
                        CoroutineScope(Dispatchers.IO).launch {
                            db.deleteCurrencies()
                            db.insertCurrencies(currenciesData)
                            data.postValue(db.getCurrencies())
                        }
                    } else {
                        // TODO: tratar erro
                    }
                }
            }
        })
        return data
    }

    override fun getListCurrencyOffline(): LiveData<List<Currencies>> {
        val data = MutableLiveData<List<Currencies>>()
        CoroutineScope(Dispatchers.IO).launch {
            data.postValue(db.getCurrencies())
        }
        return data
    }

    override fun getQuote(symbol: String): LiveData<Quotes> {
        val data = MutableLiveData<Quotes>()
        RetrofitClient.client.getQuote(symbol).enqueue(object : Callback<JsonObject> {
            override fun onFailure(call: Call<JsonObject>, t: Throwable) {}
            override fun onResponse(call: Call<JsonObject>, response: Response<JsonObject>) {
                response.let {
                    if (it.isSuccessful) {
                        it.body()?.getAsJsonObject("quotes").let {
                            val iterator = it!!.keySet().iterator()
                            var quote: Quotes? = null
                            while (iterator.hasNext()) {
                                val key = iterator.next()
                                val value = it?.get(key)!!.asDouble
                                quote = Quotes(symbol = key, value = value)
                            }
                            quote.let { data.value = it }
                        }

                    } else {
                        //todo: tratar erro
                    }
                }
            }
        })
        return data
    }

    override fun deleteAndInsertQuotes(symbol: List<String>) {
        RetrofitClient.client.getQuotes(symbol).enqueue(object : Callback<JsonObject> {
            override fun onFailure(call: Call<JsonObject>, t: Throwable) {}
            override fun onResponse(call: Call<JsonObject>, response: Response<JsonObject>) {
                response.let {
                    if (it.isSuccessful) {
                        val q = it.body()?.getAsJsonObject("quotes")
                        val iterator = q!!.keySet().iterator()
                        val quotes = ArrayList<Quotes>()
                        while (iterator.hasNext()) {
                            val key = iterator.next()
                            val value = q.get(key)!!.asDouble
                            quotes.add(Quotes(symbol = key.replace("USD", ""), value = value))
                        }
                        quotes.let {
                            CoroutineScope(Dispatchers.IO).launch {
                                db.deleteQuotes()
                                db.insertQuotes(quotes)
                            }
                        }
                    } else {
                        //todo: tratar erro
                    }
                }
            }
        })
    }

    override fun getQuoteOffline(symbol: String): LiveData<Quotes> {
        val data = MutableLiveData<Quotes>()
        CoroutineScope(Dispatchers.IO).launch {
            data.postValue(db.getQuote(symbol))
        }
        return data
    }

}