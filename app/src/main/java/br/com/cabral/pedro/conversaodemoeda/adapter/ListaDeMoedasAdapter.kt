package br.com.cabral.pedro.conversaodemoeda.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import br.com.cabral.pedro.conversaodemoeda.R
import br.com.cabral.pedro.conversaodemoeda.`interface`.OnMoedaEscolhidaListener
import kotlinx.android.synthetic.main.moeda_item.view.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

class ListaDeMoedasAdapter(moedaTipo: HashMap<String, String>?,
                           private val context: Context,
                           private val onMoedaEscolhidaListener: OnMoedaEscolhidaListener) :
    RecyclerView.Adapter<ListaDeMoedasAdapter.ListaDeMoedasViewHolder>() {

    private val listChave = ArrayList(moedaTipo?.keys)
    private val listValor = ArrayList(moedaTipo?.values)

    class ListaDeMoedasViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val cvListaMoedas: CardView = view.cv_lista_moedas
        var txtSigla: TextView = view.txt_sigla
        var txtNomeMoeda: TextView = view.txt_nome_moeda
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) : ListaDeMoedasViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.moeda_item, parent, false) as View
        return ListaDeMoedasViewHolder(view)
    }

    override fun onBindViewHolder(holder: ListaDeMoedasViewHolder, position: Int) {
        ordenacaoLista()

        holder.txtSigla.text = listChave[position]
        holder.txtNomeMoeda.text = listValor[position]

        holder.cvListaMoedas.setOnClickListener {
            onMoedaEscolhidaListener.onClick(holder.txtSigla.text.toString(), holder.txtNomeMoeda.text.toString())
        }
    }

    override fun getItemCount() = listChave.size

    private fun ordenacaoLista() {
        listChave.sort()
        listValor.sort()
    }

}
