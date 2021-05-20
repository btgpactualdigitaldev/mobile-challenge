package br.com.albertomagalhaes.btgcurrencies.viewmodel

import androidx.lifecycle.ViewModel
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import br.com.albertomagalhaes.btgcurrencies.repository.CurrencyRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.math.BigDecimal

class MainViewModel(private val currencyRepository: CurrencyRepository) : ViewModel() {
    fun calculateConversion(
        originalValueString: String,
        currencyList: MutableList<CurrencyDTO>,
        selectedCurrencyDTO: CurrencyDTO?
    ): MutableList<CurrencyDTO> {

        if (originalValueString.isNullOrBlank()) {
            currencyList.forEach {
                it.convertedValue = BigDecimal(0)
            }
            return currencyList
        }

        val originalValue = originalValueString.replace(".", "").replace(",", ".").toBigDecimal()
        val originalQuote = selectedCurrencyDTO?.value?.toBigDecimal()

        currencyList.forEach {
            it.convertedValue = originalValue.divide(originalQuote, 2, BigDecimal.ROUND_HALF_UP)
                .multiply(it.value.toBigDecimal()).setScale(2, BigDecimal.ROUND_HALF_UP)
        }

        return currencyList
    }

    fun getCurrencyList(
        onlySelected: Boolean = false,
        onSuccess: (result: List<CurrencyDTO>) -> Unit
    ) = GlobalScope.launch(Dispatchers.Main) {
        currencyRepository.getCurrencyList(onlySelected)?.let { onSuccess.invoke(it) }
    }

    fun updateCurrencyListSelected(currencyList: List<CurrencyDTO>, onSuccess: () -> Unit) =
        GlobalScope.launch(Dispatchers.Main) {
            currencyRepository.updateCurrencyListSelected(
                currencyList.filter { it.isSelected },
                onSuccess
            )
        }

    fun setDefaultCurrencyListSeleted(onSuccess: () -> Unit) =
        GlobalScope.launch(Dispatchers.Main) {
            currencyRepository.setDefaultCurrencyListSeleted(onSuccess)
        }
}