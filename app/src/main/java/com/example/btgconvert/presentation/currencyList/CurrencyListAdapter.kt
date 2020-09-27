package com.example.btgconvert.presentation.currencyList

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.btgconvert.R
import com.example.btgconvert.data.model.Currency
import kotlinx.android.synthetic.main.item_currency.view.*

class CurrencyListAdapter(private val currencyList : List<Currency>, val itemClickListener:((currency: Currency) -> Unit)) : RecyclerView.Adapter<CurrencyListAdapter.CurrencyListViewHolder>(){

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyListViewHolder {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
        return CurrencyListViewHolder(itemView, itemClickListener)
    }

    override fun getItemCount() = currencyList.count()

    override fun onBindViewHolder(holder: CurrencyListViewHolder, position: Int) {
        holder.bindViewCurrency(currencyList[position])
    }

    class CurrencyListViewHolder(itemView : View, private val itemClickListener:((currency: Currency) -> Unit)) : RecyclerView.ViewHolder(itemView){
        private val txtCurrency = itemView.currency
        fun bindViewCurrency(currency: Currency){
            val key = currency.currencyKey
            val title = currency.currencyTitle
            txtCurrency.text = key + " - " + title
            itemView.setOnClickListener {
                itemClickListener.invoke(currency)
            }
        }
    }

}
