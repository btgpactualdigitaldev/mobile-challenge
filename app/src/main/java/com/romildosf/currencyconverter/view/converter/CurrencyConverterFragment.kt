package com.romildosf.currencyconverter.view.converter

import android.os.Bundle
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.romildosf.currencyconverter.R
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.util.NetworkCallException
import com.romildosf.currencyconverter.util.UnreachableNetworkException
import com.romildosf.currencyconverter.view.SelectionItemDialog
import com.romildosf.currencyconverter.view.util.LoadingDialog
import kotlinx.android.synthetic.main.fragment_currency_converter.*
import kotlinx.android.synthetic.main.fragment_currency_converter.view.*
import kotlinx.android.synthetic.main.fragment_currency_converter.view.swiperefresh
import org.koin.android.ext.android.inject

class CurrencyConverterFragment : Fragment() {
    private var sourceCurrency: Currency? = null
    private var targetCurrency: Currency? = null
    private var value: Double = -1.0
    private var isSelectingSource = true

    private lateinit var rootView: View
    private val viewModel: CurrencyConverterViewModel by inject()
    private var currencies = emptyList<Currency>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        rootView = inflater.inflate(R.layout.fragment_currency_converter, container, false)


        setupUI()
        setupSwipeRefresh()
        fetchCurrencyList()
        showLoading()
        disableElements()
        return rootView
    }

    private fun showLoading() {
        LoadingDialog.show(requireContext())
    }

    private fun setupSwipeRefresh() {
        rootView.swiperefresh.setOnRefreshListener {
            fetchCurrencyList()
        }
    }

    private fun fetchCurrencyList() {
        viewModel.fetchCurrencyList().observe(viewLifecycleOwner) { result ->
            result.success?.let { items ->
                enableElements()
                currencies = items.sortedBy { it.symbol }
            } ?: handleFailure(result.failure!!)

            rootView.swiperefresh.isRefreshing = false
            LoadingDialog.hide()
        }
    }

    private fun setupUI() {
        with(rootView) {

            btnSource.setOnClickListener {
                isSelectingSource = true
                openCurrencySelection()
            }
            btnTarget.setOnClickListener {
                isSelectingSource = false
                openCurrencySelection()
            }

            etValue.setOnKeyListener { _, _, keyEvent ->
                if (keyEvent.action == KeyEvent.ACTION_UP && keyEvent.keyCode == KeyEvent.KEYCODE_ENTER) {
                    val inputValue = etValue.text.toString()
                    value = if (inputValue.isNullOrBlank()) -1.0 else inputValue.toDouble()
                    calculateQuotation()
                }
                false
            }
        }
    }

    private fun calculateQuotation() {
        if (sourceCurrency != null && targetCurrency != null && value != -1.0) {
            viewModel.convert(sourceCurrency!!.symbol, targetCurrency!!.symbol).observe(viewLifecycleOwner, {
                if (it.isSuccess) {
                    val v = (it.success!!.value * value).format(2)
                    rootView.etQuotation.setText(v)
                } else {
                    it.failure?.let {exc -> handleFailure(exc)}
                }
            })
        } else handleInputError()

    }

    private fun disableElements() {
        enableElements(false)
    }

    private fun enableElements(enable: Boolean = true) {
        rootView.btnSource.isEnabled = enable
        rootView.btnTarget.isEnabled = enable
        rootView.etQuotation.isEnabled = enable
        rootView.etValue.isEnabled = enable
    }

    private fun handleInputError() {
        if (value == -1.0) {
            etQuotation.setText("")
            return
        }

        when {
            sourceCurrency == null -> showToast(R.string.select_source)
            targetCurrency == null -> showToast(R.string.select_target)
            else -> showToast(R.string.select_currencies)
        }
    }

    private fun handleFailure(exception: Exception) {
        disableElements()

        when(exception) {
            is UnreachableNetworkException -> showToast(R.string.not_internet)
            is NetworkCallException -> showToast(R.string.service_error)
            else -> showToast(R.string.default_error)
        }
    }

    private fun showToast(id: Int) {
        Toast.makeText(requireContext(), id, Toast.LENGTH_LONG).show()
    }


    private fun openCurrencySelection() {
        SelectionItemDialog(currencies).apply {
            interactionListener = ::onItemSelected
        }.show(parentFragmentManager, "TAG")
    }

    private fun onItemSelected(currency: Currency) {
        if (isSelectingSource) {
            btnSource.text = currency.symbol
            sourceCurrency = currency
        } else {
            btnTarget.text = currency.symbol
            targetCurrency = currency
        }
        calculateQuotation()
    }
}

fun Double.format(digits: Int) = "%.${digits}f".format(this)
