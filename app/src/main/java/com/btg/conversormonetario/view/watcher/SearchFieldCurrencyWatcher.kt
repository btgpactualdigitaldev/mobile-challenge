package com.btg.conversormonetario.view.watcher

import android.text.Editable
import android.text.TextWatcher
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.view.viewmodel.ChooseCurrencyViewModel
import java.util.*

class SearchFieldCurrencyWatcher(
    private var viewModel: ChooseCurrencyViewModel,
    private var itemsFiltered: (ArrayList<InfoCurrencyModel.DTO>) -> Unit = { }
) :
    TextWatcher {

    override fun afterTextChanged(editable: Editable?) {
        filter(editable.toString())
    }

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
    }

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
    }

    private fun filter(text: String) {
        val originalList = viewModel.localCurrenciesSingleton.value ?: arrayListOf()
        val filterdList: ArrayList<InfoCurrencyModel.DTO> = arrayListOf()

        for (item in originalList) {
            if (item.name?.toLowerCase(Locale.ROOT)?.contains(text.toLowerCase(Locale.ROOT))!! ||
                item.code?.toLowerCase(Locale.ROOT)?.contains(text.toLowerCase(Locale.ROOT))!!
            ) {
                filterdList.add(item)
            }
        }
        itemsFiltered.invoke(filterdList)
    }
}