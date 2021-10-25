package com.leonardocruz.btgteste.ui.currencyList.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.leonardocruz.btgteste.R
import com.leonardocruz.btgteste.model.Currencies

class CurrencyAdapter(var currencyList : MutableList<Currencies>, val clickListener : (Currencies) -> Unit) : RecyclerView.Adapter<CurrencyAdapter.CurrencyViewHolder>() {
    class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        private val tv_currency = itemView.findViewById<TextView>(R.id.tv_currency_list)
        fun onBind(currency: Currencies){
            tv_currency.text = "${currency.initials} - ${currency.value}"
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currency_list, parent, false)
        return CurrencyViewHolder(view)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.onBind(currencyList[position])
        holder.itemView.setOnClickListener {
            clickListener(currencyList[position])
        }
    }

    fun updatList(lista : MutableList<Currencies>){
        currencyList = lista
        notifyDataSetChanged()
    }

    override fun getItemCount(): Int {
        return currencyList.size
    }
}