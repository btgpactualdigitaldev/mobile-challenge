package com.svm.btgmoneyconverter.viewmodel

import androidx.lifecycle.MutableLiveData
import com.svm.btgmoneyconverter.R
import com.svm.btgmoneyconverter.data.webservice.RetrofitInitializer
import com.svm.btgmoneyconverter.data.webservice.result.CurrencyResult
import com.svm.btgmoneyconverter.data.webservice.result.QuoteResult
import com.svm.btgmoneyconverter.model.Currency
import com.svm.btgmoneyconverter.model.Quote
import com.svm.btgmoneyconverter.utils.CommonFunctions.showMessageShort
import com.svm.btgmoneyconverter.utils.DBAccess
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ListVM: BaseVM() {

    var listCurrency: MutableLiveData< ArrayList<Currency> > = MutableLiveData()
    var currencySelected: MutableLiveData< String > = MutableLiveData()
    var isUpdating = false

    fun getCurrencyList(){
        loading.postValue(true)

        /*
        Procura no banco de dados se existe currencies salvas,
        se não houver ele carrega os dados offline até o usuario atualizar
        */
        val cList = cDb.getAll()
        if(cList.isEmpty())
            getCurrenciesAPI()
        else{
            listCurrency.postValue(cList)
            loading.postValue(false)
        }

    }

    fun getQuoteList(){
        val qList = qDb.getAll()
        if(qList.isEmpty()) getQuotesAPI()
    }

    fun getCurrenciesAPI(){
        if(isUpdating) loading.postValue(true)
        val call = RetrofitInitializer().getAPI().getCurrency()

        call.enqueue(object : Callback<CurrencyResult> {
            override fun onResponse(call: Call<CurrencyResult>, response: Response<CurrencyResult>) {

                val currencies = response.body()
                currencies?.let{
                    val values: Collection<String> = it.currencies!!.values
                    val keys: Collection<String> = it.currencies!!.keys

                    val listOfValues: ArrayList<String> = ArrayList(values)
                    val listOfKeys: ArrayList<String> = ArrayList(keys)

                    val listOfCurrencies: ArrayList<Currency> = ArrayList()

                    cDb.deleteAll()

                    for (i in 0 until listOfKeys.size) {
                        val currency = Currency(listOfKeys[i],listOfValues[i])
                        listOfCurrencies.add(currency)
                    }
                    listOfCurrencies.sortBy { it.symbol }
                    cDb.insertAll(listOfCurrencies)

                    listCurrency.postValue(listOfCurrencies)
                }

                if(isUpdating){
                    showMessageShort(context, context.getString(R.string.update_api))
                    isUpdating = false
                }

                loading.postValue(false)
            }

            override fun onFailure(call: Call<CurrencyResult>, t: Throwable) {
                val cList = getCurrenciesDB()
                listCurrency.postValue(cList)
                if(cList.isNotEmpty())
                    showMessageShort(context, context.getString(R.string.error_api_load_offline))
                else
                    showMessageShort(context, context.getString(R.string.error_api))

                loading.postValue(false)
            }

        })
    }

    fun getCurrenciesDB(): ArrayList<Currency> = cDb.getAll()

    private fun getQuotesAPI(){
        val call = RetrofitInitializer().getAPI().getLive()
        call.enqueue(object : Callback<QuoteResult> {
            override fun onResponse(call: Call<QuoteResult>, response: Response<QuoteResult>) {

                val quotes = response.body()
                quotes?.let{
                    val values: Collection<Double> = it.quotes!!.values
                    val keys: Collection<String> = it.quotes!!.keys

                    val listOfValues: ArrayList<Double> = ArrayList(values)
                    val listOfKeys: ArrayList<String> = ArrayList(keys)

                    val listOfQuotes: ArrayList<Quote> = ArrayList()

                    qDb.deleteAll()

                    for (i in 0 until listOfKeys.size) {
                        val quote = Quote(listOfKeys[i],listOfValues[i])
                        listOfQuotes.add(quote)
                    }
                    listOfQuotes.sortBy { it.symbol }
                    qDb.insertAll(listOfQuotes)
                }

            }

            override fun onFailure(call: Call<QuoteResult>, t: Throwable) {}

        })
    }

    fun onSelectCurrency(currencySymbol: String){
        currencySelected.postValue(currencySymbol)
    }

}
