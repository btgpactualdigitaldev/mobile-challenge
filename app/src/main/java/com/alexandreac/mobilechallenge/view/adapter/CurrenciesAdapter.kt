package com.alexandreac.mobilechallenge.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import androidx.recyclerview.widget.RecyclerView
import com.alexandreac.mobilechallenge.databinding.CurrencyItemBinding
import com.alexandreac.mobilechallenge.model.data.Currency
import com.alexandreac.mobilechallenge.view.extensions.listen


class CurrenciesAdapter(var items:List<Currency>):RecyclerView.Adapter<CurrenciesAdapter.ViewHolder>(),
                                                                                AdapterItemsContract {
    var onItemClick: ((Currency) -> Unit)? = null
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding: CurrencyItemBinding = CurrencyItemBinding.inflate(inflater,parent,false)
        return ViewHolder(binding)
    }

    override fun getItemCount(): Int {
        return items.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun replaceItems(items: List<*>) {
        this.items = items as List<Currency>
        notifyDataSetChanged()
    }

    inner class ViewHolder(val binding: CurrencyItemBinding):RecyclerView.ViewHolder(binding.root){
        fun bind(currency: Currency){
            binding.currency = currency
            binding.executePendingBindings()
        }

        init {
            itemView.setOnClickListener {
                onItemClick?.invoke(items[adapterPosition])
            }
        }
    }
}
