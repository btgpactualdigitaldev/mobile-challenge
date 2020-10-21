package com.romildosf.currencyconverter.view.list

import android.util.Log
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import com.romildosf.currencyconverter.R
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.databinding.CurrencyItemBinding

class CurrencyViewAdapter(var currencies: List<Currency>) :
    RecyclerView.Adapter<CurrencyViewAdapter.CurrencyItem>() {

    var interactionListener: (currency: Currency) -> Unit = {}

    class CurrencyItem(itemView: View): RecyclerView.ViewHolder(itemView) {
        val binding: CurrencyItemBinding? = DataBindingUtil.bind(itemView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyItem {
        return CurrencyItem(
            LayoutInflater
                .from(parent.context)
                .inflate(R.layout.currency_item, parent, false))
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: CurrencyItem, position: Int) {
        holder.binding?.apply {
            currency = currencies[position]

            holder.itemView.setOnClickListener { interactionListener.invoke(currency!!) }
            executePendingBindings()
        }
    }
}