package com.br.mobilechallenge.view.currencies.activity

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toolbar
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.br.mobilechallenge.R
import com.br.mobilechallenge.model.MappingObject
import com.br.mobilechallenge.view.currencies.adapter.CurrenciesAdapter
import com.br.mobilechallenge.viewmodel.ViewModelCurrencyNames
import java.util.ArrayList


class CurrenciesActivity : AppCompatActivity() {

/*
*       TOOLBAR (BACKBUTTON)
*/

    val toolbarCurrenciesList by lazy { findViewById<Toolbar>(R.id.toolbar_currencies_list) }

    var currencyNameList = ArrayList<MappingObject>()

    private val viewModelCurrencyNames by lazy {
        ViewModelProviders.of(this).get(ViewModelCurrencyNames::class.java)
    }

    private val recyclerView by lazy { findViewById<RecyclerView>(R.id.currencies_reciclerview) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        initView()
        setRecyclerView()
        setViewModel()
        setBackButton()

    }

    private fun initView() = setContentView(R.layout.activity_currencies)

    private fun setRecyclerView() {

        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = CurrenciesAdapter(currencyNameList)
    }

    private fun setViewModel() {

        viewModelCurrencyNames.getCurrencyNames()
        viewModelCurrencyNames.currencyNames.observe(this, Observer {
            it?.let { itChar ->
                currencyNameList.addAll(itChar)
                recyclerView.adapter?.notifyDataSetChanged()


            }
        })
    }

    private fun setBackButton() {

        toolbarCurrenciesList.setNavigationOnClickListener{

            onBackPressed()
        }

    }

}