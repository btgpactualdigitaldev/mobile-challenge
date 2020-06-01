package br.com.cauejannini.btgmobilechallenge.activities.seletordemoeda

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.cauejannini.btgmobilechallenge.R
import br.com.cauejannini.btgmobilechallenge.commons.SharedPreferencesHelper
import br.com.cauejannini.btgmobilechallenge.commons.Utils
import br.com.cauejannini.btgmobilechallenge.commons.form.InputTextField
import br.com.cauejannini.btgmobilechallenge.databinding.ActivitySeletorDeMoedaBinding
import kotlinx.android.synthetic.main.activity_seletor_de_moeda.*

class SeletorDeMoedaActivity : AppCompatActivity() {

    companion object {
        val REQUEST_CODE_CURRENCY_ENTRADA = 1
        val REQUEST_CODE_CURRENCY_SAIDA = 2
        val EXTRA_KEY_CURRENCY_SELECTED = "EXTRA_KEY_CURRENCY_SELECTED"
    }

    var adapter: CurrencyRecyclerViewAdapter? = null

    lateinit var seletorDeMoedaActivityVM: SeletorDeMoedaActivityVM

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Inicializar VM e DataBinding
        seletorDeMoedaActivityVM = ViewModelProvider(this).get(SeletorDeMoedaActivityVM::class.java)
        val activitySeletorDeMoedaBinding: ActivitySeletorDeMoedaBinding = DataBindingUtil.setContentView(this, R.layout.activity_seletor_de_moeda)
        activitySeletorDeMoedaBinding.seletorDeMoedaActivityVM = seletorDeMoedaActivityVM

        seletorDeMoedaActivityVM.getCurrencies(this)

        rvCurrencies.layoutManager = LinearLayoutManager(this)

        seletorDeMoedaActivityVM.loading.observe( this, Observer { loading ->
            swipeRefreshLayout.isRefreshing = loading
        })

        seletorDeMoedaActivityVM.outErrorToUser.observe(this, Observer {erro ->
            Utils.showToast(this, erro)
        })

        seletorDeMoedaActivityVM.currencies.observe(this, Observer { currencyList ->

            if (currencyList == null) {
                SharedPreferencesHelper(this).getCurrencyList()?.let { storedList ->
                    adapter = CurrencyRecyclerViewAdapter(storedList, seletorDeMoedaActivityVM)
                }
            } else {
                SharedPreferencesHelper(this).putCurrencyList(currencyList)
                adapter = CurrencyRecyclerViewAdapter(currencyList, seletorDeMoedaActivityVM)
            }
            rvCurrencies.adapter = adapter
        })

        seletorDeMoedaActivityVM.selectedCurrencySymbol.observe(this, Observer { selectedCurrencySymbol ->

            val intent = Intent()
            intent.putExtra(EXTRA_KEY_CURRENCY_SELECTED, selectedCurrencySymbol)
            setResult(Activity.RESULT_OK, intent)
            finish()

        })

        inputFiltrar.afterTextChangedListener = (object: InputTextField.AfterTextChangedListener {
            override fun afterTextChanged(text: String) {
                adapter?.filtrarLista(text)
            }
        })

    }

}