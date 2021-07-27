package com.btg.conversormonetario.view.activity

import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import com.btg.conversormonetario.R
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.shared.observeNonNull
import com.btg.conversormonetario.view.adapter.ListCurrencyAdapter
import com.btg.conversormonetario.view.viewmodel.BaseViewModel.Companion.CURRENCY_KEY
import com.btg.conversormonetario.view.viewmodel.ChooseCurrencyViewModel
import com.btg.conversormonetario.view.watcher.SearchFieldCurrencyWatcher
import kotlinx.android.synthetic.main.activity_choose_currency.*

class ChooseCurrencyActivity : BaseActivity<ChooseCurrencyViewModel>() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_choose_currency)

        initObservers()
        initListeners()
    }

    private fun initListeners() {
        edtChooseCurrency.addTextChangedListener(SearchFieldCurrencyWatcher(viewModel) {
            setupAdapter(it)
        })
    }

    private fun initObservers() {
        viewModel.onViewModelInitiated()
        viewModel.chooseCurrencyTypeFromIntent(intent.extras?.getString(CURRENCY_KEY))

        viewModel.localCurrenciesSingleton.observeNonNull(this) {
            setupAdapter(it)
        }

        viewModel.currenciesFiltered.observeNonNull(this) {
            setupAdapter(it)
        }
    }

    fun orderList(v: View) {
        viewModel.prepareSpinnerOrderList()
    }

    fun back(v: View) {
        viewModel.goToConverterCurrency()
    }

    private fun setupAdapter(currencies: ArrayList<InfoCurrencyModel.DTO>) {
        val adapter = ListCurrencyAdapter(this, viewModel, currencies)
        adapter.updateListwithFilteredValues(currencies)
        rcvChooseCurrency.layoutManager =
            LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        rcvChooseCurrency.adapter = adapter
        adapter.positionCurrencyChoosed = {
            viewModel.updateCurrencyChoosedValue(it)
        }
    }
}