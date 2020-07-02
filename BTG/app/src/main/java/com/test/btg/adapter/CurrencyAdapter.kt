package com.test.btg.adapter

import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

class CurrencyAdapter(private val listCurrency: Map<String, Double>) :
    RecyclerView.Adapter<CurrencyHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        CurrencyHolder.newInstance(parent)

    override fun getItemCount(): Int = listCurrency.size

    override fun onBindViewHolder(holder: CurrencyHolder, position: Int) =
        holder.bind(
            listCurrency.keys.elementAt(position),
            listCurrency.values.elementAt(position)
        )
}