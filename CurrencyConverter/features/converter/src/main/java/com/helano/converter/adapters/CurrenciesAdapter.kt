package com.helano.converter.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.helano.converter.databinding.ItemCurrencyBinding
import com.helano.converter.ui.currencies.CurrenciesViewModel
import com.helano.shared.model.Currency
import java.util.*


class CurrenciesAdapter(
    private val viewModel: CurrenciesViewModel
) : ListAdapter<Currency, CurrenciesAdapter.ViewHolder>(CurrenciesCallback()), Filterable {

    private var currencies = arrayListOf<Currency>()

    init {
        currencies.addAll(viewModel.items.value!!)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder.from(parent)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(viewModel, getItem(position))
    }

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charString = constraint.toString()
                val searchResult = arrayListOf<Currency>()
                if (charString.isEmpty()) {
                    searchResult.addAll(currencies)
                } else {
                    val loc = Locale.getDefault()
                    searchResult.addAll(currencies.filter {
                        (it.code.toLowerCase(loc).contains(charString.toLowerCase(loc))
                                or it.name.toLowerCase(loc).contains(charString.toLowerCase(loc)))
                    })
                }

                val filterResult = FilterResults()
                filterResult.values = searchResult
                return filterResult
            }

            override fun publishResults(constraint: CharSequence?, results: FilterResults) {
                viewModel.items.value = results.values as ArrayList<Currency>
            }
        }
    }

    class ViewHolder private constructor(val binding: ItemCurrencyBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(viewModel: CurrenciesViewModel, item: Currency) {
            binding.viewModel = viewModel
            binding.currency = item
            binding.executePendingBindings()
        }

        companion object {
            fun from(parent: ViewGroup): ViewHolder {
                val layoutInflater = LayoutInflater.from(parent.context)
                val binding = ItemCurrencyBinding.inflate(layoutInflater, parent, false)

                return ViewHolder(binding)
            }
        }
    }
}

class CurrenciesCallback : DiffUtil.ItemCallback<Currency>() {
    override fun areItemsTheSame(oldItem: Currency, newItem: Currency): Boolean {
        return oldItem.code == newItem.code
    }

    override fun areContentsTheSame(oldItem: Currency, newItem: Currency): Boolean {
        return oldItem.code == newItem.code
    }
}