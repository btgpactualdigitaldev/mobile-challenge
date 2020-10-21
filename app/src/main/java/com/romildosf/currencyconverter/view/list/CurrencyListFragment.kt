package com.romildosf.currencyconverter.view.list

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.romildosf.currencyconverter.R
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.util.NetworkCallException
import com.romildosf.currencyconverter.util.UnreachableNetworkException
import com.romildosf.currencyconverter.view.CurrencyInputFilter
import kotlinx.android.synthetic.main.fragment_currency_converter.*
import kotlinx.android.synthetic.main.fragment_currency_converter.view.*
import kotlinx.android.synthetic.main.fragment_item_list.view.*
import kotlinx.android.synthetic.main.fragment_item_list.view.swiperefresh
import kotlinx.android.synthetic.main.selection_item_dialog.*
import kotlinx.android.synthetic.main.selection_item_dialog.view.*
import org.koin.android.ext.android.inject

class CurrencyListFragment : Fragment() {

    private val viewModel: CurrencyListViewModel by inject()
    private lateinit var rootView: View

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        rootView = inflater.inflate(R.layout.fragment_item_list, container, false)

        with(rootView.currencyListRv) {
            layoutManager = LinearLayoutManager(context)
            adapter = CurrencyViewAdapter(emptyList())
        }

        rootView.swiperefresh.setOnRefreshListener {
            fetchCurrencyList()
        }

        fetchCurrencyList()

        return rootView
    }

    private fun fetchCurrencyList() {
        viewModel.fetchCurrencyList().observe(viewLifecycleOwner) { result ->
            val adapter = (rootView.currencyListRv.adapter as CurrencyViewAdapter)
            result.success?.let { list ->
                adapter.currencies = list.sortedBy { it.symbol }
                adapter.notifyDataSetChanged()
                CurrencyInputFilter(requireContext(), searchView, list).changesListener = ::updateList

            } ?: handleFailure(result.failure!!)

            rootView.swiperefresh.isRefreshing = false
        }
    }

    private fun updateList(currency: List<Currency>) {
        val adapter = (requireView().currencyListRv.adapter as CurrencyViewAdapter)
        adapter.currencies = currency
        adapter.notifyDataSetChanged()
    }

    private fun handleFailure(exception: Exception) {
        Log.e(TAG, "Error ", exception)

        when(exception) {
            is UnreachableNetworkException -> showToast(R.string.not_internet)
            is NetworkCallException -> showToast(R.string.service_error)
            else -> showToast(R.string.default_error)
        }
    }

    private fun showToast(id: Int) {
        Toast.makeText(requireContext(), id, Toast.LENGTH_LONG).show()
    }

    companion object {
        const val TAG = "CurrencyListFragment"
    }
}