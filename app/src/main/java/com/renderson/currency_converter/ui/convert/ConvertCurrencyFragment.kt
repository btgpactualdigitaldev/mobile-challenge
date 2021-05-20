package com.renderson.currency_converter.ui.convert

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import com.renderson.currency_converter.R
import com.renderson.currency_converter.databinding.FragmentConvertCurrencyBinding
import com.renderson.currency_converter.models.ConversionResult
import com.renderson.currency_converter.models.Quotes
import com.renderson.currency_converter.other.Status
import com.renderson.currency_converter.ui.base.BaseFragment
import com.renderson.currency_converter.ui.main.CurrencyViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class ConvertCurrencyFragment :
    BaseFragment<FragmentConvertCurrencyBinding, CurrencyViewModel>() {

    override val viewModel: CurrencyViewModel by viewModels()
    private lateinit var origin : String
    private lateinit var destination : String
    private lateinit var originCurrency : String
    private lateinit var destinationCurrency : String

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel.getAllQuotes()
        getAllQuotes()
        converter()
        initEditText()
    }

    private fun getAllQuotes() {
        viewModel.quotes.observe(viewLifecycleOwner, { result ->
            when (result.status) {
                Status.LOADING -> {}
                Status.SUCCESS -> {
                    result.data.let {
                        val list = viewModel.convertMapToArrayListQuotes(it)
                        initSpinner(list)
                    }
                }
                Status.ERROR -> {
                    toast(result.message.toString())
                }
            }
        })
    }

    private fun initSpinner(list: ArrayList<Quotes>) {
        val adapter = ArrayAdapter(
            requireContext(),
            R.layout.support_simple_spinner_dropdown_item,
            list
        )
        spinnerOrigin(adapter)
        spinnerDestination(adapter)
    }

    private fun spinnerOrigin(
        adapter: ArrayAdapter<Quotes>
    ) = with(binding) {
        ogCurrency.spOrigin.adapter = adapter

        ogCurrency.spOrigin.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                adapterView: AdapterView<*>?,
                p1: View?,
                position: Int,
                id: Long
            ) {
                val quotes: Quotes = adapterView?.selectedItem as Quotes
                origin = quotes.quote
                originCurrency = quotes.currency
            }

            override fun onNothingSelected(adapterView: AdapterView<*>?) {}
        }
    }

    private fun spinnerDestination(
        adapter: ArrayAdapter<Quotes>
    ) = with(binding) {
        destCurrency.spDestination.adapter = adapter

        destCurrency.spDestination.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                adapterView: AdapterView<*>?,
                p1: View?,
                position: Int,
                id: Long
            ) {
                val quotes: Quotes = adapterView?.selectedItem as Quotes
                destination = quotes.quote
                destinationCurrency = quotes.currency
            }

            override fun onNothingSelected(adapterView: AdapterView<*>?) {}
        }
    }

    private fun converter() = with(binding) {

        destCurrency.btnConverter.setOnClickListener {
            val amount = ogCurrency.amount.text.toString()
            if (amount == "") {
                ogCurrency.amountError.error = getString(R.string.label_insert_amount)
                return@setOnClickListener
            }
                val convert = viewModel.convertCurrency(origin.toDouble(), destination.toDouble(), amount.toDouble())
                val result = ConversionResult(
                    result = convert,
                    amount = amount,
                    originCurrency = originCurrency,
                    destinationCurrency = destinationCurrency
                )
                val bundle = Bundle().apply {
                    putSerializable("conversionResult", result)
                }
                findNavController().navigate(
                    R.id.action_covertCurrency_to_conversion_result, bundle
                )
        }
    }

    private fun initEditText() = with(binding) {
        ogCurrency.amount.addTextChangedListener(amountWatcher)
    }

    private val amountWatcher = object : TextWatcher {
        override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

        override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

        override fun afterTextChanged(s: Editable?) {
            validateAmount(s)
        }
    }

    private fun validateAmount(s: Editable?) = with(binding) {
        if (s != null && s.isNotEmpty())
            ogCurrency.amountError.error = null
        else
            ogCurrency.amountError.error = getString(R.string.label_insert_amount)
    }

    override fun getViewBinding(
        inflater: LayoutInflater,
        container: ViewGroup?
    ) = FragmentConvertCurrencyBinding.inflate(inflater, container, false)
}
