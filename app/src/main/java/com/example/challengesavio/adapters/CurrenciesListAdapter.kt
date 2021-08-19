package com.example.challengesavio.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.RecyclerView
import com.example.challengesavio.data.entity.Currency
import com.example.challengesavio.databinding.ItemCurrencyBinding
import java.text.Normalizer

class CurrenciesListAdapter(private var currencies:
List<Currency>): RecyclerView.Adapter<CurrenciesListAdapter.CurrenciesViewHolder>() , Filterable {

    private var filterCurrencies = currencies

    private val REGEX_UNACCENT = "\\p{InCombiningDiacriticalMarks}+".toRegex()

    override fun onCreateViewHolder(viewGroup: ViewGroup, i: Int): CurrenciesViewHolder {
        val binding = ItemCurrencyBinding.inflate(
            LayoutInflater.from(viewGroup.context), viewGroup, false)
        return CurrenciesViewHolder(binding)
    }

    override fun getItemCount(): Int {
        return filterCurrencies.size
    }

    fun setCurrencies(dataSource: List<Currency>){
        this.currencies = dataSource
        this.filterCurrencies = dataSource
        notifyDataSetChanged()
    }

    inner class CurrenciesViewHolder(val binding: ItemCurrencyBinding)
        : RecyclerView.ViewHolder(binding.root) {

        fun bind(item: Currency) {

            binding.currencyAcronymList.text = item.acronym
            binding.currencyName.text = item.name
        }
    }

    override fun onBindViewHolder(holder: CurrenciesListAdapter.CurrenciesViewHolder, position: Int) {

        val currency = filterCurrencies[position]

        holder.bind(currency)
    }

    fun setFilteredCurrencies(newCurrencies: List<Currency>) {
        this.filterCurrencies = newCurrencies
        notifyDataSetChanged()
    }

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                (results?.values as? List<*>)?.let { filterResults ->
                    val newList = filterResults.filterIsInstance<Currency>()
                    setFilteredCurrencies(newList)
                }
            }

            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val keyWords = constraint?.toString()?.toLowerCase()?.unaccent()
                val filterResults = FilterResults()
                val suggestions = if (keyWords.isNullOrEmpty()) {
                    currencies.toMutableList()
                } else {
                    currencies.filter {
                        (it.acronym?.toLowerCase()?.unaccent()?.contains(keyWords) ?: false ||
                                (it.name?.toLowerCase()?.unaccent()?.contains(keyWords) ?: false))
                    }.toMutableList()
                }

                filterResults.values = suggestions
                filterResults.count = suggestions.count()
                return filterResults
            }
        }
    }

    fun CharSequence.unaccent() : String {
        val temp = Normalizer.normalize(this, Normalizer.Form.NFD)
        return REGEX_UNACCENT.replace(temp, "")
    }
}