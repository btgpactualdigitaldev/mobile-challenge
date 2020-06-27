package com.btg.converter.presentation.view.currency.list

import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import com.btg.converter.domain.entity.currency.Currency

class ListCurrenciesAdapter(
    private val callback: (Currency) -> Unit
) : ListAdapter<Currency, CurrencyViewHolder>(DiffUtilCallback) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder.inflate(parent)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.setupBinding(getItem(position), callback)
    }

    companion object DiffUtilCallback : DiffUtil.ItemCallback<Currency>() {
        override fun areItemsTheSame(oldItem: Currency, newItem: Currency) =
            oldItem.code == newItem.code

        override fun areContentsTheSame(oldItem: Currency, newItem: Currency) =
            oldItem == newItem
    }
}