package br.com.btg.test.feature.currency.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.btg.test.data.Resource
import br.com.btg.test.feature.currency.business.ConvertUseCase
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class CurrencyViewModel(
    private val convertUseCase: ConvertUseCase
) : ViewModel() {

    lateinit var sourceCurrencyEntity: CurrencyEntity
    lateinit var targetCurrencyEntity: CurrencyEntity

    private val _convertResult = MutableLiveData<Resource<Double>>()

    val convertResult: LiveData<Resource<Double>> = _convertResult

    fun convert(value: Double) {
        val currencies = "${sourceCurrencyEntity.code},${targetCurrencyEntity.code}"

        viewModelScope.launch {
            _convertResult.value = Resource.loading()

            convertUseCase.invoke(ConvertUseCase.ConvertRequest(value, currencies)).catch { e ->
                _convertResult.value = Resource.error(e.message ?: "error")
            }.collect { value ->
                _convertResult.value = value
            }
        }
    }

}