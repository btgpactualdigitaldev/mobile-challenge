package com.todeschini.currencyconverter.view.activity

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import com.todeschini.currencyconverter.R
import com.todeschini.currencyconverter.data.repository.ConverterRepository
import com.todeschini.currencyconverter.model.CurrencyName
import com.todeschini.currencyconverter.utils.Constants
import com.todeschini.currencyconverter.viewmodel.ConverterViewModel

class ConverterActivity : AppCompatActivity() {

    private var firstCurrencyName: CurrencyName? = null
    private var secondCurrencyName: CurrencyName? = null
    private lateinit var viewModel: ConverterViewModel

    private var firstCurrencyTextView: TextView? = null
    private var secondCurrencyTextView: TextView? = null
    private var converterButton: Button? = null
    private var amountTextView: TextView? = null
    private var resultTextView: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_converter)

        val repository = ConverterRepository()
        viewModel = ConverterViewModel(repository)

        initViews()
        handleListeners()
        handleObservers()
    }

    private fun initViews() {
        firstCurrencyTextView = findViewById(R.id.activity_converter_first_currency_text_view)
        secondCurrencyTextView = findViewById(R.id.activity_converter_second_currency_text_view)
        converterButton = findViewById(R.id.activity_converter_convert_button)
        amountTextView = findViewById(R.id.activity_converter_amount_input_text)
        resultTextView = findViewById(R.id.activity_converter_amount_result_text_view)
    }

    private fun handleListeners() {

        firstCurrencyTextView?.setOnClickListener {
            val intent = Intent(this, CurrenciesList::class.java)
            startActivityForResult(intent, 1)
        }

        secondCurrencyTextView?.setOnClickListener {
            val intent = Intent(this, CurrenciesList::class.java)
            startActivityForResult(intent, 2)
        }

        converterButton?.setOnClickListener {
            val amount = amountTextView?.text.toString().toDouble()
            if (firstCurrencyName != null && secondCurrencyName != null && amount != null) {
                viewModel.getCurrentCurrency(firstCurrencyName!!, secondCurrencyName!!, amount)
            } else {
                Toast.makeText(
                    this,
                    "Por favor escolha as duas moedas para prosseguir.",
                    Toast.LENGTH_LONG
                )
                    .show()
            }
        }
    }

    private fun handleObservers() {
        viewModel.exchangedValue.observe(this, Observer { amount ->
            resultTextView?.visibility = View.VISIBLE
            resultTextView?.text = "O valor convertido é de $amount"
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                Constants.FIRST_CURRENCY_REQUEST_CODE -> {
                    firstCurrencyName = data?.getSerializableExtra(Constants.SELECTED_CURRENCY_OBJECT) as CurrencyName?

                }
                Constants.SECOND_CURRENCY_REQUEST_CODE -> {
                    secondCurrencyName = data?.getSerializableExtra(Constants.SELECTED_CURRENCY_OBJECT) as CurrencyName?
                }
            }
        }
    }
}