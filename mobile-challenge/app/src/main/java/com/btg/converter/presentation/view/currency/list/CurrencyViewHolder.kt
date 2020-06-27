package com.btg.converter.presentation.view.currency.list

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.btg.converter.R
import com.btg.converter.databinding.ItemCurrencyBinding
import com.btg.converter.domain.entity.currency.Currency

class CurrencyViewHolder(
    private var binding: ItemCurrencyBinding
) : RecyclerView.ViewHolder(binding.root) {

    fun setupBinding(item: Currency, callback: (Currency) -> Unit) {
        with(binding) {
            textViewCurrencyName.text = item.getFormattedString(root.context)
            root.setOnClickListener { callback(item) }
        }
    }

    companion object {
        fun inflate(parent: ViewGroup?) = CurrencyViewHolder(
            DataBindingUtil.inflate(
                LayoutInflater.from(parent?.context),
                R.layout.item_currency,
                parent,
                false
            )
        )
    }
}