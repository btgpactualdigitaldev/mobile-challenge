package br.net.easify.currencydroid.view.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.databinding.HolderCurrencyBinding

class CurrenciesAdapter(
    private var listener: OnItemClick,
    private var currencies: ArrayList<Currency>
)
    : RecyclerView.Adapter<CurrenciesAdapter.CurrencyViewHolder>(), Filterable {

    private var currenciesFiltered: ArrayList<Currency> = arrayListOf()

    class CurrencyViewHolder(var view: HolderCurrencyBinding) :
        RecyclerView.ViewHolder(view.root)

    interface OnItemClick {
        fun onItemClick(currency: Currency)
    }

    fun updateData(newData: List<Currency>) {
        currencies.clear()
        currencies.addAll(newData)

        currenciesFiltered.clear()
        currenciesFiltered.addAll(newData)

        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = DataBindingUtil.inflate<HolderCurrencyBinding>(
            inflater,
            R.layout.holder_currency,
            parent,
            false
        )
        return CurrencyViewHolder(view)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val currency = currenciesFiltered[position]

        holder.itemView.setOnClickListener {
            listener.onItemClick(currency)
        }

        holder.view.currency = currency
    }

    override fun getItemCount() = currenciesFiltered.size

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(charSequence: CharSequence): FilterResults {
                val charString = charSequence.toString()
                currenciesFiltered.clear()
                if (charString.isEmpty()) {
                    currenciesFiltered.addAll(currencies)
                } else {
                    val filteredList: ArrayList<Currency> = arrayListOf()
                    for (row in currencies) {
                        if (row.description.toLowerCase().contains(charString.toLowerCase()) ||
                            row.currencyId.toLowerCase().contains(charString.toLowerCase())
                        ) {
                            filteredList.add(row)
                        }
                    }
                    currenciesFiltered.addAll(filteredList)
                }
                val filterResults = FilterResults()
                filterResults.values = currenciesFiltered
                return filterResults
            }

            override fun publishResults(charSequence: CharSequence, filterResults: FilterResults) {
                currenciesFiltered = filterResults.values as ArrayList<Currency>
                notifyDataSetChanged()
            }
        }
    }
}