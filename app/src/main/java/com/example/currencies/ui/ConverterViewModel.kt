package com.example.currencies.ui

import android.app.AlertDialog
import android.app.Application
import android.content.Context
import android.widget.Toast
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.currencies.R
import com.example.currencies.listener.APIListener
import com.example.currencies.model.remote.CurrenciesModelRemote
import com.example.currencies.model.remote.RatesModelRemote
import com.example.currencies.model.room.CurrenciesModelLocal
import com.example.currencies.model.room.RatesModelLocal
import com.example.currencies.repository.local.CurrenciesLocalRepository
import com.example.currencies.repository.local.RatesLocalRepository
import com.example.currencies.repository.remote.CurrenciesRemoteRepository
import com.example.currencies.repository.remote.RatesRemoteRepository
import com.example.currencies.service.CheckConnection

class ConverterViewModel (application: Application) : AndroidViewModel(application) {

    private val mCurrenciesRemoteRepository = CurrenciesRemoteRepository(application)
    private val mCurrenciesLocalRepository = CurrenciesLocalRepository(application)
    private val mRatesRemoteRepository = RatesRemoteRepository(application)
    private val mRatesLocalRepository = RatesLocalRepository(application)

    private val mConnection = MutableLiveData<Boolean>()
    var connection: LiveData<Boolean> = mConnection

    private val mLoadCurrenciesRemote = MutableLiveData<Boolean>()
    var loadCurrenciesRemote: LiveData<Boolean> = mLoadCurrenciesRemote

    private val mLoadCurrenciesLocal = MutableLiveData<List<CurrenciesModelLocal>>()
    var loadCurrenciesLocal: LiveData<List<CurrenciesModelLocal>> = mLoadCurrenciesLocal

    private val mLoadRatesLocal = MutableLiveData<Boolean>()
    var loadRatesLocal: LiveData<Boolean> = mLoadRatesLocal

    private val mOnFailureMessage = MutableLiveData<String>()
    val onFailureMessage : LiveData<String> = mOnFailureMessage

    private val mCurrencyOrigin = MutableLiveData<String>()
    var currencyOrigin: LiveData<String> = mCurrencyOrigin

    private val mCurrencyFinal = MutableLiveData<String>()
    var currencyFinal: LiveData<String> = mCurrencyFinal

    private val mCurrencyOriginOrFinal = MutableLiveData<String>()
    var currencyOriginOrFinal: LiveData<String> = mCurrencyOriginOrFinal

    private val mPriceOrigin = MutableLiveData<Double>()
    var priceOrigin : LiveData<Double> = mPriceOrigin

    private val mPriceFinal = MutableLiveData<Double>()
    var priceFinal : LiveData<Double> = mPriceFinal

    private val mSortCurrencies = MutableLiveData<String>()
    var sortCurrencies : LiveData<String> = mSortCurrencies

    private var mAbbrevOrigin : String = ""
    private var mAbbrevFinal : String = ""
    private val mCheckConnection = CheckConnection(application)

    fun checkCheckConnection(){
       mConnection.value =  mCheckConnection.isConnectionAvailable(getApplication())
    }

    fun defineOriginOrFinal(str: String){
        mCurrencyOriginOrFinal.value = str
    }

    fun setCurrencyOrigin(abbrev: String, currency: String){
        mCurrencyOrigin.value = currency
        mAbbrevOrigin = abbrev
        mPriceOrigin.value = picRates(abbrev)
    }

    fun setCurrencyFinal(abbrev: String, currency: String){
        mCurrencyFinal.value = currency
        mAbbrevFinal = abbrev
        mPriceFinal.value = picRates(abbrev)
    }

    private fun picRates(abbrev: String) : Double{
        val strKey = "USD$abbrev"
        val model = mRatesLocalRepository.picRates(strKey)
        if(model != null ) {
            if (model.price == 0.00) {
                mLoadRatesLocal.value = false
            }
            return model.price
        }
        mLoadRatesLocal.value = false
        return 0.00
    }

    fun loadCurrenciesRemote() {
        mCurrenciesRemoteRepository.loadCurrencies(object : APIListener<CurrenciesModelRemote> {
            override fun onSuccess(modelRemote: CurrenciesModelRemote) {
                saveCurrenciesLocal(modelRemote)
                mLoadCurrenciesRemote.value = true
            }
            override fun onFailure(str: String) {
                mOnFailureMessage.value = str
            }
        })
    }

    fun loadCurrenciesLocal() {
        var result = mCurrenciesLocalRepository.getAll()
        mLoadCurrenciesLocal.value = result
    }

    fun loadRatesRemote() {
        mRatesRemoteRepository.loadRates(object : APIListener<RatesModelRemote> {
            override fun onSuccess(modelRemote: RatesModelRemote) {
                saveRatesLocal(modelRemote)
            }
            override fun onFailure(str: String) {
                mOnFailureMessage.value = str
            }
        })
    }

    fun saveCurrenciesLocal(modelRemote: CurrenciesModelRemote){
        var mCurrenciesModelLocal = CurrenciesModelLocal()
        for ((k,v) in modelRemote.currencies){
            mCurrenciesModelLocal.apply {
                this.abbrev = k
                this.currency = v
            }
            mCurrenciesLocalRepository.saveCurrencies(mCurrenciesModelLocal)
        }
    }

    fun saveRatesLocal(modelRemote: RatesModelRemote){
        var mRatesModelLocal = RatesModelLocal()
        for ((k,v) in modelRemote.quotes){
            mRatesModelLocal.apply {
                this.abbrev = k
                this.price = v
            }
            mRatesLocalRepository.saveRates(mRatesModelLocal)
        }
    }

    fun chooseSortCurrencies(str: String){
        mSortCurrencies.value = str
    }

    fun dialogMessage(message: String, context : Context?) {
        val builder = AlertDialog.Builder(context)
        builder.setTitle(R.string.currencies)
        builder.setMessage(message)
        builder.setIcon(R.drawable.ic_btg)
        builder.setPositiveButton(R.string.ok) { dialog, which ->
            Toast.makeText(context, R.string.null_msg, Toast.LENGTH_SHORT)
        }
        builder.show()
    }
}