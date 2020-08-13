package com.example.cassiomobilechallenge

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.example.cassiomobilechallenge.repositories.CurrencyRepository
import com.example.cassiomobilechallenge.ui.fragments.MainFragment
import com.example.cassiomobilechallenge.viewmodelfactories.MainViewModelFactory
import com.example.cassiomobilechallenge.viewmodels.MainViewModel

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: MainViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)

        val repository = CurrencyRepository()
        val factory = MainViewModelFactory(repository, this.application)
        viewModel = ViewModelProviders.of(this, factory).get(MainViewModel::class.java)

        setupData()
    }

    fun setupData() {
        viewModel.getCurrencies()
        getCurrencies()
        caseError()
    }

    fun getCurrencies() {
        viewModel.currencies.observe(this, Observer { currencies ->
            if (currencies != null) {
                viewModel.currencies.removeObservers(this)
                if (currencies.success && !currencies.currencies.isEmpty()) {
                    viewModel.getCountryCurrencies(currencies.currencies)
                    viewModel.getAllConversions()
                    getAllConversions()
                    Toast.makeText(this, "Dados de moedas obtidos com sucesso", Toast.LENGTH_LONG).show()
                } else {
                    viewModel.getCurrencies()
                    Toast.makeText(this, "Sem dados de moedas", Toast.LENGTH_SHORT).show()
                }
            }
        })
    }

    fun getAllConversions() {
        viewModel.allConversions.observe(this, Observer { conversions ->
            if (conversions != null) {
                viewModel.allConversions.removeObservers(this)
                if (conversions.success && !conversions.quotes.isEmpty()) {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.container, MainFragment.newInstance())
                        .commitNow()
                    Toast.makeText(this, "Dados para conversão obtidos com sucesso", Toast.LENGTH_LONG).show()
                } else {
                    viewModel.getAllConversions()
                    Toast.makeText(this, "Sem dados de conversão", Toast.LENGTH_SHORT).show()
                }
            }
        })
    }

    fun caseError() {
        viewModel.errorMessage.observe(this, Observer { error ->
            if (error != null) {
                viewModel.errorMessage.removeObservers(this)
                Toast.makeText(this, error, Toast.LENGTH_LONG).show()
            }
        })
    }

}