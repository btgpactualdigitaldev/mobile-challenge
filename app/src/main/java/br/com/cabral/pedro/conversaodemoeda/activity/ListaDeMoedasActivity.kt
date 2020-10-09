package br.com.cabral.pedro.conversaodemoeda.activity

import android.app.Activity
import android.content.DialogInterface
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.cabral.pedro.conversaodemoeda.R
import br.com.cabral.pedro.conversaodemoeda.`interface`.OnMoedaEscolhidaListener
import br.com.cabral.pedro.conversaodemoeda.adapter.ListaDeMoedasAdapter
import br.com.cabral.pedro.conversaodemoeda.dialog.DialogUtils
import br.com.cabral.pedro.conversaodemoeda.enum.Constantes
import br.com.cabral.pedro.conversaodemoeda.model.data.TipoMoedaContract
import br.com.cabral.pedro.conversaodemoeda.model.data.TipoMoedaPresenter
import br.com.cabral.pedro.conversaodemoeda.service.CurrencyLayerService
import kotlinx.android.synthetic.main.activity_lista_de_moedas.*
import kotlinx.android.synthetic.main.toolbar_filter.*

class ListaDeMoedasActivity : AppCompatActivity(), TipoMoedaContract.View, OnMoedaEscolhidaListener {

    private var presenter: TipoMoedaContract.Presenter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_lista_de_moedas)

        presenter = TipoMoedaPresenter(this, CurrencyLayerService())
        (presenter as TipoMoedaPresenter).chamarMoedaTipo()

        img_back_btn.setOnClickListener { finish() }
    }

    override fun callBackMoedaTipo(moedaTipo: HashMap<String, String>?) {
        with(rv_coins_list) {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context)
            adapter = ListaDeMoedasAdapter(moedaTipo, context, this@ListaDeMoedasActivity)
        }
    }

    override fun callBackErro(msg: String) {
        DialogUtils.DialogErro(this,
            "ERROR",
            "Não foi possível obter a lista de moedas. Por favor, tente mais tarde.")
        { dialog, _ ->
            dialog.dismiss()
            finish()
        }
    }

    override fun onClick(chave: String, moedaTipo: String) {
        val intent = intent.apply {
            putExtra(Constantes.CHAVE.valor, chave)
            putExtra(Constantes.MOEDA.valor, moedaTipo)
        }
        setResult(Activity.RESULT_OK, intent)
        finish()
    }

}


