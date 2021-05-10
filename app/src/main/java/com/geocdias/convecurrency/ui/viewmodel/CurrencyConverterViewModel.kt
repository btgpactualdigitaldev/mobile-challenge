package com.geocdias.convecurrency.ui.viewmodel

import androidx.lifecycle.*
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.model.ExchangeRateModel
import com.geocdias.convecurrency.repository.CurrencyRepository
import com.geocdias.convecurrency.util.NetworkConnectionLiveData
import com.geocdias.convecurrency.util.Resource
import com.geocdias.convecurrency.util.Status
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject
import kotlin.math.round


@HiltViewModel
class CurrencyConverterViewModel @Inject constructor(val repository: CurrencyRepository, val conectivity: NetworkConnectionLiveData) :
    ViewModel() {

    val defaultFromCurrent = "USD"

    val defaultToCurrent = "BRL"

    val currencyList: LiveData<Resource<List<CurrencyModel>>> = repository.fetchCurrencies()


    private fun getRate(fromCurrency: String, toCurrency: String) = repository.getRate(fromCurrency, toCurrency)


    fun convert(fromCurrency: String, toCurrency: String, amount: String): LiveData<Resource<Double>> {
        val fromAmount = amount.toDoubleOrNull() ?: return liveData { emit(Resource.error("Valor inválido")) }

        if (fromCurrency != defaultFromCurrent) {
            return convertFromAnotherCurrency(fromCurrency, toCurrency, fromAmount)
        }

        return convertFromDolar(toCurrency, fromAmount)
    }

    private fun convertFromDolar(to: String, amount: Double): LiveData<Resource<Double>> {
        return MediatorLiveData<Resource<Double>>().apply {
            addSource(getRate(defaultFromCurrent, to)) { resource ->
                when (resource.status) {
                    Status.LOADING -> this.value = Resource.loading()
                    Status.ERROR -> this.value = Resource.error(resource.message.toString())
                    Status.SUCCESS -> {
                        if (resource.data != null) {
                            this.value = Resource.success(calculate(resource.data.rate, amount))
                        }
                    }
                }
            }
        }.distinctUntilChanged()
    }

    fun convertFromAnotherCurrency(from: String, toCurrency: String, amount: Double): LiveData<Resource<Double>> {
        return MediatorLiveData<Resource<Double>>().apply {
            var resourceFromCurrency: Resource<ExchangeRateModel>? = null
            var resourceToCurrency: Resource<ExchangeRateModel>? = null

            fun handleResource(resource: Resource<ExchangeRateModel>, calculateFn: Unit) {
                when (resource.status) {
                    Status.LOADING -> this.value = Resource.loading()
                    Status.ERROR -> this.value = Resource.error(resource.message.toString())
                    Status.SUCCESS -> calculateFn
                }
            }

            fun convertCurrencies() {
                val localResourceFromCurrente = resourceFromCurrency
                val localResourceToCurrency = resourceToCurrency

                if (localResourceFromCurrente?.data != null && localResourceToCurrency?.data != null) {
                    val val1 = calculate(amount, 1 / localResourceFromCurrente.data.rate)
                    val val2 = calculate(val1, localResourceToCurrency.data.rate)

                    this.value = Resource.success(val2)
                }
            }

            addSource(getRate(defaultFromCurrent, from)) {
                resourceFromCurrency = it
                handleResource(it, convertCurrencies())
            }

            addSource(getRate(defaultFromCurrent, toCurrency)) {
                resourceToCurrency = it
                handleResource(it, convertCurrencies())

            }
        }.distinctUntilChanged()
    }


    fun calculate(amount: Double, rate: Double): Double {
        return round(amount * rate * 100) / 100
    }
}
