package br.com.cauejannini.btgmobilechallenge.activities.conversordemoeda

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import br.com.cauejannini.btgmobilechallenge.R
import br.com.cauejannini.btgmobilechallenge.activities.seletordemoeda.SeletorDeMoedaActivity
import br.com.cauejannini.btgmobilechallenge.commons.Utils
import br.com.cauejannini.btgmobilechallenge.commons.form.Form
import br.com.cauejannini.btgmobilechallenge.commons.form.InputTextField
import br.com.cauejannini.btgmobilechallenge.commons.form.textwatchers.ValorMonetarioTextWatcher
import br.com.cauejannini.btgmobilechallenge.commons.form.validators.ValorMonetarioValidator
import br.com.cauejannini.btgmobilechallenge.databinding.ActivityConversorBinding
import kotlinx.android.synthetic.main.activity_conversor.*

class ConversorActivity : AppCompatActivity() {

    lateinit var conversorActivityVM: ConversorActivityVM

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Inicializar VM e DataBinding
        conversorActivityVM = ViewModelProvider(this).get(ConversorActivityVM::class.java)
        conversorActivityVM.init()
        val activityConversorBinding: ActivityConversorBinding = DataBindingUtil.setContentView(this, R.layout.activity_conversor)
        activityConversorBinding.conversorActivityVM = conversorActivityVM

        // Configurar comportamento de views

        inputValorEntrada.setCustomTextWatcher(ValorMonetarioTextWatcher(inputValorEntrada))
        inputValorEntrada.setValidator(ValorMonetarioValidator(0.01, null));

        btMoedaEntrada.setOnClickListener {
            startActivityForResult(Intent(this@ConversorActivity, SeletorDeMoedaActivity::class.java), SeletorDeMoedaActivity.REQUEST_CODE_CURRENCY_ENTRADA)
        }

        btMoedaSaida.setOnClickListener {
            startActivityForResult(Intent(this@ConversorActivity, SeletorDeMoedaActivity::class.java), SeletorDeMoedaActivity.REQUEST_CODE_CURRENCY_SAIDA)
        }

        val form = Form(btConverter)
        form.addValidatable(inputValorEntrada)

        btConverter.setOnClickListener {
            val valorEntrada = Utils.valorMonetarioParaDouble(inputValorEntrada.text)
            valorEntrada?.let {
                conversorActivityVM.converter(this, it)
            }
        }

        conversorActivityVM.moedaEntrada.observe( this, Observer { currencyEntrada ->
            btMoedaEntrada.updateText(currencyEntrada)
        })

        conversorActivityVM.moedaSaida.observe( this, Observer { currencySaida ->
            btMoedaSaida.updateText(currencySaida)
        })

        conversorActivityVM.loadingConversao.observe( this, Observer { loading ->
            btConverter.setLoading(loading)
        })

        conversorActivityVM.outErrorToUser.observe(this, Observer {erro ->
            Utils.showToast(this, erro)
        })

        inputValorEntrada.afterTextChangedListener = (object: InputTextField.AfterTextChangedListener {
            override fun afterTextChanged(text: String) {
                tvValorConvertido.text = ""
            }
        })

        conversorActivityVM.moedaEntrada.value = "BRL"
        conversorActivityVM.moedaSaida.value = "USD"

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            data?.let {
                if (it.hasExtra(SeletorDeMoedaActivity.EXTRA_KEY_CURRENCY_SELECTED)) {

                    val currencySymbol = it.extras?.getString(SeletorDeMoedaActivity.EXTRA_KEY_CURRENCY_SELECTED)

                    if (requestCode == SeletorDeMoedaActivity.REQUEST_CODE_CURRENCY_ENTRADA) {
                        conversorActivityVM.moedaEntrada.value = currencySymbol
                        tvValorConvertido.setText("")
                    } else if (requestCode == SeletorDeMoedaActivity.REQUEST_CODE_CURRENCY_SAIDA) {
                        conversorActivityVM.moedaSaida.value = currencySymbol
                        tvValorConvertido.setText("")
                    }

                }
            }

        }
    }
}
