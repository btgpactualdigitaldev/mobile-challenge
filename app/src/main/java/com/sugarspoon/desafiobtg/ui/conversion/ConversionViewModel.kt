package com.sugarspoon.desafiobtg.ui.conversion

import android.app.Activity.RESULT_OK
import android.content.Intent
import androidx.lifecycle.*
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.data.local.entity.QuotationEntity
import com.sugarspoon.data.local.model.CurrencyModel
import com.sugarspoon.data.local.model.QuotationModel
import com.sugarspoon.data.local.model.toListCurrencyModel
import com.sugarspoon.data.local.model.toListQuotationModel
import com.sugarspoon.data.local.repositories.RepositoryLocal
import com.sugarspoon.data.repositories.ExchangeRateRepository
import com.sugarspoon.desafiobtg.utils.Constants
import com.sugarspoon.desafiobtg.utils.extensions.formatCurrencyBRL
import com.sugarspoon.desafiobtg.utils.extensions.singleSubscribe
import io.reactivex.disposables.CompositeDisposable
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.launch

class ConversionViewModel(
    private val repositoryRemote: ExchangeRateRepository,
    private val repositoryLocal: RepositoryLocal
) : ViewModel() {

    private val compositeDisposable = CompositeDisposable()
    private val allCurrenciesOnDb = repositoryLocal.allCurrencies
    private val allQuotations = repositoryLocal.allQuotations
    private var currencies: List<CurrencyEntity>? = null
    private var changeOptions = ChangeOptions()
    private val _state = MutableLiveData<ConversionStates>()
    var state = _state

    private fun loadCurrencies() {
        if (currencies.isNullOrEmpty()) {
            _state.value = ConversionStates(stateLoading = true)
            compositeDisposable.add(repositoryRemote.fetchSupportedCurrencies().singleSubscribe(
                onSuccess = {
                    saveCurrenciesOnDb(it.toListCurrencyModel())
                    _state.value = ConversionStates(stateLoading = false)
                },
                onError = {
                    _state.value = ConversionStates(displayError = ERROR_CURRENCIES)
                    _state.value = ConversionStates(stateLoading = false)
                }
            ))
        }
    }

    private fun loadRealTimeRates() {
        _state.value = ConversionStates(stateLoading = true)
        compositeDisposable.add(repositoryRemote.fetchRealTimeRates().singleSubscribe(
            onSuccess = {
                saveQuotationsOnDb(quotations = it.toListQuotationModel())
                _state.value = ConversionStates(stateLoading = false)
            },
            onError = {
                _state.value = ConversionStates(displayError = ERROR_QUOTE)
                _state.value = ConversionStates(stateLoading = false)
            }
        ))
    }

    private fun saveCurrenciesOnDb(
        currencies: List<CurrencyModel> = mutableListOf()
    ) {
        currencies.forEach {
            repositoryLocal.insertCurrency(
                CurrencyEntity(
                    id = DEFAULT_INTEGER,
                    code = it.code,
                    name = it.name
                )
            )
        }
    }

    private fun saveQuotationsOnDb(
        quotations: List<QuotationModel> = mutableListOf()
    ) {
        quotations.forEach {
            repositoryLocal.insertQuotation(
                QuotationEntity(
                    id = DEFAULT_INTEGER,
                    code = it.code,
                    value = it.value
                )
            )
        }
    }

    fun loadDataOnDb() {
        viewModelScope.launch {
            allCurrenciesOnDb.collect {
                currencies = it
                if (it.isNullOrEmpty()) {
                    loadCurrencies()
                }
            }
        }
        viewModelScope.launch {
            allQuotations.collect {
                if (it.isNullOrEmpty()) {
                    loadRealTimeRates()
                }
            }
        }
    }

    fun updateData() {
        repositoryLocal.deleteQuotation()
        repositoryLocal.deleteCurrency()
        loadDataOnDb()
    }

    fun onClear() {
        compositeDisposable.dispose()
    }

    fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ) {
        if (resultCode == RESULT_OK) {
            when (requestCode) {
                RESULT_FROM_ORIGIN -> {
                    val argument = data?.getStringExtra(Constants.CODE_EXTRA_INTENT) ?: ""
                    argument.run {
                        _state.value = ConversionStates(stateOriginText = this)
                        changeOptions.origin = repositoryLocal.getQuotationByCode(this)
                        collectOriginCurrency()
                    }
                }
                RESULT_FROM_DESTINY -> {
                    val argument = data?.getStringExtra(Constants.CODE_EXTRA_INTENT) ?: ""
                    argument.run {
                        _state.value = ConversionStates(stateDestinyText = this)
                        changeOptions.destiny = repositoryLocal.getQuotationByCode(this)
                    }
                }
            }
        }
    }

    fun setValueFromConvert(value: String) {
        _state.value = ConversionStates(
            buttonOriginIsVisible = value.isNotEmpty()
        )
        changeOptions.valueToConvert = flowOf(
            value.trim().replace(",", ".").toFloat()
        )
    }

    private fun collectOriginCurrency() {
        viewModelScope.launch {
            changeOptions.origin?.collect { quote ->
                quote?.value?.run {
                    changeOptions.run {
                        valueToConvert?.collect { valueToConvert ->
                            (valueToConvert * quote.value) * CORRECTION_FACTOR
                            valueInDollar =
                                flowOf((valueToConvert * quote.value) * CORRECTION_FACTOR)
                            _state.value = ConversionStates(buttonDestinyIsVisible = true)
                        }
                    }
                }
            }
        }
    }

    fun convertCurrency() {
        collectOriginCurrency()
        viewModelScope.launch {
            changeOptions.destiny?.collect { quote ->
                quote?.value?.run {
                    changeOptions.run {
                        destiny?.collect { quote ->
                            quote?.value?.run {
                                changeOptions.valueInDollar?.collect { valueInDollar ->
                                    _state.value =
                                        ConversionStates(
                                            amount = quote.code + " ${
                                                (valueInDollar / quote.value)
                                                    .formatCurrencyBRL(showCurrency = false)
                                            }"
                                        )
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    class Factory constructor(
        private val repositoryRemote: ExchangeRateRepository,
        private val repositoryLocal: RepositoryLocal
    ) : ViewModelProvider.NewInstanceFactory() {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            return ConversionViewModel(
                repositoryRemote = repositoryRemote,
                repositoryLocal = repositoryLocal
            ) as T
        }
    }

    data class ChangeOptions(
        var origin: Flow<QuotationEntity?>? = null,
        var destiny: Flow<QuotationEntity?>? = null,
        var amount: Flow<Float>? = null,
        var valueToConvert: Flow<Float>? = null,
        var valueInDollar: Flow<Float>? = null,
    )

    data class ConversionStates(
        val stateLoading: Boolean? = false,
        val stateOriginText: String? = null,
        val stateDestinyText: String? = null,
        val amount: String? = null,
        val buttonOriginIsVisible: Boolean? = null,
        val buttonDestinyIsVisible: Boolean? = null,
        val displayError: String? = null
    )

    companion object {
        private const val DEFAULT_INTEGER = 0
        private const val RESULT_FROM_ORIGIN = 100
        private const val RESULT_FROM_DESTINY = 200
        private const val CORRECTION_FACTOR = 10
        private const val ERROR_CURRENCIES =
            "Falha ao carregar os tipos de moedas, tente novamente mais tarde"
        private const val ERROR_QUOTE =
            "Falha ao carregar as taxas de câmbio, tente novamente mais tarde"
    }
}
