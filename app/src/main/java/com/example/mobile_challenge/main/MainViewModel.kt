package com.example.mobile_challenge.main

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mobile_challenge.App
import com.example.mobile_challenge.R
import com.example.mobile_challenge.db.AppDatabase
import com.example.mobile_challenge.model.*
import com.example.mobile_challenge.utility.ClientApi
import com.example.mobile_challenge.utility.SingleLiveData
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.serialization.UnstableDefault
import java.util.*

@OptIn(UnstableDefault::class)
class MainViewModel(
  private var client: ClientApi = App.clientApi,
  private val dataBase: AppDatabase = App.db,
  private var quotes: List<QuoteEntity> = arrayListOf(),
  var currencyList: ArrayList<CurrencyEntity> = arrayListOf()
) : ViewModel() {

  // Handle Error
  val error: SingleLiveData<Int> = SingleLiveData()

  // Live currency value
  private val _liveValue: MutableLiveData<Double> = MutableLiveData()
  val liveValue: LiveData<Double> = _liveValue

  // Update "FROM" button
  private val _fromCode: MutableLiveData<String> = MutableLiveData()
  val fromCode: LiveData<String> = _fromCode

  // Update "TO" button
  private val _toCode: MutableLiveData<String> = MutableLiveData()
  val toCode: LiveData<String> = _toCode

  private var currencyFrom = 1.0
  private var currencyTo = 1.0

  init {
    getCurrency()
    getQuote()
  }

  // Handle Currency

  private fun getCurrency() {
    viewModelScope.launch(Dispatchers.Default) {
      when (val response = client.httpRequestGetList()) {
        is ResponseOptionsCurrency.SuccessResponse -> {
          handleCurrencySuccess(response)
        }
        is ResponseOptionsCurrency.ErrorResponse -> {
          error.postValue(R.string.connection_error)
          setCurrencyFromDb()
        }
      }
    }
  }

  private fun handleCurrencySuccess(response: ResponseOptionsCurrency.SuccessResponse) {
    if (response.data.success && response.data.currencies.isNotEmpty()) {
      updateCurrencyTableDb(response.data)
    } else {
      error.postValue(R.string.fetch_data_error)
      setQuoteFromDb()
    }
  }

  private fun updateCurrencyTableDb(currencyList: CurrencyResponse) {
    viewModelScope.launch(Dispatchers.Default) {
      val currenciesMap = currencyList.currencies
      val list = arrayListOf<CurrencyEntity>()
      var id = 1
      currenciesMap.forEach { entry ->
        val currency = CurrencyEntity(
          id,
          entry.key,
          entry.value
        )
        list.add(currency)
        id++
        dataBase.currencyDao().upsert(currency)
      }
      this@MainViewModel.currencyList = list
    }
  }

  private fun setCurrencyFromDb() {
    viewModelScope.launch(Dispatchers.Default) {
      val list = dataBase.currencyDao().getAll()
      if (list.isNotEmpty()) {
        list.flatMapTo(currencyList) { arrayListOf(it) }
      }
    }
  }

  // Handle Quote

  private fun getQuote() {
    viewModelScope.launch(Dispatchers.Default) {
      when (val response = client.httpRequestGetLive()) {
        is ResponseOptionsQuote.SuccessResponse -> {
          handleQuoteSuccess(response)
        }
        is ResponseOptionsQuote.ErrorResponse -> {
          error.postValue(R.string.connection_error)
          setQuoteFromDb()
        }
      }
    }
  }

  private fun handleQuoteSuccess(response: ResponseOptionsQuote.SuccessResponse) {
    if (response.data.success && response.data.quotes.isNotEmpty()) {
      updateQuoteTableDb(response.data)
      setQuoteValue("BRL", "TO")
    } else {
      error.postValue(R.string.fetch_data_error)
      setQuoteFromDb()
    }
  }

  private fun updateQuoteTableDb(data: QuoteResponse) {
    val list = mutableListOf<QuoteEntity>()
    var id = 1
    data.quotes.forEach { entry ->
      val quote = QuoteEntity(
        id,
        entry.key.substring(0..2),
        entry.key.substring(3..5),
        entry.value
      )
      list.add(quote)
      id++
      dataBase.quoteDao().upsert(quote)
    }
    quotes = list
  }

  private fun setQuoteFromDb() {
    viewModelScope.launch(Dispatchers.Default) {
      val quoteList = dataBase.quoteDao().getAll()
      if (quoteList.isNotEmpty()) {
        quotes = quoteList
        setQuoteValue("BRL", "TO")
      }
    }
  }

  fun setQuoteValue(code: String, type: String) {
    val value = quotes.find { it.to == code }?.value
    value?.let {
      if (type == "FROM") {
        currencyFrom = 1 / value
        _fromCode.postValue(code)
      } else {
        currencyTo = value
        _toCode.postValue(code)
      }
      _liveValue.postValue(currencyFrom * currencyTo)
    }
  }

}

