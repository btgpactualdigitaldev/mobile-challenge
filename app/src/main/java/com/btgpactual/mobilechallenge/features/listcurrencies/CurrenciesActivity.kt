package com.btgpactual.mobilechallenge.features.listcurrencies

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.domain.entity.Currency
import com.btgpactual.mobilechallenge.R
import com.btgpactual.mobilechallenge.databinding.ActivityCurrenciesBinding
import com.btgpactual.mobilechallenge.extensions.visible
import com.btgpactual.mobilechallenge.viewmodel.ViewState
import com.miguelcatalan.materialsearchview.MaterialSearchView
import kotlinx.android.synthetic.main.activity_currencies.*
import org.koin.android.ext.android.inject
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrenciesActivity : AppCompatActivity() {

    private val currenciesAdapter: CurrenciesAdapter by inject()
    private val viewModel: CurrencyListViewModel by viewModel()
    private lateinit var binding : ActivityCurrenciesBinding


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this,R.layout.activity_currencies)

        setupToolbar()
        setupRecyclerView()
        setupSearchView()
        setupObservable()

    }

    private fun setupToolbar(){
        binding.currenciesToolbar.setTitle(R.string.title_currencies)
        setSupportActionBar(binding.currenciesToolbar)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    private fun setupSearchView() {
        binding.searchView.setOnQueryTextListener(object : MaterialSearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(query: String?): Boolean {
                viewModel.search(query ?: "")
                return true
            }

            override fun onQueryTextChange(newText: String?): Boolean {return true}



        })

        binding.searchView.setOnSearchViewListener(object: MaterialSearchView.SearchViewListener{
            override fun onSearchViewClosed() {
                viewModel.clearSearch()
            }

            override fun onSearchViewShown() {}


        })
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when(item.itemId){
            android.R.id.home -> {
                onBackPressed()
                return true
            }
        }
        return super.onOptionsItemSelected(item)
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.menu_currencies,menu)
        val item = menu.findItem(R.id.action_search)
        binding.searchView.setMenuItem(item)
        return true
    }

    override fun onDestroy() {
        viewModel.currencyData.removeObservers(this)
        super.onDestroy()
    }

    private fun setupObservable() {
        viewModel.currencyData.observe(this, Observer {
            when(it){
                is ViewState.Success -> onSuccess(it.data)
                is ViewState.Failed -> onFailed(it.throwable)
                is ViewState.Loading -> setVisibilities(showProgressBar = true)
            }
        })
    }

    private fun setupRecyclerView() = with(binding.currencyRecyclerView) {
        currenciesAdapter.onCurrencyClickListener = object : CurrenciesAdapter.OnCurrencyClickListener{
            override fun onCurrencyClick(currency: Currency) {
                setResult(Activity.RESULT_OK,Intent().also { it.putExtra("currency",currency) })
                finish()
            }
        }

        layoutManager = LinearLayoutManager(context)
        adapter = currenciesAdapter

        setHasFixedSize(true)
        addItemDecoration(DividerItemDecoration(this@CurrenciesActivity,RecyclerView.VERTICAL))
    }


    private fun onSuccess(data: List<Currency>) {
        setVisibilities(showList = true)
        currenciesAdapter.setData(currencies = data)
    }


    private fun onFailed(throwable: Throwable) {
        messageTextView.text = throwable.message
        setVisibilities(showMessage = true)
    }


    private fun setVisibilities(
        showProgressBar: Boolean = false,
        showList: Boolean = false,
        showMessage: Boolean = false
    ) {
        binding.progressBar.visible(showProgressBar)
        binding.currencyRecyclerView.visible(showList)
        binding.messageTextView.visible(showMessage)
    }

}
