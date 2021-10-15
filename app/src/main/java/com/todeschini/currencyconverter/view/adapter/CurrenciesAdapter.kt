package com.todeschini.currencyconverter.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.todeschini.currencyconverter.R
import com.todeschini.currencyconverter.model.CurrencyName

class CurrenciesAdapter(
    private val currenciesList: ArrayList<CurrencyName>
): RecyclerView.Adapter<CurrenciesAdapter.CurrenciesViewHolder>() {

    var onItemClick: ((currencyName: CurrencyName) -> Unit)? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrenciesViewHolder {
        return CurrenciesViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.currencies_list_item, parent, false
            )
        )
    }

    override fun getItemCount() = currenciesList.size

    override fun onBindViewHolder(holder: CurrenciesViewHolder, position: Int) {
        val currency = currenciesList[position]

        holder.currencyInitials?.text = currency.initials
        holder.currenciesName?.text = currency.name
    }

    fun update(mCurrenciesList: ArrayList<CurrencyName>) {
        currenciesList.clear()
        currenciesList.addAll(mCurrenciesList)
        notifyDataSetChanged()
    }

    inner class CurrenciesViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        var currencyInitials: TextView? = null
        var currenciesName: TextView? = null

        init {
            currencyInitials = itemView.findViewById(R.id.currencies_list_item_currency_initials_text_view)
            currenciesName = itemView.findViewById(R.id.currencies_list_item_currency_name_text_view)

            itemView.setOnClickListener {
                onItemClick?.invoke(currenciesList[bindingAdapterPosition])
            }
        }
    }
}