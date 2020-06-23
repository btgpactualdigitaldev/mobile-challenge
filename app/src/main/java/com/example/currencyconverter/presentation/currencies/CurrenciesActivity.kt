package com.example.currencyconverter.presentation.currencies

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.widget.SearchView
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currencyconverter.R
import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.DatabaseInstance
import com.example.currencyconverter.logic.CurrenciesInteractor
import com.example.currencyconverter.presentation.converter.MessageView
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_currencies.*

class CurrenciesActivity : AppCompatActivity(), MessageView, CurrencyListView {

    private val compositeDisposable = CompositeDisposable()
    private var currenciesInteractor : CurrenciesInteractor? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencies)
        currenciesRecyclerView.layoutManager = LinearLayoutManager(this)

        val database = DatabaseInstance()

        currenciesInteractor = CurrenciesInteractor(this as CurrencyListView, database)
        currenciesInteractor?.onCreate()
        configureSearchWidget()
    }

    fun configureSearchWidget() {
        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String) = false

            override fun onQueryTextChange(newText: String): Boolean {
                if (newText == "") currenciesInteractor?.clearSearch()
                else currenciesInteractor?.search(newText)
                return true
            }
        })
    }

    override  fun setRecyclerViewArray(array: ArrayList<Currency>) {
        currenciesRecyclerView?.adapter = CurrencyAdapter(this, array)
    }

    fun onCurrencySelected(view: View) {
        val selectedCurrency = view.tag as Currency
        currenciesInteractor?.onCurrencySelected(selectedCurrency)
    }

    override fun finishWithResultingCurrency(currency: Currency) {
        val resultIntent = Intent()
        resultIntent.putExtra("selectedCurrency", currency)
        setResult(Activity.RESULT_OK, resultIntent)
        finish()
    }

    fun orderButtonClick(view: View) {
        currenciesInteractor?.reorderList()
    }

    override fun setOrderButtonText(text: String) {
        orderButton.text = text
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        currenciesInteractor?.onDestroy()
        super.onDestroy()
    }
}
