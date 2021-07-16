package br.com.conversordemoedas.view.activty

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import br.com.conversordemoedas.R
import br.com.conversordemoedas.model.Currency
import br.com.conversordemoedas.model.Live
import br.com.conversordemoedas.model.Quotes
import br.com.conversordemoedas.viewmodel.CurrencyViewModel
import kotlinx.android.synthetic.main.activity_main.*
import org.koin.android.viewmodel.ext.android.viewModel
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MainActivity : AppCompatActivity() {

    companion object {
        const val REQUEST_FROM_CURRENCY_CODE = 1
        const val REQUEST_TO_CURRENCY_CODE = 2

        const val DEFAULT_FROM_CURRENCY = "BRL"
        const val DEFAULT_TO_CURRENCY = "USD"
    }

    private val currencyViewModel: CurrencyViewModel by viewModel()

    var fromCurrency: Currency? = null
    var toCurrency: Currency? = null

    var fromQuotes: Quotes? = null
    var toQuotes: Quotes? = null

    var isFrom: Boolean = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btn_from_currency.setOnClickListener(View.OnClickListener {
            isFrom = true
            startActivityForResult(Intent(this, CurrencyActivity::class.java), REQUEST_FROM_CURRENCY_CODE)
        })

        btn_to_currency.setOnClickListener(View.OnClickListener {
            isFrom = false
            startActivityForResult(Intent(this, CurrencyActivity::class.java), REQUEST_TO_CURRENCY_CODE)
        })

        et_from_value.addTextChangedListener(object : TextWatcher{
            override fun afterTextChanged(p0: Editable?) {
                if (et_from_value.isFocused){
                    if (et_from_value.text.isNotEmpty()){
                        et_to_value.setText(currencyViewModel.formatValue(convertValues(et_from_value.text.toString().toDouble())))
                    }else{
                        et_to_value.setText("")
                    }
                }
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

        })

        et_to_value.addTextChangedListener(object : TextWatcher{
            override fun afterTextChanged(p0: Editable?) {
                if (et_to_value.isFocused){
                    if (et_to_value.text.isNotEmpty()){
                        et_from_value.setText(currencyViewModel.formatValue(convertValues(et_to_value.text.toString().toDouble())))
                    }else{
                        et_from_value.setText("")
                    }
                }
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

        })

        ib_reverse.setOnClickListener { reverseConversion() }

        setupDefaultConvert()

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            REQUEST_FROM_CURRENCY_CODE -> when (resultCode) {
                RESULT_OK -> {
                    fromCurrency = data?.getSerializableExtra("currency") as Currency?
                    btn_from_currency.text = fromCurrency!!.code
                    getCurrencyLive(fromCurrency!!.code)
                }
            }
            REQUEST_TO_CURRENCY_CODE -> when (resultCode) {
                RESULT_OK -> {
                    toCurrency = data?.getSerializableExtra("currency") as Currency?
                    btn_to_currency.text = toCurrency!!.code
                    getCurrencyLive(toCurrency!!.code)
                }
            }
        }
    }

    private fun getCurrencyLive(currenciesCodes: String) {
        currencyViewModel.getCurrencyLive(currenciesCodes, object: Callback<Live> {
            override fun onFailure(call: Call<Live>, t: Throwable) {}

            override fun onResponse(call: Call<Live>, response: Response<Live>) {
                val live: Live? = response.body()
                live?.let {
                    tv_update.text = currencyViewModel.getDateTime(live.timestamp)
                    if (isFrom){
                        fromQuotes = currencyViewModel.createQuotes(it)
                        isFrom = false
                    }else{
                        toQuotes = currencyViewModel.createQuotes(it)
                    }
                }
            }

        })
    }

    fun setupDefaultConvert(){
        //De
        getCurrencyLive(DEFAULT_FROM_CURRENCY)
        fromCurrency = Currency(DEFAULT_FROM_CURRENCY, "")
        btn_from_currency.text = DEFAULT_FROM_CURRENCY

        //Para
        getCurrencyLive(DEFAULT_TO_CURRENCY)
        toCurrency = Currency(DEFAULT_TO_CURRENCY, "")
        btn_to_currency.text = DEFAULT_TO_CURRENCY
    }

    fun convertValues (fromUserValue: Double): Double{
        //Verificando em qual caixa de texto o usuário está digitando
        return if (et_from_value.isFocused){
            (fromUserValue / fromQuotes!!.value) * toQuotes!!.value
        }else{
            (fromUserValue / toQuotes!!.value) * fromQuotes!!.value
        }
    }

    fun reverseConversion(){
        //Removendo o foco para não acionar o addTextChangedListener
        et_from_value.clearFocus()
        et_to_value.clearFocus()

        //Invertendo o texto do botão
        btn_from_currency.text = toCurrency!!.code
        btn_to_currency.text = fromCurrency!!.code

        //Invertendo o texto da caixa de texto
        val auxValue: String = et_to_value.text.toString()
        et_to_value.text = et_from_value.text
        et_from_value.setText(auxValue)

        //Invertendo a classe de moeda
        val auxCurrency: Currency = toCurrency as Currency
        toCurrency = fromCurrency
        fromCurrency = auxCurrency

        //Invertendo a classe de cotação
        val auxQuotes: Quotes = toQuotes as Quotes
        toQuotes = fromQuotes
        fromQuotes = auxQuotes
    }

}
