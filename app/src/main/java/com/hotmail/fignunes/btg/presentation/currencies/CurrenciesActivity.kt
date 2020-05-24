package com.hotmail.fignunes.btg.presentation.currencies

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.SearchView
import androidx.databinding.DataBindingUtil
import com.hotmail.fignunes.btg.R
import com.hotmail.fignunes.btg.common.BaseActivity
import com.hotmail.fignunes.btg.common.ToastCustom
import com.hotmail.fignunes.btg.databinding.ActivityCurrenciesBinding
import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.presentation.currencies.adapter.CurrenciesAdapter
import com.hotmail.fignunes.btg.presentation.quotedollar.QuoteDollarActivity
import kotlinx.android.synthetic.main.activity_currencies.*
import org.koin.android.ext.android.inject
import org.koin.core.parameter.parametersOf

class CurrenciesActivity : BaseActivity(), CurrenciesContract, CurrenciesAdapter.ClickCurrency {

    private val presenter: CurrenciesPresenter by inject{ parametersOf(this) }
    private lateinit var binding : ActivityCurrenciesBinding

    private lateinit var adapter: CurrenciesAdapter
    private lateinit var currencies: MutableList<Currency>
    private var chooseCurrency: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_currencies)
        binding.presenter = presenter
        backButton()

        chooseCurrency = intent.getStringExtra(QuoteDollarActivity.CHOOSE_CURRENCY)
        presenter.onCreate(chooseCurrency)
    }

    override fun initializeAdapter(currencies: List<Currency>) {
        if(currencies.size == 0) currenciesChooseCurrency.text = resources.getString(R.string.no_coins_found)
        this.currencies = currencies as MutableList
        adapter = CurrenciesAdapter(this, currencies, this)
        recyclerviewCurrencies.adapter = adapter
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.menu_currencies, menu)
        val searchItem = menu.findItem(R.id.menu_toolbar_search)
        val searchView = searchItem.actionView as SearchView
        searchView.queryHint = resources.getString(R.string.insert_text)

        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {

            override fun onQueryTextSubmit(query: String): Boolean {
                searchView.setQuery("", false)
                searchView.setIconified(true)
                return false
            }

            override fun onQueryTextChange(newText: String): Boolean {
                newText.let {
                    if (it.length > 0) {
                        for(i in 0 until currencies.size) {
                            if(currencies[i].id.toLowerCase().contentEquals(it.toLowerCase()) ||
                                currencies[i].description.toLowerCase().contains(it.toLowerCase()) ) {
                                recyclerviewCurrencies.layoutManager!!.scrollToPosition(i)
                                break                        }
                        }
                    }
                }
                return false
            }
        })
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> finish()
            R.id.menu_order_code -> {
                currencies.sortBy { currency -> currency.id }
                adapter.notifyDataSetChanged()
            }
            R.id.menu_order_descriptiont -> {
                currencies.sortBy { currency -> currency.description  }
                adapter.notifyDataSetChanged()
            }
        }
        return super.onOptionsItemSelected(item)
    }

    override fun click(currency: Currency) {
        val data = Intent()
        data.putExtra(QuoteDollarActivity.CHOOSE_CURRENCY, chooseCurrency)
        data.putExtra(QuoteDollarActivity.CURRENCY, currency)
        setResult(Activity.RESULT_OK, data)
        finish()
    }

    override fun message(error: Int) {
        ToastCustom.execute(this, resources.getString(error))
    }

    override fun onDestroy() {
        presenter.dispose()
        super.onDestroy()
    }
}