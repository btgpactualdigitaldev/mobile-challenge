package com.br.btgteste.presentation.list

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.Group
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.RecyclerView
import com.br.btgteste.R
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.infrastructure.isVisible
import com.br.btgteste.infrastructure.showSnack
import org.koin.android.viewmodel.ext.android.viewModel

class ListCurrencyActivity : AppCompatActivity(), ListCurrencyAdapter.OnListClickItem {

    private val rvCurrencies: RecyclerView by lazy { findViewById<RecyclerView>(R.id.CurrenciesRecyclerView) }
    private val svCurrencies: SearchView by lazy { findViewById<SearchView>(R.id.svFilterList) }
    private val pbList: ProgressBar by lazy { findViewById<ProgressBar>(R.id.pbList) }
    private val groupError: Group by lazy { findViewById<Group>(R.id.groupError) }

    private val viewModel: ListCurrencyViewModel by viewModel()
    private val adapter: ListCurrencyAdapter by lazy { ListCurrencyAdapter(this) }
    private val container: ConstraintLayout by lazy { findViewById<ConstraintLayout>(R.id.container) }

    private var listCurrencies: List<Currency> = mutableListOf()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_currency)
        viewModel.getCurrencies()
        observeCurrenciesResponse()
        setupListener()
        setupViews()
    }

    private fun setupViews() {
        val actionbar = supportActionBar
        actionbar?.setDisplayHomeAsUpEnabled(true)

        val divisor = DividerItemDecoration(this, LinearLayout.VERTICAL)
        ContextCompat.getDrawable(this, R.drawable.divisor_recycler_decoration)?.let {
            divisor.setDrawable(it)
        }
        rvCurrencies.addItemDecoration(divisor)
    }

    private fun updateList(query: String): Boolean {
        return if (listCurrencies.isNullOrEmpty()) {
            container.showSnack(getString(R.string.list_currencies_message_error_list_empty))
            return false
        } else {
            adapter.updateList(viewModel.performFiltering(query, listCurrencies))
        }
    }

    private fun setupListener() {
        svCurrencies.setOnQueryTextListener(object: SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(query: String): Boolean  = updateList(query)
            override fun onQueryTextChange(query: String): Boolean = updateList(query)
        })
        svCurrencies.setOnCloseListener { adapter.updateList(listCurrencies) }
    }

    private fun observeCurrenciesResponse() {
        viewModel.liveDataResponse.observe(this, Observer {
            pbList.isVisible(false)
            if (it is ApiResult.Success) {
                listCurrencies = it.data
                adapter.updateList(listCurrencies)
                svCurrencies.isIconified = false
                rvCurrencies.adapter = adapter
            } else if (it is ApiResult.Error) {
                groupError.isVisible(true)
                it.throwable.message?.let { message ->
                    container.showSnack(message)
                }
            }
        })
    }

    override fun onSupportNavigateUp(): Boolean {
        onBackPressed()
        return true
    }
    override fun onItemClick(currency: Currency) {
        setResult(Activity.RESULT_OK, Intent().also { it.putExtra(CURRENCY, currency) })
        finish()
    }

    companion object {
        const val CURRENCY = "currency"
    }
}
