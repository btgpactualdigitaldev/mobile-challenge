package com.svm.btgmoneyconverter.view.list

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View.GONE
import android.view.View.VISIBLE
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.svm.btgmoneyconverter.R
import com.svm.btgmoneyconverter.utils.CURRENCY_ORDER
import com.svm.btgmoneyconverter.utils.CURRENCY_SELECTED
import com.svm.btgmoneyconverter.viewmodel.ListVM
import kotlinx.android.synthetic.main.activity_list.*


class ListActivity : AppCompatActivity() {

    var flow: Int = 0
    var viewModel: ListVM = ListVM()
    var adapter: CurrencyAdapter? = null
    lateinit var linearLayoutManager: LinearLayoutManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list)

        val bundle :Bundle ?=intent.extras
        flow = bundle?.getInt("flow")!!
        linearLayoutManager = LinearLayoutManager(this)
        rvCurrency.layoutManager = linearLayoutManager

        //Observers
        setObservables()

        //Listeners
        setListeners()

        viewModel.initContext(this)
        viewModel.getCurrencyList()
        viewModel.getQuoteList()
    }

    override fun onBackPressed() {
        super.onBackPressed() // optional depending on your needs
        val isNotLoading = !viewModel.loading.value!!

        if(isNotLoading){
            finish()
        }
    }

    private fun setObservables(){
        viewModel.loading.observe(this, Observer { loading ->
            if(loading){
                edtxSearch.visibility = GONE
                rvCurrency.visibility = GONE
                vwLoading.visibility = VISIBLE
                tvLoading.visibility = VISIBLE
                progressBar.visibility = VISIBLE
            } else {
                edtxSearch.visibility = VISIBLE
                rvCurrency.visibility = VISIBLE
                vwLoading.visibility = GONE
                tvLoading.visibility = GONE
                progressBar.visibility = GONE
            }
        })

        viewModel.listCurrency.observe(this, Observer { currencies ->
            adapter = CurrencyAdapter(currencies,viewModel)
            rvCurrency.adapter = adapter
        })

        viewModel.currencySelected.observe(this, Observer { symbol ->
            val intent = Intent()
            val bundle = Bundle()

            bundle.putInt(CURRENCY_ORDER,flow)
            bundle.putString(CURRENCY_SELECTED,symbol)
            intent.putExtras(bundle)
            setResult(Activity.RESULT_OK, intent)
            finish()
        })
    }

    private fun setListeners() {
        rvCurrency.addOnScrollListener(object : RecyclerView.OnScrollListener() {

            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                super.onScrollStateChanged(recyclerView, newState)
                if (!recyclerView.canScrollVertically(-1) && newState==RecyclerView.SCROLL_STATE_IDLE) {
                    viewModel.isUpdating = true
                    viewModel.getCurrenciesAPI()
                    viewModel.getQuoteList()
                }
            }

        })

        edtxSearch.addTextChangedListener(object : TextWatcher {

            override fun afterTextChanged(s: Editable) {
                adapter?.searchElementOnList(s.toString())
            }

            override fun beforeTextChanged(s: CharSequence, start: Int,count: Int, after: Int) {}

            override fun onTextChanged(s: CharSequence, start: Int,before: Int, count: Int) { }
        })

    }
}