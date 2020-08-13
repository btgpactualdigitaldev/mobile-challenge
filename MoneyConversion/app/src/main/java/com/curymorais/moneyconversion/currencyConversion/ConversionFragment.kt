package com.curymorais.moneyconversion.currencyConversion

import android.app.AlertDialog
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.View.OnFocusChangeListener
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import com.curymorais.moneyconversion.R
import com.curymorais.moneyconversion.currencyList.CurrencyListFragment
import com.curymorais.moneyconversion.data.local.Conversion
import kotlinx.android.synthetic.main.fragment_money_conversion.*
import java.math.BigDecimal


class ConversionFragment : Fragment() {

    private  var coinCode1 : String? = null
    private  var coinCode2 : String? = null
    private lateinit var viewModelFactory: ConversionViewModelFactory
    private lateinit var viewModel : ConversionFragmentViewModel

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        super.onCreateView(inflater, container, savedInstanceState)
        return inflater.inflate(R.layout.fragment_money_conversion, null)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initComponents()
    }

    fun initComponents() {
        var inputValue = if (Conversion.value != null) Conversion.value else ""
        button_from.setOnClickListener { setCoin(1) }
        button_to.setOnClickListener { setCoin(2) }
        button_convert.setOnClickListener{convert()}

        text_moneyFragment_value_from.text = Conversion.firstCurrency
        text_moneyFragment_value_to.text = Conversion.secondCurrency
        edit_moneyFragment_value.setText(inputValue.toString())

        edit_moneyFragment_value.onFocusChangeListener = OnFocusChangeListener { v, hasFocus ->
            if (!hasFocus) {
                Conversion.value = edit_moneyFragment_value.text.toString().toBigDecimal()
            }
        }
    }

    private fun convert() {
        if(Conversion.firstCurrency == null || Conversion.secondCurrency == null || edit_moneyFragment_value.text.toString().contentEquals("")) {
            showWarn()
            return
        } else {
            viewModelFactory = ConversionViewModelFactory(text_moneyFragment_value_from.text.toString())
            viewModel = ViewModelProviders.of(this, viewModelFactory).get(ConversionFragmentViewModel::class.java)
            viewModel.result.observe(viewLifecycleOwner, Observer { itens ->
                itens?.let {
                    calculate(it.quotes)
                }
            })
        }
    }

    private fun calculate(hash: HashMap<String, BigDecimal?>) {
        var quotes = hash.entries.iterator().next()
        var multiplier = quotes.value
        var valor = Conversion.value?.times(multiplier!!)
        text_moneyFragment_value_converted.text = "Valor em dolares: ${valor} "
    }

    private fun showWarn(){
        val dialogBuilder = AlertDialog.Builder(context)
        dialogBuilder.setMessage("Os valores precisam ser preenchidos!")
            .setCancelable(false)
            .setPositiveButton("Ok") { dialog, _ -> dialog.dismiss() }
        val alert = dialogBuilder.create()
        alert.setTitle(context?.getString(R.string.app_name))
        alert.show()
    }

    private fun setCoin(code : Int) {
        val myFragment: Fragment = CurrencyListFragment()
        var bundle = Bundle()
        bundle.putInt("code", code)
        myFragment.arguments = bundle
        activity?.supportFragmentManager?.beginTransaction()?.replace(R.id.container, myFragment)?.commit()
    }
}

