package br.com.andreldsr.btgcurrencyconverter.presenter.ui.currency

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.os.bundleOf
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.observe
import androidx.navigation.fragment.findNavController
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.presenter.extensions.navigateWithAnimations
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.CurrencyConversionViewModel
import kotlinx.android.synthetic.main.fragment_currency_conversion.*
import java.lang.NumberFormatException
import java.text.DecimalFormat
import java.text.NumberFormat

class ConversionFragment : Fragment() {
    val viewModel: CurrencyConversionViewModel by activityViewModels(){
        CurrencyConversionViewModel.ViewModelFactory()
    }
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_currency_conversion, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val nf: NumberFormat = DecimalFormat.getInstance()
        nf.maximumFractionDigits = 2

        val fromText = currency_conversion_from_value
        val toText = currency_conversion_to_value
        toText.isEnabled = false

        val fromLabel = currency_conversion_from_initials
        val toLabel = currency_conversion_to_initials


        viewModel.currencyToValue.observe(viewLifecycleOwner){
            toText.setText(nf.format(it))
        }
        viewModel.currencyFrom.observe(viewLifecycleOwner){
            fromLabel.text = it.initials
        }
        viewModel.currencyTo.observe(viewLifecycleOwner){
            toLabel.text = it.initials
        }
        viewModel.quote.observe(viewLifecycleOwner){
            val fromName = viewModel.currencyFrom.value?.name
            val toName = viewModel.currencyTo.value?.name
            val quoteValue = nf.format(viewModel.quote.value)
            fromText.text = null
            currency_conversion_quote_tv.text = getString(R.string.conversion_quote_rate, fromName, quoteValue, toName )
        }

        fromText.addTextChangedListener(object : TextWatcher {
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                val fValue = try{s.toString().toFloat()}catch (e: NumberFormatException){0f}
                viewModel.calculate(fValue)
            }
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun afterTextChanged(s: Editable?) {}

        })

        convert_swap_currencies_iv.setOnClickListener {
            viewModel.swapCurrencies()
        }

        currency_conversion_from_initials.setOnClickListener {
            val bundle = bundleOf("type" to "from")
            findNavController().navigateWithAnimations(R.id.action_ConversionFragment_to_ListFragment, bundle)
        }
        currency_conversion_to_initials.setOnClickListener {
            val bundle = bundleOf("type" to "to")
            findNavController().navigateWithAnimations(R.id.action_ConversionFragment_to_ListFragment, bundle)
        }
        viewModel.loadQuote()
    }

}