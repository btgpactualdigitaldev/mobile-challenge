/**
 * recycler view adapter to properly show the large currencies list inside CurrencyList activity
 */
package com.leonardo.convertcoins.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.RecyclerView
import com.leonardo.convertcoins.CurrencyList
import com.leonardo.convertcoins.R
import com.leonardo.convertcoins.config.inflate
import com.leonardo.convertcoins.databinding.CurrencyRecyclerviewItemRowBinding
import com.leonardo.convertcoins.models.Currency

class CurrencyAdapter(private val currencies: ArrayList<Currency>) : RecyclerView.Adapter<CurrencyAdapter.CurrencyViewHolder>(), Filterable {

    var filteredCurrencies = ArrayList<Currency>()

    init {
        filteredCurrencies = currencies
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val inflatedView = parent.inflate(R.layout.currency_recyclerview_item_row, false)
        val binding = CurrencyRecyclerviewItemRowBinding
            .inflate(LayoutInflater.from(parent.context), parent, false)
        return CurrencyViewHolder(binding)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bindCurrency(filteredCurrencies[position])
    }

    override fun getItemCount() = filteredCurrencies.size

    /**
     * Method used to filter listed currencies.
     */
    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charSearch = constraint.toString()

                filteredCurrencies =
                    if (charSearch.isEmpty()) currencies
                    else {
                        val resultList = ArrayList<Currency>()
                        for (currency in currencies) {
                            // filter currencies based on coin initials and currency description
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

            /**
             * Update list indeed and notify adapter that the set has changed
             */
            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                filteredCurrencies = results?.values as ArrayList<Currency>
                notifyDataSetChanged()
            }

        }
    }

    class CurrencyViewHolder(private val binding: CurrencyRecyclerviewItemRowBinding) : RecyclerView.ViewHolder(binding.root),  View.OnClickListener {
        val view = binding.root
        init {
            view.setOnClickListener(this)
        }

        override fun onClick(v: View?) {
            if (view.context is CurrencyList)
                (view.context as CurrencyList).currencySelected(binding.recyclerCoin.text.toString())
        }

        fun bindCurrency(currency: Currency) {
            binding.recyclerCoin.text = currency.coin
            binding.recyclerDescription.text = currency.description

            // draw the res image related to the selected currency if it exists,
            // otherwise, draw default coin label
            val id = view.resources.getIdentifier("@drawable/${currency.coin.toLowerCase()}", null, view.context.packageName)
            if (id > 0) binding.recyclerImage.setImageResource(id)
            else binding.recyclerImage.setImageResource(R.drawable.coin_icon)

        }
    }
}