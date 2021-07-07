package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.model.Values
import kotlinx.android.synthetic.main.currency_item.view.*


class SelectorAdapter(
    private var currency: ArrayList<Values>,
    private var currencyFull: List<Values> = currency,
    private val onItemClickListener: ((currency: Values) -> Unit)
) : RecyclerView.Adapter<SelectorAdapter.SelectorViewHolder>(), Filterable {

    init {
        this.currency = currency
        currencyFull = ArrayList<Values>(currency)
    }

    override fun onCreateViewHolder(parent: ViewGroup, view: Int): SelectorViewHolder {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.currency_item, parent, false)
        return SelectorViewHolder(itemView, onItemClickListener)
    }

    override fun getItemCount(): Int = currency.size

    override fun onBindViewHolder(viewHolder: SelectorViewHolder, position: Int) {
        viewHolder.bindView(currency[position])
    }

    override fun getFilter(): Filter? {
        return searchFilter
    }

    private val searchFilter: Filter = object : Filter() {
        override fun performFiltering(constraint: CharSequence): FilterResults {
            val filteredList: MutableList<Values> = ArrayList<Values>()
            if (constraint.isEmpty()) {
                filteredList.addAll(currencyFull)
            } else {
                val filterPattern =
                    constraint.toString().toLowerCase().trim { it <= ' '}
                for (item in currencyFull) {
                    if (item.name!!.toLowerCase().contains(filterPattern)) {
                        filteredList.add(item)
                    }
                }
            }
            val results = FilterResults()
            results.values = filteredList
            return results
        }

        override fun publishResults(
            constraint: CharSequence,
            results: FilterResults
        ) {
            currency.clear()
            currency.addAll(results.values as ArrayList<Values>)
            notifyDataSetChanged()
        }
    }

    class SelectorViewHolder(itemView: View,
                             private val onItemClickListener: ((currency: Values) -> Unit)) : RecyclerView.ViewHolder(itemView) {

        private val code = itemView.label_coin_code
        private val name = itemView.label_coin_name
        private val quote = itemView.label_quote_name

        fun bindView(currency: Values) {
            code.text = currency.code
            name.text = currency.name
            quote.text = currency.value.toString()

            itemView.setOnClickListener {
                onItemClickListener.invoke(currency)
            }
        }
    }
}