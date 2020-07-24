package com.desafio.btgpactual.ui.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Spinner
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.StaggeredGridLayoutManager
import com.desafio.btgpactual.R
import com.desafio.btgpactual.database.CoverterDatabase
import com.desafio.btgpactual.repositories.CurrencyRepository
import com.desafio.btgpactual.shared.models.CurrencyModel
import com.desafio.btgpactual.ui.adapter.CurrencyAdapter
import com.desafio.btgpactual.ui.viewmodel.AvailableCurrenciesViewModel
import com.desafio.btgpactual.ui.viewmodel.factory.AvailableCurrenciesFactory
import kotlinx.android.synthetic.main.activity_available_currencies.*

class AvailableCurrenciesActivity : AppCompatActivity() {

    private val viewModel by lazy {
        val repository = CurrencyRepository(CoverterDatabase.getInstance(this).getCurrencyDao())
        val factory =
            AvailableCurrenciesFactory(repository)
        val viewModel = ViewModelProvider(this, factory)
        viewModel.get(AvailableCurrenciesViewModel::class.java)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_available_currencies)
    }

    override fun onResume() {
        super.onResume()
        fillSpinner()
    }

    private fun fillSpinner() {
        viewModel.callCurrencies()
            .observe(this, Observer { it ->
                val recyclerView = currencies_rv
                recyclerView.adapter = CurrencyAdapter(it, this)
                val layoutManager = StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL)
                recyclerView.layoutManager = layoutManager
            })
    }
}
