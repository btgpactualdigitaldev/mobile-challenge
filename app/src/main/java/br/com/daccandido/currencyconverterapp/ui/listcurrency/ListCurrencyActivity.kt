package br.com.daccandido.currencyconverterapp.ui.listcurrency

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.SearchView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.database.CurrencyDAO
import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.data.model.KEY_CURRENCIES
import br.com.daccandido.currencyconverterapp.data.model.KEY_SEARCH_CODE
import br.com.daccandido.currencyconverterapp.data.model.KEY_SEARCH_NAME
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseActivity
import io.realm.OrderedRealmCollection
import io.realm.RealmResults
import kotlinx.android.synthetic.main.activyity_list_currencies.*


class ListCurrencyActivity: BaseActivity(), ClickItemList {

    private lateinit var  viewModel: ListCurrentViewModel
    private lateinit var list: RealmResults<Currency>
    private lateinit var adapter: ListCurrencyAdapter
    private lateinit var mSearchView: SearchView

    private var currentOrder = KEY_SEARCH_NAME


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activyity_list_currencies)

        viewModel = ListCurrentViewModel
            .ViewModelFactory(CurrencyData(), CurrencyDAO())
            .create(ListCurrentViewModel::class.java)

        setObserve()
        getList(currentOrder)
        setUpToolbar()

    }

    override fun onClick(currency: Currency) {
        val intentResult = Intent()
        intentResult.putExtra(KEY_CURRENCIES, currency)
        setResult(Activity.RESULT_OK, intentResult)
        finish()
    }


    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_list, menu)
        val item = menu!!.findItem(R.id.search)
        mSearchView = (item.actionView as SearchView)
        initQueryTextListener()

        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> {
                onBackPressed()
                return true
            }
            R.id.order_code -> {
                currentOrder = KEY_SEARCH_CODE
                oderList()
            }
            R.id.order_name ->{
                currentOrder = KEY_SEARCH_NAME
                oderList()
            }
        }
        return super.onOptionsItemSelected(item)
    }

    private fun setUpToolbar () {
        toolbar?.let {
            setSupportActionBar(it)
            supportActionBar?.let { actionBar ->
                actionBar.setHomeButtonEnabled(true)
                actionBar.setDisplayHomeAsUpEnabled(true)
                title = getString(R.string.namelist)
            }
        }
    }

    private fun getList (sort:String) {
        list = viewModel.getListLocal(sort)
        if (list.isEmpty()) {
            viewModel.getList()
        } else {
            setUpRecyclerView()
        }
    }

    private fun setObserve() {
        viewModel.listCurrency.observe(this, Observer {
            if (it.currencies.isEmpty()) {
                progressBar3.visibility = View.GONE
                rvList.visibility = View.GONE
                tvError.text = getString(R.string.error_not_exchange_rates)
            } else {
                getList(currentOrder)
            }
        })

        viewModel.error.observe(this, Observer {
            progressBar3.visibility = View.GONE
            rvList.visibility = View.GONE
            tvError.text = getString(it)
        })

        viewModel.isLoading.observe(this, Observer {
            if (it) {
                progressBar3.visibility = View.VISIBLE
                rvList.visibility = View.GONE
            } else {
                progressBar3.visibility = View.GONE
                rvList.visibility = View.VISIBLE
            }
        })
    }

    private fun setUpRecyclerView () {
        adapter = ListCurrencyAdapter(list as OrderedRealmCollection<Currency>, this, this)
        rvList.layoutManager = LinearLayoutManager(this)
        rvList.adapter = adapter
        rvList.itemAnimator = DefaultItemAnimator()
    }

    private fun initQueryTextListener() {
        if(this::mSearchView.isInitialized) {
            mSearchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener{
                override fun onQueryTextSubmit(text: String?): Boolean {
                    text?.let {
                        list = viewModel.searchItem(currentOrder, it)
                        searchList()
                    }
                    return false
                }

                override fun onQueryTextChange(text: String?): Boolean {
                    text?.let {
                        list = viewModel.searchItem(currentOrder, it)
                        searchList()
                    }
                    return false
                }
            })
        }
    }

    private fun searchList () {
        if (list.isEmpty()) {
            progressBar3.visibility = View.GONE
            rvList.visibility = View.GONE
            tvError.visibility = View.VISIBLE
            tvError.text = getString(R.string.not_found)
        } else {
            progressBar3.visibility = View.GONE
            rvList.visibility = View.VISIBLE
            tvError.visibility = View.GONE
            adapter.setList(list as OrderedRealmCollection<Currency>)
        }
    }

    private fun oderList () {
        adapter.sortList(currentOrder)
    }
}