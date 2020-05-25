package com.guioliveiraapps.btg.ui.currencies

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.guioliveiraapps.btg.R
import com.guioliveiraapps.btg.room.Currency
import java.util.*


class CurrenciesAdapter(
    private val currencies: List<Currency>,
    private val context: Context
) : RecyclerView.Adapter<CurrenciesAdapter.ViewHolder>(), Filterable {

    private var mCurrencies: List<Currency> = currencies
    private var currentSort: Sort = Sort.INITIALS

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view: View =
            LayoutInflater.from(context).inflate(R.layout.adapter_currencies, parent, false)

        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val currency: Currency = mCurrencies[position]
        holder.bind(currency)
    }

    override fun getItemCount(): Int {
        return mCurrencies.size
    }

    fun sortByInitials() {
        mCurrencies = mCurrencies.sortedBy {
            it.initials
        }
        currentSort = Sort.INITIALS
        notifyDataSetChanged()
    }

    fun sortByName() {
        mCurrencies = mCurrencies.sortedBy {
            it.name
        }
        currentSort = Sort.NAME
        notifyDataSetChanged()
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val txtCurrency: TextView = itemView.findViewById(R.id.txt_currency)

        fun bind(currency: Currency) {
            txtCurrency.text = currency.toString()
        }
    }

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val queryString: String =
                    constraint.toString().toLowerCase(Locale.getDefault()).trim()

                val filterResults = FilterResults()
                if (queryString.isEmpty()) {
                    if (currentSort == Sort.INITIALS) {
                        filterResults.values = currencies.sortedBy { it.initials }
                    } else {
                        filterResults.values = currencies.sortedBy { it.name }
                    }
                } else {
                    val values: MutableSet<Currency> = mutableSetOf()

                    values.addAll(currencies.filter {
                        it.toString().toLowerCase(Locale.getDefault()).contains(queryString)
                    })

                    if (currentSort == Sort.INITIALS) {
                        filterResults.values = values.toList().sortedBy { it.initials }
                    } else {
                        filterResults.values = values.toList().sortedBy { it.name }
                    }
                }
                return filterResults
            }

            override fun publishResults(constraint: CharSequence?, results: FilterResults) {
                mCurrencies = results.values as List<Currency>
                notifyDataSetChanged()
            }

        }
    }

    enum class Sort {
        INITIALS, NAME
    }
}