package com.leonardo.convertcoins

import com.leonardo.convertcoins.config.RecyclerViewEmptyObserver
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.leonardo.convertcoins.adapters.CurrencyAdapter
import com.leonardo.convertcoins.databinding.ActivityCurrencyListBinding
import com.leonardo.convertcoins.models.Currency

class CurrencyList : AppCompatActivity() {
    // id of the selected button from main
    private var layoutId = 0

    private lateinit var linearLayoutManager: LinearLayoutManager
    private lateinit var currencyAdapter: CurrencyAdapter
    private lateinit var binding: ActivityCurrencyListBinding

    private val currenciesList = ArrayList<Currency>();

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCurrencyListBinding.inflate(layoutInflater)
        setContentView(binding.root)

        layoutId = intent.extras?.getInt("ID")!!
        val currencies = intent.extras?.getSerializable("CURRENCIES") as HashMap<String, String>

        currencies.forEach { currency ->
            currenciesList.add(Currency(currency.key, currency.value))
        }
        currenciesList.sort()
        initViewElements()
    }

    /**
     * Init view elements and set needed listeners
     */
    private fun initViewElements() {
        linearLayoutManager = LinearLayoutManager(this)
        currencyAdapter = CurrencyAdapter(currenciesList)

        // set layout manager and adapter
        binding.currencyRecyclerView.layoutManager = linearLayoutManager
        binding.currencyRecyclerView.adapter = currencyAdapter
        // config adapter to check if list is empty
        val rvEmptyObserver = RecyclerViewEmptyObserver(binding.currencyRecyclerView, binding.emptyCurrencyRecyclerView)
        currencyAdapter.registerAdapterDataObserver(rvEmptyObserver)

        configSearchView()
    }

    /**
     * Config search view setting the full horizontal bar clickable triggering adapter.filter
     * each time user types a new value on it
     */
    private fun configSearchView() {
        // allows all the search bar to be clickable
        binding.currencySearchView.setOnClickListener { binding.currencySearchView.isIconified = false }
        binding.currencySearchView.setOnQueryTextListener(object : androidx.appcompat.widget.SearchView.OnQueryTextListener {
            override fun onQueryTextChange(newText: String?): Boolean {
                currencyAdapter.filter.filter(newText)
                return false
            }

            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }
        })
    }

    /**
     * Triggered when user clicks on a list item saving needed values inside intent and return it
     * to main activity with setResult() and finish()
     * @param coin selected  as AUD
     */
    fun currencySelected(coin: String) {
        intent = Intent()
        intent.putExtra("ID", layoutId)
        intent.putExtra("CURRENCIES", coin)
        setResult(RESULT_OK, intent)
        finish()
    }
}
