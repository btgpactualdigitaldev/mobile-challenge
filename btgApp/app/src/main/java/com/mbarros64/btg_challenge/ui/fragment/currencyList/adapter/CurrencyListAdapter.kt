package com.mbarros64.btg_challenge.ui.fragment.currencyList.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.RecyclerView
import com.mbarros64.btg_challenge.database.entity.Currency
import com.mbarros64.btg_challenge.databinding.ItemCurrencyBinding
import java.util.*
import kotlin.collections.ArrayList

class CurrencyListAdapter(private val currencies: List<Currency>) :
        RecyclerView.Adapter<CurrencyListAdapter.CurrencyViewHolder>(), Filterable {

    var currencyFilterList : List<Currency>

    init {
        currencyFilterList = currencies
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder(ItemCurrencyBinding.inflate(LayoutInflater.from(parent.context),
                parent, false))
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val currency = currencyFilterList[position]
        (holder as CurrencyViewHolder).bind(currency)
    }

    override fun getItemCount() = currencyFilterList.size

    inner class CurrencyViewHolder(private val binding: ItemCurrencyBinding) :
            RecyclerView.ViewHolder(binding.root) {

        fun bind(item: Currency) {
            binding.apply {
                currency = item
                executePendingBindings()
            }
        }
    }

    override fun getFilter(): Filter {
        return object : Filter() {

            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charSearch = constraint.toString()
                if (charSearch.isEmpty()) {
                    currencyFilterList = currencies
                } else {
                    val resultList : MutableList<Currency> = mutableListOf()

                    for (row in currencies) {
                        if (row.currency.toLowerCase(Locale.ROOT).contains(charSearch.toLowerCase(Locale.ROOT)) or
                            row.currencyName.toLowerCase(Locale.ROOT).contains(charSearch.toLowerCase(Locale.ROOT))) {
                            resultList.add(row)
                        }
                    }
                    currencyFilterList = resultList
                }
                val filterResults = FilterResults()
                filterResults.values = currencyFilterList
                return filterResults
            }

            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                currencyFilterList = results?.values as List<Currency>
                notifyDataSetChanged()
            }

        }
    }
}