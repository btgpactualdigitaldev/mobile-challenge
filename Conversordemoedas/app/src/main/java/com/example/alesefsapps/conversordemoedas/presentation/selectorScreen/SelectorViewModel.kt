package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider
import android.util.Log
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.repository.CurrencyRepository
import com.example.alesefsapps.conversordemoedas.data.repository.ValueLiveRepository
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult

class SelectorViewModel(private val valueLiveRepository: ValueLiveRepository, private val currencyRepository: CurrencyRepository) : ViewModel() {

    val selectorLiveData: MutableLiveData<List<Values>> = MutableLiveData()
    val viewFlipperLiveData: MutableLiveData<Pair<Int, Int?>> = MutableLiveData()
    private val values: MutableList<Values> = mutableListOf()

    var quotes: List<Quote> = mutableListOf()
    var currencies: List<Currency> = mutableListOf()
    var timestamp: Int = 0

    fun getValueLive() {
        valueLiveRepository.getValueLive { result: LiveValueResult ->
            when(result) {
                is LiveValueResult.Success -> {
                    quotes = result.quotes
                    timestamp = result.timestamp
                    getCurrency(result.quotes, result.timestamp)
                }
                is LiveValueResult.ApiError -> {
                    when (result.statusCode) {
                        401 -> {
                            viewFlipperLiveData.value =
                                Pair(VIEW_FLIPPER_ERROR, R.string.error_401_live)
                        }
                        104 -> {
                            viewFlipperLiveData.value =
                                Pair(VIEW_FLIPPER_ERROR, R.string.error_104)
                        }
                        else -> {
                            viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_generico_live)
                        }
                    }
                }
                is LiveValueResult.SeverError -> {
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_server_live)
                }
            }
        }
    }

    fun getCurrency(quotes: List<Quote>, timestamp: Int) {
        currencyRepository.getCurrency { result: CurrencyResult ->
            when(result) {
                is CurrencyResult.Success -> {
                    this.quotes = quotes
                    this.timestamp = timestamp
                    currencies = result.currency
                    getValues(quotes, result.currency, timestamp)
                }
                is CurrencyResult.ApiError -> {
                    when (result.statusCode) {
                        401 -> {
                            viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_401_list)
                        }
                        104 -> {
                            viewFlipperLiveData.value =
                                Pair(VIEW_FLIPPER_ERROR, R.string.error_104)
                        }
                        else -> {
                            viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_generico_list)
                        }
                    }
                }
                is CurrencyResult.SeverError -> {
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_server_list)
                }
            }
        }
    }

    fun getValues(
        quotes: List<Quote>,
        currency: List<Currency>,
        timestamp: Int
    ) {
        currency.forEach { c ->
            quotes.forEach { q ->
                if (q.code.substring(3,6) == c.code) {
                    values.add(Values(c.code, c.name, q.value, timestamp))
                    values.sortBy { values -> values.name }
                }
            }
        }

            selectorLiveData.value = values
            viewFlipperLiveData.value = Pair(VIEW_FLIPPER_CURRENCY_LIST, null)
    }

    companion object {
        private const val VIEW_FLIPPER_CURRENCY_LIST = 1
        private const val VIEW_FLIPPER_ERROR = 2
    }


    class ViewModelFactory(private val valueLiveRepository: ValueLiveRepository, private val currencyRepository: CurrencyRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(SelectorViewModel::class.java)) {
                return SelectorViewModel(valueLiveRepository, currencyRepository) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }

}