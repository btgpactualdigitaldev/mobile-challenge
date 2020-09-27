package com.example.btgconvert.presentation.currencyList

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.SearchView
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.btgconvert.R
import com.example.btgconvert.presentation.base.BaseActivity
import kotlinx.android.synthetic.main.activity_currency_list.*
import kotlinx.android.synthetic.main.include_toolbar.*

class CurrencyListActivity : BaseActivity() {
    lateinit var viewModel: CurrencyListViewModel
    lateinit var adapter: CurrencyListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_list)

        setToolbar(toolbar, R.string.currencyListTitle)
        viewModel = ViewModelProviders.of(this).get(CurrencyListViewModel::class.java)
        observer()
        listener()
    }

    private fun observer() {
        viewModel.currencyListLiveData.observe(this, Observer{
            it?.let {
                with(listCurrency){
                    layoutManager = LinearLayoutManager(this@CurrencyListActivity, RecyclerView.VERTICAL, false)
                    setHasFixedSize(true)
                    adapter = CurrencyListAdapter(it){
                        val intent = intent
                        intent.putExtra("selectedCurrency", it.currencyKey)
                        setResult(Activity.RESULT_OK, intent)
                        finish()
                    }
                }
            }
        })
        viewModel.getCurrencyDb(this)
    }

    private fun listener() {
        searchItem.setOnQueryTextListener(object: SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(query: String?): Boolean {
                return true
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                if(newText!!.isNotEmpty()){
                    viewModel.getCurrencyDb(this@CurrencyListActivity, newText)
                }

                return true
            }

        })
    }

    companion object{
        fun getStartIntent(context: Context): Intent{
            return  Intent(context, CurrencyListActivity::class.java)
        }
    }


}