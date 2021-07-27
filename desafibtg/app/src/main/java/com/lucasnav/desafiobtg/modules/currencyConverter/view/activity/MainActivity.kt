package com.lucasnav.desafiobtg.modules.currencyConverter.view.activity

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.lucasnav.desafiobtg.R
import com.lucasnav.desafiobtg.modules.currencyConverter.database.CurrenciesDatabase
import com.lucasnav.desafiobtg.modules.currencyConverter.database.CurrenciesDatabaseFactory
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository
import com.lucasnav.desafiobtg.modules.currencyConverter.util.CURRENCY_INPUT
import com.lucasnav.desafiobtg.modules.currencyConverter.util.SELECT_I_HAVE_CURRENCY
import com.lucasnav.desafiobtg.modules.currencyConverter.util.SELECT_I_WANT_CURRENCY
import com.lucasnav.desafiobtg.modules.currencyConverter.util.showErrorToast
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.I_HAVE_FOCUSED
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.I_WANT_FOCUSED
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.QuotesViewmodel
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.viewmodelFactory.QuotesViewmodelFactory
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private lateinit var quotesViewmodel: QuotesViewmodel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        configClicks()

        setupViewmodel()

        subscribeUI()

        configTexts()

    }

    private fun configTexts() {
        editTextIHave.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(textValue: CharSequence?, p1: Int, p2: Int, p3: Int) {
                if (textValue?.isNotEmpty()!!) {
                    if (quotesViewmodel.currentFocused == I_HAVE_FOCUSED) {
                        quotesViewmodel.getQuotesAndCalculateAmount(
                            editTextIHave.text.toString(),
                            buttonCurrencyIHave.text.toString(),
                            buttonCurrencyIWant.text.toString()
                        )
                    }
                }
            }
        })

        editTextIwant.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(textValue: CharSequence?, p1: Int, p2: Int, p3: Int) {
                if (quotesViewmodel.currentFocused == I_WANT_FOCUSED) {
                    if (textValue?.isNotEmpty()!!) {
                        quotesViewmodel.getQuotesAndCalculateAmount(
                            editTextIwant.text.toString(),
                            buttonCurrencyIWant.text.toString(),
                            buttonCurrencyIHave.text.toString()
                        )
                    }
                }
            }
        })

        editTextIHave.setOnFocusChangeListener { _, hasFocus ->
            if (hasFocus) quotesViewmodel.currentFocused = I_HAVE_FOCUSED
        }

        editTextIwant.setOnFocusChangeListener { _, hasFocus ->
            if (hasFocus) quotesViewmodel.currentFocused = I_WANT_FOCUSED
        }
    }

    private fun setupViewmodel() {

        val currenciesDb = CurrenciesDatabaseFactory.create(this).currenciesDao()
        val quotesDb = CurrenciesDatabaseFactory.create(this).quotesDao()
        val db = CurrenciesDatabase(currenciesDb, quotesDb)

        quotesViewmodel = ViewModelProvider(
            this,
            QuotesViewmodelFactory(
                CurrencyInteractor(
                    CurrencyRepository(db, this)
                )
            )
        ).get(QuotesViewmodel::class.java)
    }

    private fun subscribeUI() {
        with(quotesViewmodel) {

            onloadStarted.observe(this@MainActivity, Observer {
                progressBarMain.visibility = View.VISIBLE
            })

            onLoadFinished.observe(this@MainActivity, Observer {
                progressBarMain.visibility = View.GONE
            })

            onError.observe(this@MainActivity, Observer { errorMessage ->
                when (errorMessage.code) {
                    404 -> {
                        showErrorToast(getString(R.string.clientError), applicationContext)
                    }
                    101 -> {
                        showErrorToast(getString(R.string.wrong_key), applicationContext)
                    }
                    104 -> {
                        showErrorToast(getString(R.string.montlhy_limit), applicationContext)
                    }
                    403 -> {
                        showErrorToast(getString(R.string.invalid_amount), applicationContext)
                    }
                    else -> {
                        showErrorToast(getString(R.string.not_possible_refresh), applicationContext)
                    }
                }
            })

            amount.observe(this@MainActivity, Observer { newAmount ->
                if (quotesViewmodel.currentFocused == I_HAVE_FOCUSED) {
                    editTextIwant.setText(newAmount)
                } else {
                    editTextIHave.setText(newAmount)
                }
            })
        }
    }

    private fun configClicks() {

        buttonCurrencyIWant.setOnClickListener {
            startActivityForResult(
                Intent(this@MainActivity, CurrenciesActivity::class.java),
                SELECT_I_WANT_CURRENCY
            )
        }

        buttonCurrencyIHave.setOnClickListener {
            startActivityForResult(
                Intent(this@MainActivity, CurrenciesActivity::class.java),
                SELECT_I_HAVE_CURRENCY
            )
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (requestCode) {
            SELECT_I_WANT_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    buttonCurrencyIWant.text = data?.getStringExtra(CURRENCY_INPUT)
                }
            }
            SELECT_I_HAVE_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    buttonCurrencyIHave.text = data?.getStringExtra(CURRENCY_INPUT)
                }
            }
        }
    }
}
