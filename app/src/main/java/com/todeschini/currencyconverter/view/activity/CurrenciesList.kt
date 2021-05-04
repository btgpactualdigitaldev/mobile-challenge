package com.todeschini.currencyconverter.view.activity

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.todeschini.currencyconverter.R
import com.todeschini.currencyconverter.data.repository.CurrenciesListRepository
import com.todeschini.currencyconverter.utils.Constants
import com.todeschini.currencyconverter.view.adapter.CurrenciesAdapter
import com.todeschini.currencyconverter.viewmodel.CurrenciesListViewModel
import kotlinx.android.synthetic.main.activity_currencies_list.*

class CurrenciesList : AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    lateinit var viewModel: CurrenciesListViewModel
    private val currenciesAdapter = CurrenciesAdapter(arrayListOf())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencies_list)

        val repository = CurrenciesListRepository()
        viewModel = CurrenciesListViewModel(repository)
        viewModel.getAllCurrencies()

        initViews()
        handleObservers()
        handleListener()
    }

    private fun initViews() {
        recyclerView = activity_currencies_list_recycler_view
        recyclerView.run {
            adapter = currenciesAdapter
            layoutManager = LinearLayoutManager(this@CurrenciesList, LinearLayoutManager.VERTICAL, false)
        }
    }

    private fun handleObservers() {
        viewModel.currencies.observe(this, Observer { currencies ->
            currencies?.let {
                currenciesAdapter.update(it)
            }
        })
    }

    private fun handleListener() {
        currenciesAdapter.onItemClick = { currency ->
            val intent = Intent()
            intent.putExtra(Constants.SELECTED_CURRENCY_OBJECT, currency)
            setResult(Activity.RESULT_OK, intent)
            finish()
        }
    }
}