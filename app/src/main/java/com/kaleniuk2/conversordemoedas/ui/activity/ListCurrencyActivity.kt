package com.kaleniuk2.conversordemoedas.ui.activity

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.Menu
import android.view.MenuItem
import android.widget.EditText
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.kaleniuk2.conversordemoedas.R
import com.kaleniuk2.conversordemoedas.common.ui.BaseActivity
import com.kaleniuk2.conversordemoedas.common.ui.components.LoadingDialog
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.extension.showText
import com.kaleniuk2.conversordemoedas.ui.adapter.ListCurrencyAdapter
import com.kaleniuk2.conversordemoedas.viewmodel.ListCurrencyViewModel
import com.kaleniuk2.conversordemoedas.viewmodel.ListCurrencyViewModel.Interact.GetCurrencies
import com.kaleniuk2.conversordemoedas.viewmodel.ListCurrencyViewModel.Interact.SearchCurrency
import com.kaleniuk2.conversordemoedas.viewmodel.ListCurrencyViewModel.Interact.OrderCurrencies
import kotlinx.android.synthetic.main.activity_list_currency.*

class ListCurrencyActivity : BaseActivity() {

    companion object {
        const val CURRENCY_SELECTED = "CURRENCY_SELECTED"
    }

    private val recyclerCurrency by lazy { findViewById<RecyclerView>(R.id.recycler_currency) }
    private val etSearch by lazy { findViewById<EditText>(R.id.et_search_currency) }
    private val viewModel = ListCurrencyViewModel()
    private val loadingDialog = LoadingDialog()
    private lateinit var adapter: ListCurrencyAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_currency)
        setupToolbar(toolbar, true)
        setupObservers()
        setupRecyclerViewCurrency()
        setupTextWatcher()
    }

    private fun setupTextWatcher() {
        etSearch.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {}

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

            override fun onTextChanged(text: CharSequence?, start: Int, before: Int, count: Int) {
                viewModel.interact(SearchCurrency(text.toString()))
            }

        })
    }

    private fun setupObservers() {
        viewModel.apply {
            interact(GetCurrencies)
            showError.observe(this@ListCurrencyActivity, Observer {
                showText(it)
            })

            showLoading.observe(this@ListCurrencyActivity, Observer {
                showLoadingDialog(it)
            })

            showListCurrencies.observe(this@ListCurrencyActivity, Observer {
                updateRecycler(it)
            })
        }
    }

    private fun showLoadingDialog(show: Boolean) {
        if (show)
            loadingDialog.show(supportFragmentManager, null)
        else
            loadingDialog.dismiss()
    }

    private fun updateRecycler(listCurrency: List<Currency>) {
        adapter.listCurrency = listCurrency
    }

    private fun setupRecyclerViewCurrency() {
        adapter = ListCurrencyAdapter(listener = {
            val intent = Intent().putExtra(CURRENCY_SELECTED, it)
            setResult(RESULT_OK, intent)
            finish()
        })
        recyclerCurrency.adapter = adapter
        recyclerCurrency.layoutManager = LinearLayoutManager(this)
    }

    private fun orderCurrencies() {
        viewModel.interact(OrderCurrencies)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_list_currency, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when(item.itemId) {
            android.R.id.home -> finish()
            R.id.order -> orderCurrencies()
        }

        return true
    }

}