package fps.daniel.conversormoedas.viewmodel

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.recyclerview.widget.LinearLayoutManager
import fps.daniel.conversormoedas.R
import fps.daniel.conversormoedas.data.DataInstance
import fps.daniel.conversormoedas.domain.CurrenciesLayer
import fps.daniel.conversormoedas.enity.CurrencyLayer
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_currencies.*

class CurrenciesActivity : AppCompatActivity(), MessageView, CurrencyList {

    private val compositeDisposable = CompositeDisposable()
    private var currencies : CurrenciesLayer? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencies)
        currenciesRecyclerView.layoutManager = LinearLayoutManager(this)

        val database = DataInstance()

        currencies = CurrenciesLayer(this as CurrencyList, database)
        currencies?.onCreate()
        configureSearchWidget()
    }

    fun configureSearchWidget() {
        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String) = false

            override fun onQueryTextChange(newText: String): Boolean {
                if (newText == "") currencies?.clearSearch()
                else currencies?.search(newText)
                return true
            }
        })
    }

    override  fun setRecyclerViewArray(array: ArrayList<CurrencyLayer>) {
        currenciesRecyclerView?.adapter = CurrencyAdapter(this, array)
    }

    fun onSelecionarMoeda(view: View) {
        val selectedCurrency = view.tag as CurrencyLayer
        currencies?.onCurrencySelected(selectedCurrency)
    }

    override fun finishWithResultingCurrency(currency: CurrencyLayer) {
        val resultIntent = Intent()
        resultIntent.putExtra("selectedCurrency", currency)
        setResult(Activity.RESULT_OK, resultIntent)
        finish()
    }

    fun ordenar(view: View) {
        currencies?.reorderList()
    }

    override fun setOrderButtonText(text: String) {
        orderButton.text = text
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        currencies?.onDestroy()
        super.onDestroy()
    }
}