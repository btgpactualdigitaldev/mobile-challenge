package com.btg.conversormonetario.view.watcher

import android.text.Editable
import android.text.TextWatcher
import com.btg.conversormonetario.shared.currencyToBigDecimal
import com.btg.conversormonetario.view.viewmodel.ConverterCurrencyViewModel

class AmountCurrencyFieldWatcher(private var viewModel: ConverterCurrencyViewModel) :
    TextWatcher {

    override fun afterTextChanged(s: Editable?) {
    }

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
    }

    override fun onTextChanged(amountValue: CharSequence?, start: Int, before: Int, count: Int) {
        viewModel.updateStyleAmountValue(
            getCleanAmountValue(amountValue?.toString()).currencyToBigDecimal()
        )
        viewModel.callServiceGetCurrencyConverted(getCleanAmountValue(amountValue?.toString()))
    }

    private fun getCleanAmountValue(value: String?): String =
        value?.replace(".", "")?.replace(",", "") ?: "0"
}