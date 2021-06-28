package br.com.gft.main

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.SearchView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.gft.R
import br.com.gft.main.iteractor.model.Currency
import kotlinx.android.synthetic.main.activity_pick_currency.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class PickCurrencyActivity : AppCompatActivity() {
    companion object {
        const val CURRENCY_PICKED = "currencyPicked"
    }

    private val viewModel: PickCurrencyViewModel by viewModel()

    private lateinit var currencyViewAdapter: CurrencyPickerAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pick_currency)

        makeActionBar()

        makeObservables()

        makeSwipeToRefresh()

    }

    private fun makeSwipeToRefresh() {
        swiperefresh.setOnRefreshListener {
            viewModel.fetch()
        }
    }

    private fun makeObservables() {
        viewModel.currencyListLiveData.observe(this, { currencyList ->
            makeListAdapterFromCurrencyList(currencyList)
        })

        viewModel.loadingLiveData.observe(this, { isLoading ->
            swiperefresh.isRefreshing = isLoading
        })

        viewModel.errorLiveData.observe(this,{error->
            if(error.isNullOrEmpty()){
                errorMessage.visibility = View.GONE
            }else{
                errorMessage.visibility = View.VISIBLE
                errorMessage.text = error
            }
        })
    }

    private fun makeListAdapterFromCurrencyList(
        currencyList: List<Currency>
    ) {
        currencyViewAdapter = CurrencyPickerAdapter(onCurrencyPicked(), currencyList)
        currencyRecyclerView.apply {
            layoutManager = LinearLayoutManager(this@PickCurrencyActivity)
            adapter = currencyViewAdapter
        }
    }

    private fun onCurrencyPicked(): (Currency) -> Unit {
        return { currency: Currency ->
            intent.putExtra(CURRENCY_PICKED, currency)
            setResult(RESULT_OK, intent)
            finish()
        }
    }

    private fun makeActionBar() {
        supportActionBar?.run {
            title = getString(R.string.pick_currency)
            setHomeButtonEnabled(true)
            setDisplayHomeAsUpEnabled(true)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        addListenerSearchView(menu)
        return true
    }

    private fun addListenerSearchView(menu: Menu?) {
        menuInflater.inflate(R.menu.picker_menu, menu)
        val menuItem = menu?.findItem(R.id.menu_searchView)
        val searchView = menuItem?.actionView as SearchView

        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                currencyViewAdapter.filter.filter(newText)
                return false
            }

        })
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.menu_searchView -> return true
            R.id.menu_orderByName -> currencyViewAdapter.sortByName()
            R.id.menu_orderByCode -> currencyViewAdapter.sortByCode()
            R.id.menu_refresh -> viewModel.fetch()

        }
        return super.onOptionsItemSelected(item)
    }

    override fun onSupportNavigateUp(): Boolean {
        onBackPressed()
        return true
    }
}