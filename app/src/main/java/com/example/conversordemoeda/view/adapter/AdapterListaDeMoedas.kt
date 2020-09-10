package com.example.conversordemoeda.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.conversordemoeda.R
import kotlinx.android.synthetic.main.item_lista_de_moedas.view.*

class AdapterListaDeMoedas(
    var mValues: HashMap<String, String> = hashMapOf(),
    private val interacaoComLista: InteracaoComLista<String>
) : RecyclerView.Adapter<AdapterListaDeMoedas.ViewHolder>() {

    private val mOnclickListener: View.OnClickListener = View.OnClickListener { view ->
        val codigoDaMoeda = view.tag as String
        interacaoComLista.selecionou(codigoDaMoeda)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_lista_de_moedas, parent, false))
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val codigo = mValues.keys.toList()[position]
        val nomeDaMoeda = mValues.values.toList()[position]

        holder.apply {
            tvCodigo.text = codigo
            tvNomeDaMoeda.text= nomeDaMoeda
        }

        with(holder.mView) {
            tag = codigo
            setOnClickListener(mOnclickListener)
        }
    }

    override fun getItemCount(): Int = mValues.size

    class ViewHolder(val mView: View) : RecyclerView.ViewHolder(mView) {
        var tvCodigo: TextView = mView.tvCodigo
        var tvNomeDaMoeda: TextView = mView.tvNomeDaMoeda
    }
}