package br.com.jlcampos.desafiobtg.presentation.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import br.com.jlcampos.desafiobtg.R
import br.com.jlcampos.desafiobtg.data.model.Currency

class CurrenciesAdapter (
    val currency: List<Currency>,
    val onItemClickListener: ((currency: Currency) -> Unit)
): RecyclerView.Adapter<CurrenciesAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
        return ViewHolder(itemView, onItemClickListener)
    }

    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {
        viewHolder.bindView(currency[position])
    }

    override fun getItemCount() = currency.count()

    class ViewHolder(view: View, private val onItemClickListener: ((currency: Currency) -> Unit)) : RecyclerView.ViewHolder(view) {

        private val sigla = view.findViewById<TextView>(R.id.item_currency_tv_sigla)
        private val nome = view.findViewById<TextView>(R.id.item_currency_tv_nome)

        fun bindView(currency: Currency) {
            sigla.text = currency.key
            nome.text = currency.value

            itemView.setOnClickListener {
                onItemClickListener.invoke(currency)
            }
        }

    }
}