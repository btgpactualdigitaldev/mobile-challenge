package com.btgpactual.currencyconverter.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.ConversionEntity
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.toCurrencyModel
import com.btgpactual.currencyconverter.data.model.CurrencyModel
import com.btgpactual.currencyconverter.data.repository.ConversionInternalRepository
import com.btgpactual.currencyconverter.data.repository.CurrencyInternalRepository
import com.btgpactual.currencyconverter.util.addCommaCollection
import com.btgpactual.currencyconverter.util.convertMillisToDateFormat
import com.btgpactual.currencyconverter.util.convertMillisToHourFormat
import com.btgpactual.currencyconverter.util.removeInvalidCharacters
import kotlinx.coroutines.launch
import java.math.BigDecimal
import java.util.*

class CurrencyViewModel(private val conversionInternalRepository: ConversionInternalRepository, private val currencyInternalRepository: CurrencyInternalRepository) : ViewModel() {

    val conversionListLiveData = MutableLiveData<List<ConversionEntity>>()

    val currencyListCurrentSortType = MutableLiveData<SortType>()

    val currencyListLiveData = MutableLiveData<List<CurrencyModel>>()

    val conversionStateLiveData = MutableLiveData<ConversionState>()

    val initialCurrencyLiveData = MutableLiveData<CurrencyModel>()
    val finalCurrencyLiveData = MutableLiveData<CurrencyModel>()

    var currencySelectedToChange : CurrencyType? = null

    fun deleteConversion(position:Int) {
        viewModelScope.launch {
            val id = conversionListLiveData.value?.get(position)?.id ?: return@launch
            conversionInternalRepository.delete(id)
            setConversionList()
        }
    }

    fun saveConversion(initialCurrencyValue: String, finalCurrencyValue: String) {
        if(
            initialCurrencyValue.isBlank()||
            finalCurrencyValue.isBlank()||
            initialCurrencyLiveData.value == null||
            finalCurrencyLiveData.value == null
        ){
            conversionStateLiveData.value =
                ConversionState.ConversionNotSaved(
                    R.string.currency_view_model_error_conversion_save_failed
                )
            return
        }

        val conversionModel = ConversionEntity(
            initialCurrencyLiveData.value!!.codigo,
            finalCurrencyLiveData.value!!.codigo,
            initialCurrencyValue.removeInvalidCharacters(),
            finalCurrencyValue.removeInvalidCharacters(),
            Calendar.getInstance().timeInMillis
        )

        viewModelScope.launch {
            conversionInternalRepository.insert(conversionModel)
            conversionStateLiveData.value =
                ConversionState.ConversionSaved
            setConversionList()
        }
    }

    fun setConversionList() {
        viewModelScope.launch {
            val conversionList = conversionInternalRepository.getAll()

            conversionListLiveData.value = conversionList
        }
    }

    fun setCurrencyList(sortType: SortType = SortType.Default){
        viewModelScope.launch {
            val currencyList = currencyInternalRepository.getAll()

            when (sortType) {
                is SortType.Default -> {
                    currencyListCurrentSortType.value = sortType
                    currencyListLiveData.value = currencyList
                }
                is SortType.Text -> {
                    currencyListCurrentSortType.value = sortType

                    currencyListLiveData.value = if(sortType.text == "") currencyList else currencyList.filter {
                        it.codigo.toUpperCase(Locale.getDefault()).contains(sortType.text.toUpperCase(
                            Locale.getDefault()
                        )
                        ) || it.nome.toUpperCase(Locale.getDefault()).contains(
                            sortType.text.toUpperCase(Locale.getDefault())
                        )
                    }
                }
                is SortType.Code.NextSort -> {
                    when(currencyListCurrentSortType.value){
                        SortType.Code.Ascending -> {
                            currencyListCurrentSortType.value =
                                SortType.Code.Descending
                            currencyListLiveData.value = currencyList.sortedByDescending { it.codigo }
                        }
                        SortType.Code.Descending -> {
                            currencyListCurrentSortType.value =
                                SortType.Default
                            currencyListLiveData.value = currencyList
                        }
                        else ->{
                            currencyListCurrentSortType.value =
                                SortType.Code.Ascending
                            currencyListLiveData.value = currencyList.sortedBy { it.codigo }
                        }
                    }
                }
                is SortType.Name.NextSort -> {
                    when(currencyListCurrentSortType.value){
                        SortType.Name.Ascending -> {
                            currencyListCurrentSortType.value =
                                SortType.Name.Descending
                            currencyListLiveData.value = currencyList.sortedByDescending { it.nome }
                        }
                        SortType.Name.Descending -> {
                            currencyListCurrentSortType.value =
                                SortType.Default
                            currencyListLiveData.value = currencyList
                        }
                        else ->{
                            currencyListCurrentSortType.value =
                                SortType.Name.Ascending
                            currencyListLiveData.value = currencyList.sortedBy { it.nome }
                        }
                    }
                }
            }
        }

    }

    fun setCurrencySelectedToChange(currencyModel: CurrencyModel){
        when(currencySelectedToChange){
            CurrencyType.Initial -> initialCurrencyLiveData.value = currencyModel
            CurrencyType.Final -> finalCurrencyLiveData.value = currencyModel
        }
    }

