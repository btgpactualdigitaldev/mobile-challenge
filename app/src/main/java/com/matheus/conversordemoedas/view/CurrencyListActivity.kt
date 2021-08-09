package com.matheus.conversordemoedas.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.EditText
import android.widget.ListView
import android.widget.ProgressBar
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.matheus.conversordemoedas.R
import com.matheus.conversordemoedas.adapter.CurrencyListAdapter
import com.matheus.conversordemoedas.contract.CurrencyListContract
import com.matheus.conversordemoedas.model.CurrencyResult
import com.matheus.conversordemoedas.presenter.CurrencyListPresenter

class CurrencyListActivity : AppCompatActivity(), CurrencyListContract.View {

    var LVCurrencyList: ListView? = null
    var ETpesquisa: EditText? = null

    var presenter : CurrencyListPresenter = CurrencyListPresenter()
    internal lateinit var adapter: CurrencyListAdapter
    var progressBar: ProgressBar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencylist)

        setupView()

        presenter.setView(this)
        presenter.getList()
    }

    private fun setupView(){
        getSupportActionBar()!!.setDisplayHomeAsUpEnabled(true);
        getSupportActionBar()!!.setDisplayShowHomeEnabled(true);

        progressBar = findViewById<ProgressBar>(R.id.PBProgress)
        ETpesquisa = findViewById(R.id.ETpesquisa)
        LVCurrencyList = findViewById(R.id.LVCurrency)
        LVCurrencyList!!.setOnItemClickListener { _, view, position, _ ->
            val intent = Intent()
            intent.putExtra("CURRENCYCODE", adapter.getItem(position).code)
            intent.putExtra("CURRENCYDESCRIPTION", adapter.getItem(position).description)
            setResult(RESULT_OK, intent)
            finish()
        }

        ETpesquisa?.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
                val searchText: String = ETpesquisa?.text.toString()
                adapter.setSearchEnabled(true, searchText)
            }

            override fun afterTextChanged(s: Editable) {}
        })
    }

    override fun loadRecycler(list: ArrayList<CurrencyResult>) {
        adapter = CurrencyListAdapter(this, list)
        LVCurrencyList?.adapter = adapter
        adapter.notifyDataSetChanged()
    }

    override fun showProgress() {
        progressBar?.visibility = View.VISIBLE
    }

    override fun hideProgress() {
        progressBar?.visibility = View.GONE
    }

    override fun showMsgError(msg: String) {
        Toast.makeText(this, msg, Toast.LENGTH_LONG).show()
    }

    override fun getContext(): Context {
        return this
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.onDestroy()
    }

    override fun onSupportNavigateUp(): Boolean {
        onBackPressed()
        return true
    }


}