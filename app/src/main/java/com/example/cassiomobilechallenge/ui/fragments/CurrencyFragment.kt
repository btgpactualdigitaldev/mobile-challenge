package com.example.cassiomobilechallenge.ui.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.example.cassiomobilechallenge.R
import com.example.cassiomobilechallenge.interfaces.CurrencyInterface
import com.example.cassiomobilechallenge.models.Currency
import com.example.cassiomobilechallenge.viewmodels.MainViewModel

/**
 * A fragment representing a list of Items.
 */
class CurrencyFragment : Fragment(), CurrencyInterface {

    private var columnCount = 1
    private lateinit var typeCurrency: String
    private lateinit var viewModel: MainViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        arguments?.let {
            columnCount = it.getInt(ARG_COLUMN_COUNT)
            typeCurrency = it.getString(TYPE_CURRENCY)!!
        }

        viewModel = ViewModelProviders.of(requireActivity()).get(MainViewModel::class.java)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_currency_list, container, false)

        val recyclerView: RecyclerView = view.findViewById(R.id.reciclerView)
        recyclerView.layoutManager = when {
            columnCount <= 1 -> LinearLayoutManager(context)
            else -> GridLayoutManager(context, columnCount)
        }
        recyclerView.adapter = CurrencyListAdapter(viewModel.countryCurrencies.value!!, this)

        return view
    }

    companion object {

        const val ARG_COLUMN_COUNT = "column-count"
        const val TYPE_CURRENCY = "type-currency"
        fun newInstance(columnCount: Int, typeCurrency: String) =
            CurrencyFragment().apply {
                arguments = Bundle().apply {
                    putInt(ARG_COLUMN_COUNT, columnCount)
                    putString(TYPE_CURRENCY, typeCurrency)
                }
            }
    }

    override fun onCurrencyClick(currency: Currency) {

        if (typeCurrency.equals("FROM")) {
            viewModel.currencyFrom.value =currency
        } else {
            viewModel.currencyTo.value = currency
        }

        setupButtons()

    }

    fun setupButtons() {
        viewModel.currencyFrom.observe(this, Observer { currency ->
            if (currency != null) {
                viewModel.currencyFrom.removeObservers(this.viewLifecycleOwner)
                activity?.supportFragmentManager?.beginTransaction()?.replace(R.id.container, MainFragment.newInstance())
                    ?.commitNow()
            }
        })

        viewModel.currencyTo.observe(this, Observer { currency ->
            if (currency != null) {
                viewModel.currencyTo.removeObservers(this.viewLifecycleOwner)
                activity?.supportFragmentManager?.beginTransaction()?.replace(R.id.container, MainFragment.newInstance())
                    ?.commitNow()
            }
        })
    }

}