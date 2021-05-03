package com.leonardo.convertcoins.adapter

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.leonardo.convertcoins.CurrencyList
import com.leonardo.convertcoins.R
import com.leonardo.convertcoins.config.inflate
import com.leonardo.convertcoins.model.Currency
import kotlinx.android.synthetic.main.currency_recyclerview_item_row.view.*

class CurrencyAdapter(private val currencies: ArrayList<Currency>) : RecyclerView.Adapter<CurrencyAdapter.CurrencyViewHolder>(), Filterable {

    var filteredCurrencies = ArrayList<Currency>()

    init {
        filteredCurrencies = currencies
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val inflatedView = parent.inflate(R.layout.currency_recyclerview_item_row, false)
        return CurrencyViewHolder(inflatedView)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bindCurrency(filteredCurrencies[position])
    }

    override fun getItemCount() = filteredCurrencies.size

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charSearch = constraint.toString()

                filteredCurrencies =
                    if (charSearch.isEmpty()) currencies
                    else {
                        val resultList = ArrayList<Currency>()
                        for (currency in currencies) {
                            if (currency.coin.toLowerCase().contains(charSearch.toLowerCase())
                                || currency.description.toLowerCase().contains(charSearch.toLowerCase()))
                                resultList.add(currency)
                        }
                        resultList
                    }
                val filteredResults = FilterResults()
                filteredResults.values = filteredCurrencies
                return filteredResults
            }

            @Suppress("UNCHECKED_CAST")
            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                filteredCurrencies = results?.values as ArrayList<Currency>
                notifyDataSetChanged()
            }

        }
    }

    class CurrencyViewHolder(v: View) : RecyclerView.ViewHolder(v), View.OnClickListener {
        private val view = v

        init {
            v.setOnClickListener(this)
        }

        override fun onClick(v: View?) {
            if (view.context is CurrencyList)
                (view.context as CurrencyList).currencySelected(view.recyclerCoin.text.toString())
        }

        fun bindCurrency(currency: Currency) {
            view.recyclerCoin.text = currency.coin
            view.recyclerDescription.text = currency.description
        }
    }
}