package io.felipeandrade.currencylayertest.ui.currency.selection

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import io.felipeandrade.currencylayertest.R
import io.felipeandrade.currencylayertest.ui.DelayedTextChangeWatcher
import io.felipeandrade.currencylayertest.ui.setOnFinishTyping
import kotlinx.android.synthetic.main.activity_currency_selection.*
import org.koin.android.ext.android.inject
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrencySelectionActivity : AppCompatActivity() {

    companion object {
        const val SELECTED_CURRENCY_NAME = "SELECTED_CURRENCY_NAME"
        const val SELECTED_CURRENCY_SYMBOL = "SELECTED_CURRENCY_SYMBOL"
    }

    private val viewModel: CurrencySelectionViewModel by viewModel()
    private val adapter: CurrencyListAdapter by inject()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_selection)
        initRecyclerView()
        observeLiveData()
        initUiEvents()
    }

    private fun initRecyclerView() {
        rv_list.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        adapter.onItemClicked = { viewModel.itemClicked(it) }
        rv_list.adapter = adapter
    }

    private fun observeLiveData() {

        viewModel.characterList.observe(this, Observer {
            adapter.setData(it)
        })

        viewModel.searchQuery.observe(this, Observer {
            adapter.setFilter(it)
        })

        viewModel.selectedCurrency.observe(this, Observer {
            it?.let { data ->
                val intent = Intent()
                intent.putExtra(SELECTED_CURRENCY_NAME, data.name)
                intent.putExtra(SELECTED_CURRENCY_SYMBOL, data.symbol)
                setResult(Activity.RESULT_OK, intent)
                finish()
            }
        })
    }

    private fun initUiEvents() {
        et_search.setOnFinishTyping { viewModel.searchFieldUpdated(et_search.text.toString()) }
        et_search.addTextChangedListener(
            DelayedTextChangeWatcher {
                viewModel.searchFieldUpdated(et_search.text.toString())
            }
        )
    }
}