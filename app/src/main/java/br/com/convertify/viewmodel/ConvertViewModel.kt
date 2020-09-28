package br.com.convertify.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.convertify.api.DataState
import br.com.convertify.models.CurrencyItem
import br.com.convertify.models.QuotationItem
import br.com.convertify.repository.CurrencyRepository
import br.com.convertify.repository.QuotationRepository
import br.com.convertify.util.ConverterUtils
import java.lang.Exception

class ConvertViewModel : ViewModel() {

    val originCurrency = MutableLiveData<CurrencyItem>()
    val targetCurrency = MutableLiveData<CurrencyItem>()
    val valueToConvert = MutableLiveData<Double>()
    val convertedValue = MutableLiveData<Double>()
    val errorNotifier = MutableLiveData<ConverterUtils.ConversionErrors>()


    private val currencyRepo by lazy { CurrencyRepository() }
    private val quotationRepository by lazy { QuotationRepository() }

    var currencyLiveDataState: MutableLiveData<DataState<Array<CurrencyItem>>> = MutableLiveData()
    var quotationLiveDataState: MutableLiveData<DataState<Array<QuotationItem>>> = MutableLiveData()


    fun convert() {

        when {
            valueToConvert.value == null -> {
                errorNotifier.value = ConverterUtils.ConversionErrors.MISSING_VALUE_TO_CONVERT
                return
            }
            originCurrency.value == null -> {
                errorNotifier.value = ConverterUtils.ConversionErrors.MISSING_ORIGIN_CURRENCY
                return
            }
            targetCurrency.value == null -> {
                errorNotifier.value = ConverterUtils.ConversionErrors.MISSING_TARGET_CURRENCY
                return
            }

        }

        try {
            val quotations = quotationLiveDataState.value

            val firstQuotation =
                quotations?.data?.find { it.targetCurrency == originCurrency.value?.code }
            val targetQuotation =
                quotations?.data?.find { it.targetCurrency == targetCurrency.value?.code }

            val firstQuotationDollar = 1 / firstQuotation?.value!!
            val targetQuotationDollar = 1 / targetQuotation?.value!!
            val multiplier = firstQuotationDollar / targetQuotationDollar

            convertedValue.value = valueToConvert.value?.times(multiplier)

        } catch (e: Exception) {
            e.printStackTrace()
            errorNotifier.value = ConverterUtils.ConversionErrors.UNEXPECTED_ERROR
        }

    }

    fun setOriginCurrency(originCurrencyItem: CurrencyItem) {
        originCurrency.value = originCurrencyItem
        this.convert()
    }

    fun setTargetCurrency(targetCurrencyItem: CurrencyItem) {
        targetCurrency.value = targetCurrencyItem
        this.convert()
    }

    fun setValueToConvert(value: Double) {
        valueToConvert.value = value
        this.convert()
    }

    fun getCurrencies() {
        currencyRepo.fetchAvailableCurrencies().observeForever {
            currencyLiveDataState.value = it
        }
    }

    fun getQuotations() {
        quotationRepository.fetchAvailableQuotations().observeForever {
            quotationLiveDataState.value = it
        }
    }

}
