package com.a.coinmaster.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.LinearLayoutManager
import com.a.coinmaster.MainApplication
import com.a.coinmaster.R
import com.a.coinmaster.extension.changeVisibility
import com.a.coinmaster.model.StateError
import com.a.coinmaster.model.StateLoading
import com.a.coinmaster.model.StateResponse
import com.a.coinmaster.model.StateSuccess
import com.a.coinmaster.model.vo.CurrenciesListVO
import com.a.coinmaster.view.adapter.CoinListAdapter
import com.a.coinmaster.view.adapter.OnItemSelected
import com.a.coinmaster.viewmodel.CoinListViewModel
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_coin_list.*
import javax.inject.Inject

class CoinListActivity : AppCompatActivity(), OnItemSelected {

    @Inject
    lateinit var viewModel: CoinListViewModel

    private val adapter: CoinListAdapter by lazy {
        CoinListAdapter(onItemSelected = this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_coin_list)
        MainApplication.getComponent()?.inject(this)
        setupObservable()
        setupClickListener()
    }

    override fun onResume() {
        super.onResume()
        fetchCoinList()
    }

    private fun fetchCoinList() {
        viewModel.fetchCurrenciesList()
    }

    private fun setupClickListener() {
        ibBack.setOnClickListener {
            setResult(Activity.RESULT_CANCELED)
            finish()
        }
    }

    private fun setupObservable() {
        viewModel
            .currenciesListLiveData
            .observe({ lifecycle }, { state ->
                handleState(state)
            })
    }

    private fun handleState(state: StateResponse<CurrenciesListVO>) {
        enableLoading(false)
        when (state) {
            is StateLoading -> enableLoading(true)
            is StateSuccess -> setupList(state.data)
            is StateError -> showError()
        }
    }

    private fun showError() {
        val parentLayout = findViewById<View>(android.R.id.content)
        Snackbar
            .make(parentLayout, getString(R.string.generic_error), Snackbar.LENGTH_LONG)
            .setAction(getString(R.string.try_again)) {
                fetchCoinList()
            }
            .setActionTextColor(ContextCompat.getColor(this, android.R.color.white))
            .show()
    }

    private fun setupList(coinList: CurrenciesListVO) {
        if (rvCoins.adapter == null) {
            setupRecyclerView()
        }
        resetList(coinList)
    }

    private fun setupRecyclerView() {
        rvCoins.adapter = adapter
        rvCoins.layoutManager = LinearLayoutManager(this)
    }

    private fun resetList(coinList: CurrenciesListVO) {
        adapter.coinList.clear()
        adapter.coinList.addAll(coinList.currencies.toList())
        adapter.notifyDataSetChanged()
    }

    private fun enableLoading(isEnable: Boolean) {
        flLoading.changeVisibility(isEnable)
    }

    override fun onSelected(item: Pair<String, String>) {
        Intent()
            .putExtra(ITEM_SELECTED_BUNDLE, item)
            .let {
                setResult(Activity.RESULT_OK, it)
                finish()
            }
    }

    companion object {
        const val ITEM_SELECTED_BUNDLE = "ITEM_SELECTED_BUNDLE"
    }
}