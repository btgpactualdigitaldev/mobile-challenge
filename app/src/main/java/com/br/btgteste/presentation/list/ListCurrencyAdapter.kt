package com.br.btgteste.presentation.list

import android.annotation.SuppressLint
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.br.btgteste.R
import com.br.btgteste.domain.model.Currency

class ListCurrencyAdapter(private val context: Context)
    : RecyclerView.Adapter<ListCurrencyAdapter.CurrencyViewHolder>() {

    private val listCurrencies = mutableListOf<Currency>()

    fun updateList(listCurrencies: List<Currency>): Boolean {
        this.listCurrencies.clear()
        this.listCurrencies.addAll(listCurrencies)
        notifyDataSetChanged()
        return true
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder =
        CurrencyViewHolder(LayoutInflater.from(context)
            .inflate(R.layout.item_view_list_currency, parent, false))

    override fun getItemCount(): Int = listCurrencies.size

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bindView(listCurrencies[position])
    }

    inner class CurrencyViewHolder(private val item: View) : RecyclerView.ViewHolder(item) {

        private val txtCurrency: TextView by lazy { item.findViewById<TextView>(R.id.currencyTextView) }

        @SuppressLint("SetTextI18n")
        fun bindView(currency : Currency){
            item.rootView.setOnClickListener {
                require(context is OnListClickItem)
                (context as OnListClickItem).onItemClick(currency)
            }
            txtCurrency.text = "${currency.code} - ${currency.name}"
        }
    }

    interface OnListClickItem {
        fun onItemClick(currency: Currency)
    }
}