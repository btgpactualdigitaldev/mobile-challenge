package com.gft.presentation

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.currency_item.view.*

class ListAdapter(private val onItemClick: ((String)) -> Unit) :
    RecyclerView.Adapter<ListAdapter.CurrencyViewHolder>() {

    var currency = mapOf<String, String>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view =
            LayoutInflater.from(parent.context).inflate(R.layout.currency_item, parent, false)
        return CurrencyViewHolder(view)
    }

    override fun getItemCount(): Int {
        return currency.size
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val nome = ArrayList<String>(currency.values)[position]
        val codigo = ArrayList<String>(currency.keys)[position]

        holder.bind(nome, codigo)

        holder.itemView.setOnClickListener {
            onItemClick(codigo)
        }
    }

    inner class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(nome: String, codigo: String) {
            with(itemView) {
                itemView.nome.text = nome
                itemView.codigo.text = codigo
            }
        }
    }

    fun updateList(list: Map<String, String>) {
        if (list.isNotEmpty()) {
            currency = list
            notifyDataSetChanged()
        }
    }
}
