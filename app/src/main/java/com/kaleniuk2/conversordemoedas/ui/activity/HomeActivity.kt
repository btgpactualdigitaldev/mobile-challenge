package com.kaleniuk2.conversordemoedas.ui.activity

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.EditText
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import com.kaleniuk2.conversordemoedas.R
import com.kaleniuk2.conversordemoedas.common.ui.BaseActivity
import com.kaleniuk2.conversordemoedas.common.ui.components.LoadingButton
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.extension.hideKeyboard
import com.kaleniuk2.conversordemoedas.extension.showText
import com.kaleniuk2.conversordemoedas.util.MoneyTextWatcher
import com.kaleniuk2.conversordemoedas.viewmodel.HomeViewModel
import kotlinx.android.synthetic.main.activity_main.*
import com.kaleniuk2.conversordemoedas.viewmodel.HomeViewModel.Interact.Convert

class HomeActivity : BaseActivity(), View.OnClickListener {
    private val btnCurrencyFrom by lazy { findViewById<LoadingButton>(R.id.btn_select_currency_from) }
    private val btnCurrencyTo by lazy { findViewById<LoadingButton>(R.id.btn_select_currency_to) }
    private val etSelectValue by lazy { findViewById<EditText>(R.id.et_select_value) }
    private val btnConvert by lazy { findViewById<LoadingButton>(R.id.btn_convert) }
    private val tvResult by lazy { findViewById<TextView>(R.id.tv_result) }

    private val viewModel = HomeViewModel()

    private var currentFrom = Currency("","")
    private var currentTo = Currency("","")

    companion object {
        private const val FROM = 1
        private const val TO = 2
        private const val BRL = "BRL"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setupListeners()
        setupToolbar(main_toolbar)
        setupObservers()
    }

    private fun setupListeners() {
        btnConvert.setOnClickListener(this)
        btnCurrencyTo.setOnClickListener(this)
        btnCurrencyFrom.setOnClickListener(this)
        etSelectValue.addTextChangedListener(MoneyTextWatcher(etSelectValue))

        etSelectValue.setOnEditorActionListener { _, _, _ ->
            convert()
            true
        }
    }

    private fun setupObservers() {
        viewModel.showError.observe(this, Observer {
            showText(it)
        })

        viewModel.showLoading.observe(this, Observer {
            btnConvert.showLoading(it)
        })

        viewModel.convertSuccess.observe(this, Observer {
            tvResult.text = it
        })
    }

    private fun openListCurrency(destination: Int) {
        startActivityForResult(Intent(this, ListCurrencyActivity::class.java), destination)
    }

    private fun convert() {
        hideKeyboard()
        viewModel.interact(Convert(currentFrom.abbreviation, currentTo.abbreviation, etSelectValue.text.toString()))
    }

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.btn_select_currency_from -> openListCurrency(FROM)
            R.id.btn_select_currency_to -> openListCurrency(TO)
            R.id.btn_convert -> convert()
        }
    }

    private fun checkIsBr() {
        if (currentFrom.abbreviation == BRL || currentTo.abbreviation == BRL)
            main_toolbar.background = ContextCompat.getDrawable(this, R.drawable.background_gradient_br)
        else
            main_toolbar.setBackgroundColor(ContextCompat.getColor(this, R.color.colorPrimary))
    }

    private fun getDataIntent(data: Intent): Currency {
        return data.extras?.get(ListCurrencyActivity.CURRENCY_SELECTED) as Currency
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    private fun invertOrder() {
        if(currentFrom.abbreviation.isNotEmpty() && currentTo.abbreviation.isNotEmpty()) {
            val tempFrom = currentFrom
            currentFrom = currentTo
            currentTo = tempFrom

            btnCurrencyFrom.setTitle(currentFrom.name)
            btnCurrencyTo.setTitle(currentTo.name)
        }

    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.invert -> invertOrder()
        }

        return true
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            if (data != null && data.extras != null) {
                val currency = getDataIntent(data)
                when (requestCode) {
                    FROM -> {
                        btnCurrencyFrom.setTitle(currency.name)
                        currentFrom =  currency
                    }
                    TO -> {
                        btnCurrencyTo.setTitle(currency.name)
                        currentTo = currency
                    }
                }

                checkIsBr()
            }
        }
    }
}