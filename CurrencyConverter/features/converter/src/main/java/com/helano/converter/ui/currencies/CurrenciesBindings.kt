package com.helano.converter.ui.currencies

import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import com.helano.converter.adapters.CurrenciesAdapter
import com.helano.shared.model.Currency

@BindingAdapter("app:items")
fun setItems(listView: RecyclerView, items: List<Currency>?) {
    items?.let {
        (listView.adapter as CurrenciesAdapter).submitList(items)
    }
}