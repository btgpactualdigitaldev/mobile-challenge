package com.example.currencyconverter.ui.currencyList

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.currencyconverter.database.CurrencyModel
import com.example.currencyconverter.databinding.ItemCurrencyBinding
import java.util.*

class Adapter(private val currencyList: List<CurrencyModel>, private val textView: TextView) :
    RecyclerView.Adapter<Adapter.ViewHolder>(), Filterable {

    private var currencyFiltered: List<CurrencyModel> = currencyList

    inner class ViewHolder(val binding: ItemCurrencyBinding) :
        RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(
            ItemCurrencyBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val currency = currencyFiltered[position]
        holder.binding.txtCode.text = currency.currency
        holder.binding.txtName.text = currency.currencyName
    }

    override fun getItemCount() = currencyFiltered.size

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charString = constraint.toString()
                if (charString.isEmpty()) {
                    currencyFiltered = currencyList
                } else {
                    val result: MutableList<CurrencyModel> = mutableListOf()

                    for (item in currencyList) {
                        if (item.currency.lowercase(Locale.ROOT)
                                .contains(charString.lowercase(Locale.ROOT)) || item.currencyName.lowercase(
                                Locale.ROOT
                            ).contains(charString.lowercase(Locale.ROOT))
                        ) {
                            result.add(item)
                        }

                    }
                    currencyFiltered = result
                }
                    val resultFiltered = FilterResults()
                    resultFiltered.values = currencyFiltered
                    return resultFiltered

            }

            override fun publishResults(constraint: CharSequence?, results: FilterResults) {
                currencyFiltered = results.values as List<CurrencyModel>
                if (currencyFiltered.isEmpty()){
                    textView.visibility = View.VISIBLE
                    notifyDataSetChanged()
                } else{
                    textView.visibility = View.GONE
                    notifyDataSetChanged()
                }
            }

        }
    }
}