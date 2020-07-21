package com.btg.converter.presentation.view.currency.list

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.widget.PopupMenu
import androidx.appcompat.widget.SearchView
import androidx.databinding.DataBindingUtil
import com.btg.converter.R
import com.btg.converter.databinding.ActivityListCurrenciesBinding
import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.presentation.util.base.BaseActivity
import com.btg.converter.presentation.util.base.BaseViewModel
import com.btg.converter.presentation.util.extension.observe
import com.btg.converter.presentation.util.query.QueryChangesHelper
import com.btg.converter.presentation.view.currency.CurrencyFilterType
import org.koin.android.viewmodel.ext.android.viewModel

class ListCurrenciesActivity : BaseActivity() {

    override val baseViewModel: BaseViewModel get() = _viewModel
    private val _viewModel: ListCurrenciesViewModel by viewModel()

    private lateinit var binding: ActivityListCurrenciesBinding
    private lateinit var adapter: ListCurrenciesAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_list_currencies)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.title = getString(R.string.list_currency_title)
        setupAdapter()
    }

    override fun subscribeUi() {
        super.subscribeUi()
        _viewModel.currencyList.observe(this, ::onCurrencyListReceived)
        _viewModel.placeholder.observe(this) { binding.placeholderView.setPlaceholder(it) }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.list_currencies_menu, menu)
        setupSearchView(menu?.findItem(R.id.action_search))
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.filter_by_name -> {
                _viewModel.filterFullList(CurrencyFilterType.FilterByName)
                true
            }
            R.id.filter_by_code -> {
                _viewModel.filterFullList(CurrencyFilterType.FilterByCode)
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    private fun setupAdapter() {
        adapter = ListCurrenciesAdapter(::onCurrencySelected)
        binding.recyclerViewCurrencies.adapter = adapter
    }

    private fun onCurrencyListReceived(currencyList: List<Currency>?) {
        currencyList?.let(adapter::submitList)
    }

    private fun setupSearchView(searchItem: MenuItem?) {
        searchItem?.let {
            val searchView = it.actionView as SearchView
            searchView.setOnQueryTextListener(QueryChangesHelper(_viewModel::onQueryChanged))
            searchView.setOnSearchClickListener { showQueryPopUpMenu(searchView) }
        }
    }

    private fun showQueryPopUpMenu(searchView: SearchView) {
        val popUpMenu = PopupMenu(this, searchView)
        popUpMenu.inflate(R.menu.filter_currency_menu)
        popUpMenu.setOnMenuItemClickListener {
            when (it.itemId) {
                R.id.by_name -> {
                    _viewModel.queryFilterType = CurrencyFilterType.FilterByName
                    true
                }
                R.id.by_code -> {
                    _viewModel.queryFilterType = CurrencyFilterType.FilterByCode
                    true
                }
                else -> {
                    false
                }
            }
        }
        popUpMenu.show()
    }

    private fun onCurrencySelected(currency: Currency) {
        val intent = Intent()
        intent.putExtra(CURRENCY_EXTRA, currency)
        setResult(RESULT_OK, intent)
        finish()
    }

    companion object {
        const val CURRENCY_EXTRA = "CURRENCY_EXTRA"

        fun createIntent(context: Context) = Intent(context, ListCurrenciesActivity::class.java)
    }
}

