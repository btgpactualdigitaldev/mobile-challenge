package com.maskow.currencyconverter.ui.convert

import android.os.Bundle
import android.util.Log
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.maskow.currencyconverter.R
import com.maskow.currencyconverter.model.Currency
import com.maskow.currencyconverter.retrofit.Retrofit
import kotlinx.android.synthetic.main.fragment_convert.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ConvertFragment : Fragment(), AdapterView.OnItemSelectedListener {

    private lateinit var availableCurrencies: Array<String>
    private lateinit var currencySpinner: ArrayAdapter<String>
    private var firstCurrencySelected = ""
    private var secondCurrencySelected = ""
    private var convertValue: Double? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_convert, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        initViews()

        btn_convert.setOnClickListener {
            when {
                edit_currency_value.text.isEmpty() -> {
                    val toast =
                        Toast.makeText(context, R.string.convert_value_error, Toast.LENGTH_SHORT)
                    toast.setGravity(Gravity.CENTER, 0, 0)
                    toast.show()
                }
                firstCurrencySelected == secondCurrencySelected -> {
                    val toast =
                        Toast.makeText(context, R.string.convert_diff_error, Toast.LENGTH_SHORT)
                    toast.setGravity(Gravity.CENTER, 0, 0)
                    toast.show()
                }
                else -> {
                    convertValue = edit_currency_value.text.toString().toDouble()
                    convertValues()
                }
            }
        }
    }

    private fun initViews() {
        spinner_currency_first.onItemSelectedListener = this
        spinner_currency_second.onItemSelectedListener = this

        availableCurrencies = resources.getStringArray(R.array.currencies)
        currencySpinner = ArrayAdapter(
            requireContext(),
            R.layout.item_currency_spinner,
            availableCurrencies
        )

        spinner_currency_first.adapter = currencySpinner
        spinner_currency_second.adapter = currencySpinner
        spinner_currency_second.setSelection(1)
    }

    override fun onItemSelected(parent: AdapterView<*>, view: View?, position: Int, id: Long) {
        if (parent.id == R.id.spinner_currency_first) {
            firstCurrencySelected = availableCurrencies[position]
        } else if (parent.id == R.id.spinner_currency_second) {
            secondCurrencySelected = availableCurrencies[position]
        }
    }

    override fun onNothingSelected(parent: AdapterView<*>?) {}

    private fun convertValues() {
        progress_bar_convert.visibility = View.VISIBLE
        text_final_value_title.visibility = View.GONE
        text_final_value.visibility = View.GONE

        val call = Retrofit().currencyService().convert()
        call.enqueue(object : Callback<Currency?> {
            override fun onResponse(
                call: Call<Currency?>?,
                response: Response<Currency?>?
            ) {
                response?.body()?.let {
                    val currency: Currency = it
                    getCurrencyList(currency)
                }
            }

            override fun onFailure(call: Call<Currency?>?, t: Throwable?) {
                t?.message?.let {
                    Log.e("onFailure error", it)
                    Toast.makeText(context, "${t.message}", Toast.LENGTH_LONG).show()
                }
            }
        })
    }

    private fun getCurrencyList(currency: Currency) {
        val currenciesKeys = ArrayList<String>()
        val currenciesValues = ArrayList<String>()

        for (currenc in currency.quotes) {
            currenciesKeys.add(currenc.key)
            currenciesValues.add(currenc.value.toString())
        }

        val firstCurrencySelectedIndex = currenciesKeys.indexOfFirst { curr ->
            "USD${
                firstCurrencySelected.substring(
                    1,
                    4
                )
            }" == curr
        }
        val firstCurrencySelectedValue = currenciesValues[firstCurrencySelectedIndex]

        var convertedValueDolar = convertValue?.div(firstCurrencySelectedValue.toDouble())

        if (secondCurrencySelected.substring(1, 4) != "USD") {
            val secondCurrencySelectedIndex = currenciesKeys.indexOfFirst { curr ->
                "USD${
                    secondCurrencySelected.substring(
                        1,
                        4
                    )
                }" == curr
            }
            val secondCurrencySelectedValue = currenciesValues[secondCurrencySelectedIndex]
            convertedValueDolar = convertedValueDolar?.times(secondCurrencySelectedValue.toDouble())
        }

        text_final_value.text = String.format("%.4f", convertedValueDolar).toDouble().toString()

        text_final_value_title.visibility = View.VISIBLE
        text_final_value.visibility = View.VISIBLE
        progress_bar_convert.visibility = View.GONE
    }
}