package br.com.tiago.conversormoedas.presentation.conversor

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.tiago.conversormoedas.R
import br.com.tiago.conversormoedas.data.ConversionRepository
import br.com.tiago.conversormoedas.data.ConversionResult
import java.text.DecimalFormat

class ConversorViewModel(private val dataSource: ConversionRepository): ViewModel(){

    val conversionLiveDataOrigin: MutableLiveData<Float> = MutableLiveData()
    val conversionLiveDataDestiny: MutableLiveData<Float> = MutableLiveData()
    val conversionLiveDataResult: MutableLiveData<String> = MutableLiveData()
    val toastLiveDataResult: MutableLiveData<Int> = MutableLiveData()
    val validateLiveDataResult: MutableLiveData<String> = MutableLiveData()
    val changeColorOrigin: MutableLiveData<Boolean> = MutableLiveData()
    val changeColorDestiny: MutableLiveData<Boolean> = MutableLiveData()
    val changeColorValue: MutableLiveData<Boolean> = MutableLiveData()

    fun getRates(currency: String, flag: Int) {
        dataSource.getRates(currency = currency) { result: ConversionResult ->
            when(result) {
                is ConversionResult.Success -> {
                    if (flag == 1) {
                        conversionLiveDataOrigin.value = result.rate
                    } else {
                        conversionLiveDataDestiny.value = result.rate
                    }
                }
                is ConversionResult.ApiError -> {
                    if (result.statusCode == 401) {
                        toastLiveDataResult.value = R.string.coins_error_401
                    } else {
                        toastLiveDataResult.value = R.string.coins_error_400_generic
                    }
                }
                is ConversionResult.ServerError -> {
                    toastLiveDataResult.value = R.string.coins_error_500_generic
                }
            }
        }
    }

    fun calculateValue(origin: Float, destiny: Float, value: Float) {
        val originToUsd = 1/origin
        val calc = originToUsd * destiny
        val total = calc * value
        conversionLiveDataResult.value = DecimalFormat("#.##").format(total)
    }

    fun validateFields(context: Context, origin: String?, destiny: String?, value: String?){
        if (origin.isNullOrEmpty()){
            validateLiveDataResult.value = context.resources.getString(R.string.select_coin_origin)
            changeColorOrigin.value = true
        } else if (destiny.isNullOrEmpty()) {
            changeColorOrigin.value = false
            changeColorDestiny.value = true
            validateLiveDataResult.value = context.resources.getString(R.string.select_coin_destiny)
        } else if (value.isNullOrEmpty() || value.toFloat() < 0F){
            changeColorOrigin.value = false
            changeColorOrigin.value = false
            changeColorValue.value = true
            validateLiveDataResult.value = context.resources.getString(R.string.value_null_or_zero)
        } else {
            changeColorOrigin.value = false
            changeColorOrigin.value = false
            validateLiveDataResult.value = null
        }
    }

    class ViewModelFactory(private val dataSource: ConversionRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(ConversorViewModel::class.java)) {
                return ConversorViewModel(dataSource) as T
            }
            throw IllegalArgumentException("Unknown ViewModel Class")
        }
    }
}