package com.desafio.btgpactual.ui.activities

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Spinner
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.desafio.btgpactual.R
import com.desafio.btgpactual.database.CoverterDatabase
import com.desafio.btgpactual.repositories.CurrencyRepository
import com.desafio.btgpactual.repositories.QuoteRepository
import com.desafio.btgpactual.shared.models.CurrencyModel
import com.desafio.btgpactual.ui.viewmodel.factory.MainFactory
import com.desafio.btgpactual.ui.viewmodel.MainViewModel
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(){

    private val viewModel by lazy {
        val currencyRepository = CurrencyRepository(CoverterDatabase.getInstance(this).getCurrencyDao())
        val quoteRepository = QuoteRepository(CoverterDatabase.getInstance(this).getQuoteDao())
        val factory =
            MainFactory(currencyRepository, quoteRepository)
        val viewModel = ViewModelProvider(this, factory)
        viewModel.get(MainViewModel::class.java)
    }

    var selectFrom: CurrencyModel? = null
    var selectTo: CurrencyModel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btn_currencies.setOnClickListener {
            val intent = Intent(this, AvailableCurrenciesActivity::class.java)
            startActivity(intent)
        }
    }


    override fun onResume() {
        super.onResume()
        fillSpinner()
        getQuotes()
    }

    private fun fillSpinner() {
        viewModel.callCurrencies()
            .observe(this, Observer {codes ->
                val spinnerFrom = findViewById<Spinner>(R.id.from_spinner)
                val spinnerTo = findViewById<Spinner>(R.id.to_spinner)
                val adapter = ArrayAdapter(this,
                    android.R.layout.simple_spinner_item,codes)
                spinnerFrom.adapter = adapter
                spinnerTo.adapter = adapter

                selectFrom = spinnerFrom.selectedItem as CurrencyModel
                selectTo = spinnerTo.selectedItem as CurrencyModel
            })
    }
    private fun getQuotes() {
        viewModel.callQuotes()
            .observe(this, Observer {quotes ->
                quotes.filter {
                    it.code == "USD$selectFrom"
                }[0]

            })
    }
}
