package com.romildosf.currencyconverter.view

import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.romildosf.currencyconverter.R
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.view.list.CurrencyViewAdapter
import kotlinx.android.synthetic.main.selection_item_dialog.*
import kotlinx.android.synthetic.main.selection_item_dialog.view.*

class SelectionItemDialog(val currencies: List<Currency>) : DialogFragment() {
    var interactionListener: (currency: Currency) -> Unit = {}

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val rootView = inflater.inflate(R.layout.selection_item_dialog, container)

        with(rootView.currencyListRv) {
            layoutManager = LinearLayoutManager(context)
            hasFixedSize()
            adapter = CurrencyViewAdapter(currencies).apply {
                interactionListener = ::onItemSelected
            }
        }

        CurrencyInputFilter(requireContext(), rootView.searchView, currencies)
            .changesListener = ::updateListView

        return rootView
    }

    private fun hideKeyboardFrom(context: Context, view: View) {
        val imm: InputMethodManager = context.getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(view.windowToken, 0)
    }

    private fun onItemSelected(currency: Currency) {
        Log.e(TAG, "Item ${currency.symbol}")

        hideKeyboardFrom(requireContext(), searchView)
        interactionListener.invoke(currency)
        dismiss()
    }

    private fun updateListView(items: List<Currency>) {
        val adapter = (requireView().currencyListRv.adapter as CurrencyViewAdapter)

        adapter.currencies = items
        adapter.notifyDataSetChanged()
    }

    companion object {
        const val TAG = "SelectionItemDialog"
    }
}