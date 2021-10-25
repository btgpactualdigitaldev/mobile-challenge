package com.leonardocruz.btgteste.ui.currencyList.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.SearchView
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import com.leonardocruz.btgteste.R
import com.leonardocruz.btgteste.databinding.ActivityCurrencyBinding
import com.leonardocruz.btgteste.model.Currencies
import com.leonardocruz.btgteste.repository.CurrencyRepository
import com.leonardocruz.btgteste.ui.currencyList.viewmodel.BtgViewModel
import com.leonardocruz.btgteste.ui.currencyList.adapter.CurrencyAdapter
import com.leonardocruz.util.Constants.CURRENCY_KEY
import com.leonardocruz.util.Constants.PREFERENCES_CURRENCY
import com.leonardocruz.util.Constants.PREFERENCES_RATES
import com.leonardocruz.util.Util
import com.leonardocruz.util.convertHashMapToList
import com.leonardocruz.util.testConnection
import kotlinx.android.synthetic.main.activity_currency.*
import org.koin.android.viewmodel.ext.android.viewModel
import org.koin.core.parameter.parametersOf

class CurrencyActivity : AppCompatActivity() {

    private val viewModel : BtgViewModel by viewModel{
        parametersOf(CurrencyRepository())
    }
    private lateinit var mAdapter : CurrencyAdapter
    private var listCurrency = mutableListOf<Currencies>()
    private lateinit var binding : ActivityCurrencyBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCurrencyBinding.inflate(layoutInflater)
        setContentView(binding.root)
        initView()
        readShared()
        initViewModelObservers()
        initSearchView()
    }

    private fun initSearchView() {
        search_currency.setOnQueryTextListener(object :SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(newString: String?): Boolean {
                mAdapter.updatList(viewModel.searchCurrencies(newString!!.toUpperCase(), listCurrency))
                return false
            }

            override fun onQueryTextChange(newString: String?): Boolean {
                mAdapter.updatList(viewModel.searchCurrencies(newString!!.toUpperCase(), listCurrency))
                return false
            }

        })
    }

    private fun initViewModelObservers() {
        viewModel.currencyData.observe(this, {
            listCurrency = convertHashMapToList(it).sortedBy { currencies -> currencies.initials } as MutableList<Currencies>
            mAdapter.updatList(listCurrency)
            Util.savePreferences(this, listCurrency, PREFERENCES_CURRENCY)
        })

        viewModel.currencyLiveData.observe(this, {
            val currenciesRate = convertHashMapToList(it)
            Util.savePreferences(this, currenciesRate, PREFERENCES_RATES)
        })

        viewModel.errorMessage.observe(this, {
            Toast.makeText(this, getString(R.string.generic_error), Toast.LENGTH_SHORT).show()
        })
    }

    private fun initView() {
        mAdapter = CurrencyAdapter(listCurrency) { currency -> clickCurrency(currency) }
        binding.rvCurrency.adapter = mAdapter
        binding.rvCurrency.layoutManager = LinearLayoutManager(this)
    }

    private fun clickCurrency(currency: Currencies) {
        intent.putExtra(CURRENCY_KEY, currency)
        setResult(RESULT_OK, intent)
        finish()
    }

    private fun readShared() {
        if(testConnection(this)){
            viewModel.getLive()
        } 
            val listPrefes = Util.readPrefs(this, PREFERENCES_CURRENCY)
            if (listPrefes.isNullOrEmpty()) {
                viewModel.getList()
            } else {
                listCurrency = listPrefes
                mAdapter.updatList(listCurrency)
            }
        }

    override fun onBackPressed() {
        super.onBackPressed()
        finish()
    }
}
