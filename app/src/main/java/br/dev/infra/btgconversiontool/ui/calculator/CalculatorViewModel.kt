package br.dev.infra.btgconversiontool.ui.calculator

import android.icu.text.SimpleDateFormat
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.dev.infra.btgconversiontool.data.CurrencyTable
import br.dev.infra.btgconversiontool.data.QuotesTable
import br.dev.infra.btgconversiontool.data.TimestampTable
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import java.util.*
import javax.inject.Inject

@HiltViewModel
class CalculatorViewModel @Inject constructor(
    private val repository: CalculatorRepository
) : ViewModel() {

    private val _status = MutableLiveData<String>()
    val status: LiveData<String> = _status


    enum class ApiStatus { LOADING, DONE, ERROR }

    private var _currencyList = MutableLiveData<List<CurrencyTable>?>()
    val currencyList: LiveData<List<CurrencyTable>?> = _currencyList

    private var convertOrigin = 0F
    private var convertDestiny = 0F
    private var convertAmount = 0F
    var destinyId: String = ""

    private var _currency = MutableLiveData<Float>()
    val currency: LiveData<Float> = _currency


    fun updateData() {
        var updateStatus: String
        viewModelScope.launch {
            ApiStatus.LOADING
            try {

                val currencyList = repository.getListApi()
                val quotesList = repository.getQuotesApi()

                repository.clearAllTables()

                currencyList.currencies.entries.forEach {
                    repository.insertCurrency(
                        CurrencyTable(
                            it.key.toString(),
                            it.value
                        )
                    )
                }
                quotesList.quotes.entries.forEach {
                    repository.insertQuotes(
                        QuotesTable(
                            it.key.toString().replaceFirst(quotesList.source, ""),
                            quotesList.source,
                            it.value
                        )
                    )
                }

                repository.insertTimestamp(
                    TimestampTable(SimpleDateFormat("HH:mm dd/MM/yyyy").format(Date()))
                )

                updateStatus = ApiStatus.DONE.name


            } catch (e: Exception) {
                updateStatus = ApiStatus.ERROR.name
            }
            loadData(updateStatus)
        }
    }

    private fun loadData(connStatus: String) {

        if (connStatus == "DONE") {
            viewModelScope.launch {
                _currencyList.value = repository.getAllCurrenciesDB()
            }
            _status.value = ""
        } else {
            viewModelScope.launch {
                _currencyList.value = repository.getAllCurrenciesDB()
                _status.value = repository.getTimestampDB()
            }

        }
    }

    fun getQuote(id: String, type: String) {
        viewModelScope.launch {
            if (type == "ORIGIN") {
                convertOrigin = repository.getQuotesDb(id)
            } else if (type == "DESTINY") {
                destinyId = id
                convertDestiny = repository.getQuotesDb(id)
            }
            getCurrency()
        }
    }

    private fun getCurrency() {
        _currency.value = (convertDestiny / convertOrigin) * convertAmount
    }

    fun setAmount(amount: String) {
        if (amount == "") {
            convertAmount = 0F
            getCurrency()
        } else {
            convertAmount = amount.toFloat()
            getCurrency()
        }
    }
}