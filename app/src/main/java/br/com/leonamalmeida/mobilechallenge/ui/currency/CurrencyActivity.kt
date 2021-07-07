package br.com.leonamalmeida.mobilechallenge.ui.currency

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuInflater
import android.view.MenuItem
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.doAfterTextChanged
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.util.EXTRA_CURRENCY
import br.com.leonamalmeida.mobilechallenge.util.haveNetwork
import br.com.leonamalmeida.mobilechallenge.util.snack
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_currency.*

@AndroidEntryPoint
class CurrencyActivity : AppCompatActivity() {

    private val viewModel: CurrencyViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency)
        setToolbar()
        setAdapter()
        setListeners()
        setObservers()
        viewModel.getCurrencies()
    }

    private fun setObservers() {
        viewModel.run {
            currencies.observe(this@CurrencyActivity, Observer {
                (currencyRv.adapter as CurrencyAdapter).currencies = it
            })

            error.observe(this@CurrencyActivity, Observer { displayError(it) })

            loading.observe(this@CurrencyActivity, Observer { currencySr.isRefreshing = it })

            onSelectedCurrencyEvent.observe(this@CurrencyActivity, Observer {
                setResult(Activity.RESULT_OK, Intent().apply { putExtra(EXTRA_CURRENCY, it.code) })
                finish()
            })
        }
    }

    private fun displayError(msgRes: Int) {
        snack(
            currencyRoot,
            if (haveNetwork()) msgRes else R.string.no_connection_error,
            R.string.action_reload
        ) { viewModel.getCurrencies() }
    }

    private fun setToolbar() {
        setSupportActionBar(toolbar)
        title = getString(R.string.activity_currency_title)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        MenuInflater(this).inflate(R.menu.currency_menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> onBackPressed()
            R.id.orderByCode -> viewModel.orderBy(searchTv.text.toString(), false)
            R.id.orderByName -> viewModel.orderBy(searchTv.text.toString(), true)
        }
        return super.onOptionsItemSelected(item)
    }

    private fun setListeners() {
        searchIb.setOnClickListener { viewModel.searchCurrency(searchTv.text.toString()) }
        searchTv.doAfterTextChanged { viewModel.searchCurrency(searchTv.text.toString()) }
        currencySr.setOnRefreshListener { viewModel.getCurrencies() }
    }

    private fun setAdapter() {
        currencyRv.adapter = CurrencyAdapter { viewModel.onSelectedCurrency(it) }
        currencyRv.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))
    }
}