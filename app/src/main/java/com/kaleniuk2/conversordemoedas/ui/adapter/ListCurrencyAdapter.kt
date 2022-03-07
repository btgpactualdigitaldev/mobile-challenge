package com.kaleniuk2.conversordemoedas.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.kaleniuk2.conversordemoedas.R
import com.kaleniuk2.conversordemoedas.data.model.Currency

class ListCurrencyAdapter(private val listener: (Currency) -> Unit) :
    RecyclerView.Adapter<ListCurrencyViewHolder>() {

    var listCurrency: List<Currency> = listOf()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListCurrencyViewHolder {
        return ListCurrencyViewHolder(LayoutInflater.from(parent.context)
            .inflate(R.layout.item_list_currency, parent, false))
    }

    override fun getItemCount() = listCurrency.size

    override fun onBindViewHolder(holder: ListCurrencyViewHolder, position: Int) {
        val currency = listCurrency[position]
        holder.apply {
            itemView.setOnClickListener { listener(currency) }
            bind(currency)
        }
    }
}

class ListCurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    private val tvNameCurrency: TextView = itemView.findViewById(R.id.tv_name_currency)
    private val tvAbbreviationCurrency: TextView = itemView.findViewById(R.id.tv_abbreviation_currency)

    fun bind(currency: Currency) {
        tvNameCurrency.text = currency.name
        tvAbbreviationCurrency.text = currency.abbreviation
    }
}
