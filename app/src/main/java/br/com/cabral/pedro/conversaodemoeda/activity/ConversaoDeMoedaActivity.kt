package br.com.cabral.pedro.conversaodemoeda.activity

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import br.com.cabral.pedro.conversaodemoeda.R
import br.com.cabral.pedro.conversaodemoeda.dialog.DialogUtils
import br.com.cabral.pedro.conversaodemoeda.enum.Constantes
import br.com.cabral.pedro.conversaodemoeda.model.data.ValorMoedaContract
import br.com.cabral.pedro.conversaodemoeda.model.data.ValorMoedaPresenter
import br.com.cabral.pedro.conversaodemoeda.service.CurrencyLayerService
import kotlinx.android.synthetic.main.activity_conversao_de_moeda.*
import java.math.BigDecimal

class ConversaoDeMoedaActivity : AppCompatActivity(), ValorMoedaContract.View {

    private var presenter: ValorMoedaContract.Presenter? = null

    private var chaveOrigem: String? = null
    private var moedaOrigem: String? = null
    private var chaveDestino: String? = null
    private var moedaDestino: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conversao_de_moeda)

        btn_moeda_origem.setOnClickListener {
            val intent = Intent(this, ListaDeMoedasActivity::class.java)
            startActivityForResult(intent, 1)
        }

        btn_moeda_destino.setOnClickListener {
            val intent = Intent(this, ListaDeMoedasActivity::class.java)
            startActivityForResult(intent, 2)
        }

        btn_conversor.setOnClickListener {
            edt_valor_moeda.clearFocus()
            if(txt_moeda_origem.text == "" || txt_moeda_destino.text == "" || edt_valor_moeda.text.toString() == "") {
                DialogUtils.DialogErro(this,
                    "ERROR",
                    "Os campos de moedas e o valor são obrigatórios!")
                { dialog, _ ->
                    dialog.dismiss()
                }
            } else {
                val valorDigitado = edt_valor_moeda.text.toString().toDouble()
                val resultado = valorDigitado.div(moedaOrigem!!.toDouble()).times(moedaDestino!!.toDouble())
                txt_moeda_convertida.text = resultado.toString()
                txt_moeda_origem.text = ""
                txt_moeda_destino.text = ""
            }
        }
    }

    override fun callBackMoedaValor(moedaValor: HashMap<String, BigDecimal>?) {
        moedaOrigem = moedaValor?.filterKeys { it == "USD$chaveOrigem" }?.values.toString().
        replace("[", "").replace("]", "")
        moedaDestino = moedaValor?.filterKeys { it == "USD$chaveDestino" }?.values.toString().
        replace("[", "").replace("]", "")
    }

    override fun callBackErro(msg: String) {
        DialogUtils.DialogErro(this,
            "ERROR",
            "Não foi possível obter o valor das moedas. Por favor, tente mais tarde.")
        { dialog, _ ->
            dialog.dismiss()
            finish()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(requestCode == 1 && resultCode == Activity.RESULT_OK) {
            txt_moeda_origem.text = data?.getStringExtra(Constantes.MOEDA.valor)
            chaveOrigem = data!!.getStringExtra(Constantes.CHAVE.valor).toString()
        } else if(requestCode == 2 && resultCode == Activity.RESULT_OK) {
            txt_moeda_destino.text = data?.getStringExtra(Constantes.MOEDA.valor)
            chaveDestino = data!!.getStringExtra(Constantes.CHAVE.valor).toString()
        }
        presenter = ValorMoedaPresenter(this, CurrencyLayerService())
        (presenter as ValorMoedaPresenter).chamarMoedaValor()
    }

}