package com.example.btgconvert.presentation.convert

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.btgconvert.data.ApiService
import com.example.btgconvert.data.db.DataBaseHandler
import com.example.btgconvert.data.model.Currency
import com.example.btgconvert.data.response.CurrencyListResponse
import com.example.btgconvert.data.response.QuotesResponce
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ConvertViewModel : ViewModel() {
    val currencyListLiveData : MutableLiveData<List<Currency>> = MutableLiveData()
    val quoteLiveData : MutableLiveData<QuotesResponce> = MutableLiveData()
    val dbLiveData : MutableLiveData<Boolean> = MutableLiveData()
    val convertLiveData : MutableLiveData<Pair<String, String>> = MutableLiveData()
    val flipperLiveData : MutableLiveData<Int> = MutableLiveData()
    val offlineLiveData : MutableLiveData<Boolean> = MutableLiveData()

    fun startApp(context: Context){
        if(isNetworkAvailable(context)){
            getQuotes()
            offlineLiveData.value = false
        }else{
            offlineLiveData.value = true
            val db = DataBaseHandler(context)
            if(db.getData().count() <= 0){
                flipperLiveData.value = ERROR
            }else{
                flipperLiveData.value = CONVERT
            }
        }
    }

    fun getCurrency(quotes: QuotesResponce){
        ApiService.services.getCurrencies().enqueue(object: Callback<CurrencyListResponse> {
            override fun onResponse(call: Call<CurrencyListResponse>, response: Response<CurrencyListResponse>) {
                if(response.isSuccessful){
                    val currencys: MutableList<Currency> = mutableListOf()

                    response.body().let { it ->
                        if (it != null) {
                            it.currencies?.let {currencies ->
                                for(results in currencies) {
                                    val currency = Currency(
                                            currencyKey = results.key,
                                            currencyTitle = results.value,
                                            currencyQuote = quotes.quotes.getValue("USD"+results.key)
                                    )

                                    currencys.add(currency)
                                    flipperLiveData.value = CONVERT
                                }

                            }
                        }
                    }
                    currencyListLiveData.value = currencys
                }else{
                    flipperLiveData.value = ERROR
                }
            }

            override fun onFailure(call: Call<CurrencyListResponse>, t: Throwable) {
                flipperLiveData.value = ERROR
            }

        })
    }

    fun getQuotes(){
        ApiService.services.getQuotes().enqueue(object: Callback<QuotesResponce> {
            override fun onResponse(call: Call<QuotesResponce>, response: Response<QuotesResponce>) {
                if(response.isSuccessful){
                    response.body().let { it ->
                        quoteLiveData.value = it
                    }
                }
            }

            override fun onFailure(call: Call<QuotesResponce>, t: Throwable) {
                flipperLiveData.value = ERROR
            }
        })
    }

    fun saveData(currencies:List<Currency>, context: Context){
        val db = DataBaseHandler(context)
        db.deleteData()
        if (db.insertData(currencies)){
            dbLiveData.value = true
        }
    }

    fun convert(context: Context, textTo:String, textFrom:String, value: Double){
        val db = DataBaseHandler(context)
        val from = db.getCurrency(textFrom)
        val to = db.getCurrency(textTo)

        convertLiveData.value = Pair(String.format("%.2f",value/from.currencyQuote*to.currencyQuote)+" "+to.currencyKey,"1 "+from.currencyKey+" = "+String.format("%.2f",1/from.currencyQuote*to.currencyQuote)+" "+to.currencyKey)
    }

    fun isNetworkAvailable(context: Context): Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        // For 29 api or above
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val capabilities = connectivityManager.getNetworkCapabilities(connectivityManager.activeNetwork) ?: return false
            return when {
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) ->    true
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) ->   true
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) ->   true
                else ->     false
            }
        }
        // For below 29 api
        else {
            if (connectivityManager.activeNetworkInfo != null && connectivityManager.activeNetworkInfo!!.isConnectedOrConnecting) {
                return true
            }
        }
        return false
    }

    companion object{
        private const val CONVERT = 1
        private const val ERROR = 2
    }

}