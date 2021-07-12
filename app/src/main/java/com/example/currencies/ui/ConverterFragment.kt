package com.example.currencies.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.example.currencies.R
import java.text.DecimalFormat
import java.text.NumberFormat
import java.util.*

class ConverterFragment : Fragment() {

    companion object {
        fun newInstance() = ConverterFragment()
    }

    private lateinit var mCurrencyOrigin: EditText
    private lateinit var mCurrencyFinal: TextView
    private lateinit var mButtonCurrencyOrigin: Button
    private lateinit var mButtonCurrencyFinal: Button

    private val mConverterViewModel: ConverterViewModel by activityViewModels()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, s: Bundle?): View {
        val root = inflater.inflate(R.layout.converter_fragment, container, false)

        mCurrencyOrigin = root.findViewById(R.id.baseValue)

        mButtonCurrencyOrigin = root.findViewById(R.id.button_currency_origin)
        mButtonCurrencyFinal = root.findViewById(R.id.button_currency_final)

        mCurrencyFinal = root.findViewById(R.id.val_converted)

        if (mConverterViewModel.currencyOrigin.value != null) {
            mButtonCurrencyOrigin.setText(mConverterViewModel.currencyOrigin.value).toString()
        }

        if (mConverterViewModel.currencyFinal.value != null) {
            mButtonCurrencyFinal.setText(mConverterViewModel.currencyFinal.value).toString()
        }

        mCurrencyOrigin.addTextChangedListener {
            calculateConverter()
        }

        mButtonCurrencyOrigin.setOnClickListener {
            mConverterViewModel.defineOriginOrFinal(getString(R.string.currency_Origin))
            openFragmentList()
        }

        mButtonCurrencyFinal.setOnClickListener {
            mConverterViewModel.defineOriginOrFinal(getString(R.string.currency_Final))
            openFragmentList()
        }
        observer()
        return root
    }

    private fun openFragmentList() {
        val transaction = activity?.supportFragmentManager?.beginTransaction()
        if (transaction != null) {
            transaction.replace(R.id.container, ListCurrenciesFragment.newInstance())
            transaction.addToBackStack(null)
            transaction.commit()
        }
    }

    private fun observer() {
        mConverterViewModel.loadRatesLocal.observe(viewLifecycleOwner, androidx.lifecycle.Observer {
            if (!it) {
                mConverterViewModel.dialogMessage(getString(R.string.no_values), context)
            }
        })
    }

    private fun calculateConverter() {

        var currencyOrigin: Double = 0.0
        var currencyFinal: Double = 0.0
        val dec = DecimalFormat("#0.00000000000000")
        val local = Locale("pt", "BR")
        val nf = NumberFormat.getInstance(local)
        val currency: Currency = Currency.getInstance(local)
        nf.minimumFractionDigits = currency.defaultFractionDigits

        if (mConverterViewModel.priceOrigin.value != null && mConverterViewModel.priceOrigin.value!!.toDouble() != 0.00) {
            val currencyOriginBase = (mConverterViewModel.priceOrigin.value)?.toDouble()
            currencyOrigin = 1 / currencyOriginBase!!
        }
        if (mConverterViewModel.priceFinal.value != null && mConverterViewModel.priceFinal.value!!.toDouble() != 0.00) {
            val currencyFinalBase = (mConverterViewModel.priceFinal.value)?.toDouble()
            currencyFinal = 1 / currencyFinalBase!!
        }

        if (currencyFinal != 0.0 && currencyOrigin != 0.0) {
            val converterCurrency = (currencyOrigin / currencyFinal)

            if (mCurrencyOrigin.text.toString() != "") {
                val valOrigin = mCurrencyOrigin.text.toString()
                val finalConverter: Float = valOrigin.toFloat() * converterCurrency.toFloat()
                val mask = finalConverter.toInt()
                if (mask <= 0) {
                    val final = dec.format(finalConverter)
                    mCurrencyFinal.text = "$ $final"
                } else {
                    val final = nf.format(finalConverter)
                    mCurrencyFinal.text = "$ $final"
                }
            }
        }
    }
}
