package br.com.rcp.currencyconverter

import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import br.com.rcp.currencyconverter.adapters.AdapterBinder

@Suppress("UNCHECKED_CAST")
@BindingAdapter("android:data")
fun <T> RecyclerView.setData(data: T) {
    if (adapter is AdapterBinder<*>) {
        (adapter as AdapterBinder<T>).setData(data)
    }
}