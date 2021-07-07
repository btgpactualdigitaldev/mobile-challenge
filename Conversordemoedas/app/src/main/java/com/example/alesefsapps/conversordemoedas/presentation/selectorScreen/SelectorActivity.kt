package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.lifecycle.Observer
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.support.v7.widget.SearchView
import android.view.Menu
import android.view.MenuItem
import android.view.inputmethod.EditorInfo
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.repository.CurrencyApiDataSource
import com.example.alesefsapps.conversordemoedas.data.repository.ValueLiveApiDataSource
import com.example.alesefsapps.conversordemoedas.presentation.base.BaseActivity
import com.example.alesefsapps.conversordemoedas.presentation.conversorScreen.ConversorActivity
import kotlinx.android.synthetic.main.activity_selector.*
import kotlinx.android.synthetic.main.include_toolbar.*


class SelectorActivity : BaseActivity() {

    private var adapterSelector: SelectorAdapter? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_selector)

        setupToolbar(toolbarMain, R.string.selector_title, true)

        val stateCurrency = intent.getStringExtra("STATE_CURRENCY")

        val viewModel: SelectorViewModel = SelectorViewModel.ViewModelFactory(ValueLiveApiDataSource(), CurrencyApiDataSource())
            .create(SelectorViewModel::class.java)

        viewModel.selectorLiveData.observe(this, Observer {
            it?.let {
                currencies -> with(recycle_currency) {
                adapterSelector = SelectorAdapter(currencies as ArrayList<Values>) {
                        currency -> val intent = ConversorActivity.getStartIntent(this@SelectorActivity, currency.code, currency.name, currency.value, stateCurrency, currency.timestamp)
                        this@SelectorActivity.startActivity(intent)
                    }
                adapter = adapterSelector
                layoutManager = LinearLayoutManager(this@SelectorActivity, RecyclerView.VERTICAL, false)
                setHasFixedSize(true)
                }
            }
        })

        viewModel.viewFlipperLiveData.observe(this, Observer {
            it?.let { viewFlipper ->
                currency_view_flipper.displayedChild = viewFlipper.first

                viewFlipper.second?.let { errorId ->
                    text_currency_error.text = getString(errorId)
                }
            }
        })

        viewModel.getValueLive()
    }


    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        val inflater = menuInflater
        inflater.inflate(R.menu.menu, menu)
        val searchItem: MenuItem = menu.findItem(R.id.action_search)
        val searchView: SearchView = searchItem.actionView as SearchView
        searchView.imeOptions = EditorInfo.IME_ACTION_DONE
        searchView.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                adapterSelector!!.getFilter()!!.filter(newText)
                return false
            }
        })
        return true
    }
}