    fun setDefaultCurrency(currencyType: CurrencyType){
        viewModelScope.launch {
            val code =
                when(currencyType){
                    CurrencyType.Initial -> DEFAULT_INITIAL_CURRENCY
                    CurrencyType.Final -> DEFAULT_FINAL_CURRENCY
                }

            val currency = currencyInternalRepository.getByCode(code)

            if(currency != null) {
                when (currencyType) {
                    CurrencyType.Initial -> initialCurrencyLiveData.value = currency
                    CurrencyType.Final -> finalCurrencyLiveData.value = currency
                }
            }else{
                val firstCurrency = currencyInternalRepository.getFirst().toCurrencyModel()
                initialCurrencyLiveData.value = firstCurrency
            }
        }

    }

    fun calculateConversion(changedCurrencyType: CurrencyType, originalValueString:String){
        if(originalValueString == ""){
            conversionStateLiveData.value =
                ConversionState.ConversionEmptyValueFound
            return
        }

        val originalCurrency=
            when(changedCurrencyType){
                CurrencyType.Initial -> initialCurrencyLiveData.value?.cotacao?.toBigDecimal()
                CurrencyType.Final -> finalCurrencyLiveData.value?.cotacao?.toBigDecimal()
            }
                ?: return

        val targetCurrency =
            when(changedCurrencyType){
                CurrencyType.Initial -> finalCurrencyLiveData.value?.cotacao?.toBigDecimal()
                CurrencyType.Final -> initialCurrencyLiveData.value?.cotacao?.toBigDecimal()
            }
                ?: return

        val originalValue = originalValueString.replace(".", "").replace(",", ".").toBigDecimal()

        if(originalValue > MAX_CONVERSION_VALUE.toBigDecimal()){
            conversionStateLiveData.value =
                ConversionState.ConversionInputMaxValueReached(
                    R.string.currency_view_model_error_conversion_input_bigger_then_max_value
                )
            return
        }

        val targetValue =
            originalValue.divide(originalCurrency, 1, BigDecimal.ROUND_DOWN)
                .multiply(targetCurrency).setScale(2, BigDecimal.ROUND_DOWN)

        if(targetValue > MAX_CONVERSION_VALUE.toBigDecimal()){
            conversionStateLiveData.value =
                ConversionState.ConversionOutputMaxValueReached(
                    R.string.currency_view_model_error_conversion_output_bigger_then_max_value
                )
            return
        }

        when(changedCurrencyType) {
            CurrencyType.Initial -> {
                conversionStateLiveData.value =
                    ConversionState.ConversionSuccessful(
                        addCommaCollection(originalValue.toPlainString()),
                        addCommaCollection(targetValue.toPlainString()),
                        "${convertMillisToDateFormat(finalCurrencyLiveData.value?.dataHoraUltimaAtualizacao)} - ${convertMillisToHourFormat(finalCurrencyLiveData.value?.dataHoraUltimaAtualizacao)}"
                    )
            }
            CurrencyType.Final -> {
                conversionStateLiveData.value =
                    ConversionState.ConversionSuccessful(
                        addCommaCollection(targetValue.toPlainString()),
                        addCommaCollection(originalValue.toPlainString()),
                        "${convertMillisToDateFormat(initialCurrencyLiveData.value?.dataHoraUltimaAtualizacao)} - ${convertMillisToHourFormat(initialCurrencyLiveData.value?.dataHoraUltimaAtualizacao)}"
                    )
            }
        }

    }

    fun switchInitialCurrencyWithFinalCurrency() {
        initialCurrencyLiveData.value = finalCurrencyLiveData.value.also { finalCurrencyLiveData.value = initialCurrencyLiveData.value }
    }

    sealed class ConversionState {
        class ConversionSuccessful(val initial:String,val final:String,val dateHour:String) : ConversionState()
        object ConversionEmptyValueFound : ConversionState()
        class ConversionInputMaxValueReached(val messageResId:Int,val maxValue:String = MAX_CONVERSION_VALUE.toString(), val maxValueDigitCount:Int = MAX_CONVERSION_VALUE_DIGIT_COUNT) : ConversionState()
        class ConversionOutputMaxValueReached(val messageResId:Int,val maxValue:String = MAX_CONVERSION_VALUE.toString(), val maxValueDigitCount:Int = MAX_CONVERSION_VALUE_DIGIT_COUNT) : ConversionState()
        object ConversionSaved : ConversionState()
        class ConversionNotSaved(val messageResId:Int) : ConversionState()
    }

    sealed class CurrencyType {
        object Initial : CurrencyType()
        object Final : CurrencyType()
    }

    sealed class SortType {
        object Default : SortType()

        class Text(var text:String) : SortType()

        sealed class Code : SortType() {
            object Ascending : Code()
            object Descending : Code()
            object NextSort : Code()
        }

        sealed class Name : SortType() {
            object Ascending : Name()
            object Descending : Name()
            object NextSort : Name()
        }
    }

    companion object {
        private const val MAX_CONVERSION_VALUE = 999999999999999999
        private const val MAX_CONVERSION_VALUE_DIGIT_COUNT = 18
        private const val DEFAULT_INITIAL_CURRENCY = "USD"
        private const val DEFAULT_FINAL_CURRENCY = "BRL"
    }

}