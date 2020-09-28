package br.com.convertify.ui

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.convertify.R
import br.com.convertify.api.DataState
import br.com.convertify.models.CurrencyItem
import br.com.convertify.models.QuotationItem
import br.com.convertify.util.ConverterUtils
import br.com.convertify.viewmodel.ConvertViewModel
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.convert_fragment.*


class ConvertFragment : Fragment() {

    companion object {
        fun newInstance() = ConvertFragment()
    }

    private lateinit var viewModel: ConvertViewModel
    private lateinit var currencyItems: Array<CurrencyItem>
    private lateinit var quotationItems: Array<QuotationItem>

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        currencyItems = arrayOf()
        quotationItems = arrayOf()
        return inflater.inflate(R.layout.convert_fragment, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        val currentActivity = activity!!
        viewModel = ViewModelProviders.of(currentActivity).get(ConvertViewModel::class.java)

        this.fetchConversionData()

        this.observeCurrencies()
        this.observeQuotations()

        this.observeOriginValue()
        this.observeTargetValue()
        this.observeConvertedValue()
        this.observeConvertError()

        this.handleOriginCurrencyClick()
        this.handleTargetCurrencyClick()
        this.handleValueToConvertChange()

    }

    private fun fetchConversionData() {
        this.viewModel.getCurrencies()
        this.viewModel.getQuotations()
    }

    private fun observeOriginValue() {
        this.viewModel.originCurrency.observe(viewLifecycleOwner, Observer {
            origin_currency_text.text = it.slug
        })
    }

    private fun observeTargetValue() {
        this.viewModel.targetCurrency.observe(viewLifecycleOwner, Observer {
            target_currency_text.text = it.slug
        })
    }

    private fun observeCurrencies() {
        this.viewModel.currencyLiveDataState.observe(this,
            Observer<DataState<Array<CurrencyItem>>> {
                val resource = it
                if (resource.isError) {
                    showCurrencyFetchError()
                } else {
                    toastMessage("Success")
                    currencyItems = resource.data!!
                }
            })
    }

    private fun observeQuotations() {
        this.viewModel.quotationLiveDataState.observe(this,
            Observer<DataState<Array<QuotationItem>>> {
                val resource = it
                if (resource.isError) {
                    this.showCurrencyFetchError()
                } else {
                    this.quotationItems = resource.data!!
                }
            })
    }

    private fun observeConvertedValue() {
        this.viewModel.convertedValue.observe(viewLifecycleOwner, Observer {
            if (it != null) {
                val decimalValue = ConverterUtils.formatStringToDecimal(it)
                val maskedConvertedValue =
                    ConverterUtils.maskToCurrency(decimalValue, viewModel.targetCurrency.value!!)
                converted_value_tv.text = maskedConvertedValue
                ifGoneShowValueView()
            }
        })
    }

    private fun observeConvertError() {
        this.viewModel.errorNotifier.observe(viewLifecycleOwner, Observer {
            showConversionError(it)
        })
    }


    private fun handleValueToConvertChange() {

        value_to_convert_input.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
                // do nothing
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                val value = s.toString()
                try {
                    if (value.isEmpty()) {
                        viewModel.setValueToConvert(0.0)
                        return
                    }
                    viewModel.setValueToConvert(s.toString().toDouble())
                } catch (e: Exception) {
                    // display error
                }
            }

            override fun afterTextChanged(s: Editable?) {

            }
        })
    }

    private fun handleOriginCurrencyClick() {
        origin_currency_button.setOnClickListener {

            if (!this.hasCurrencyItems()) {
                toastMessage(getString(R.string.no_currency_items_found))
                return@setOnClickListener
            }

            CurrencyPickerDialog.newInstance(currencyItems)
                .setOnItemClick { this.viewModel.setOriginCurrency(it) }
                .show(activity?.supportFragmentManager!!, "origin")
        }
    }

    private fun handleTargetCurrencyClick() {
        target_currency_button.setOnClickListener {
            if (!this.hasCurrencyItems()) {
                toastMessage(getString(R.string.no_currency_items_found))
                return@setOnClickListener
            }
            CurrencyPickerDialog.newInstance(currencyItems)
                .setOnItemClick { this.viewModel.setTargetCurrency(it) }
                .show(activity?.supportFragmentManager!!, "target")
        }
    }

    private fun toastMessage(message: String) {
        Toast.makeText(context, message, Toast.LENGTH_LONG).show()
    }

    private fun showCurrencyFetchError() {
        Snackbar.make(
            this.requireView(),
            R.string.fail_fetching_currency_data,
            Snackbar.LENGTH_INDEFINITE
        )
            .setAction(getString(R.string.try_again)) {
                this.fetchConversionData()
            }
            .show()
    }

    private fun showConversionError(conversionError: ConverterUtils.ConversionErrors) {
        val errorMessage: String = when (conversionError) {
            ConverterUtils.ConversionErrors.MISSING_VALUE_TO_CONVERT -> getString(R.string.missing_value_convert)
            ConverterUtils.ConversionErrors.MISSING_ORIGIN_CURRENCY -> getString(R.string.missing_origin_currency)
            ConverterUtils.ConversionErrors.MISSING_TARGET_CURRENCY -> getString(R.string.missing_target_currency)
            ConverterUtils.ConversionErrors.UNEXPECTED_ERROR -> getString(R.string.conversion_unexpected_error)
        }
        converted_value_tv.visibility = View.GONE
        fail_container.visibility = View.VISIBLE
        fail_text.text = errorMessage
    }

    private fun ifGoneShowValueView() {

        if (fail_container.isVisible) fail_container.visibility = View.GONE

        if (converted_value_tv.isVisible) return

        converted_value_tv.visibility = View.VISIBLE
    }

    fun hasCurrencyItems(): Boolean {
        return this.currencyItems.isNotEmpty()
    }

}
