package br.com.rcp.currencyconverter.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.Filter
import android.widget.Filterable
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import br.com.rcp.currencyconverter.R
import br.com.rcp.currencyconverter.database.entities.Currency
import br.com.rcp.currencyconverter.databinding.ItemCurrencyBinding

class CurrencyListAdapter(private val listener: OnItemClickListener) : RecyclerView.Adapter<CurrencyListAdapter.ItemViewHolder>(), AdapterBinder<MutableList<Currency>>, Filterable {
    private val collection  = mutableListOf<Currency>()
    private var filtered    = mutableListOf<Currency>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        return ItemViewHolder(DataBindingUtil.inflate(LayoutInflater.from(parent.context), R.layout.item_currency, parent, false), listener)
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        if (position < filtered.size) {
            holder.binding.currency = filtered[position]
            holder.binding.executePendingBindings()
        }
    }

    override fun getFilter(): Filter {
        return getCustomFilter()
    }

    override fun getItemCount(): Int {
        return filtered.count()
    }

    override fun setData(data: MutableList<Currency>) {
        val result = DiffUtil.calculateDiff(object: DiffUtil.Callback() {
            override fun	getOldListSize() 						= collection.size
            override fun	getNewListSize() 						= data.size
            override fun 	areItemsTheSame(old: Int, new: Int) 	= collection[old].identifier == data[new].identifier
            override fun 	areContentsTheSame(old: Int, new: Int)	= collection[old].identifier == data[new].identifier && collection[old].description == data[new].description
        })

        collection.clear()
        collection.addAll(data)
        filtered.clear()
        filtered.addAll(data)
        result.dispatchUpdatesTo(this)
    }

    private fun getCustomFilter() : Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                constraint?.let {
                    filtered = if (it.isEmpty()) { collection } else { collection.filter { i -> i.identifier.contains(constraint, true) ||  i.description.contains(constraint, true)}.toMutableList() }
                }

                return FilterResults().apply {
                    values  = filtered
                    count   = filtered.size
                }
            }

            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                notifyDataSetChanged()
            }
        }
    }

    interface OnItemClickListener {
        fun onItemClick(view: View, data: Currency)
    }

    class ItemViewHolder(val binding: ItemCurrencyBinding, val listener: OnItemClickListener): RecyclerView.ViewHolder(binding.root), View.OnClickListener {
        init {
            binding.root.setOnClickListener(this)
        }

        override fun onClick(view: View?) {
            listener.onItemClick(view!!, binding.currency!!)
        }
    }
}