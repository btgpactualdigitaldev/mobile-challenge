package com.br.cambio.customviews

import android.text.Editable
import android.text.TextWatcher
import com.br.cambio.R

class DialogSpinnerTextWatcher(private val spinnerList: List<DialogSpinnerModel>,
                               private val dialogSpinnerAdapter: DialogSpinnerAdapter,
                               private val dialogSpinnerSearchListener: DialogSpinnerSearchListener) : TextWatcher {
    override fun afterTextChanged(s: Editable?) {
        /* Não implementado */
    }

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
        /* Não implementado */
    }

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        refreshRecyclerList(s)
        setTextStyle(s.toString())
    }

    private fun refreshRecyclerList(searchText: CharSequence?) {
        val filteredList = DialogSpinnerHelper().filterList(spinnerList, searchText)

        setListState(filteredList)

        dialogSpinnerAdapter.updateList(filteredList)
    }

    private fun setListState(filteredList: List<DialogSpinnerModel>) {
        if (filteredList.isNotEmpty()) {
            dialogSpinnerSearchListener.setFilteredState()
        } else {
            dialogSpinnerSearchListener.setEmptyState()
        }
    }

    private fun setTextStyle(searchText: String) {
        if (searchText.isNotEmpty()) {
            dialogSpinnerAdapter.setTextStyle(R.font.text_bold)
            dialogSpinnerSearchListener.showButtonClear()
        } else {
            dialogSpinnerAdapter.setTextStyle(R.font.text_light)
            dialogSpinnerSearchListener.hideButtonClear()
        }
    }

}