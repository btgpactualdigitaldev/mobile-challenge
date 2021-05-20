package com.br.mobilechallenge.view.currencies.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.br.mobilechallenge.R
import com.br.mobilechallenge.model.MappingObject
import com.br.mobilechallenge.view.currencies.adapter.viewholder.CurrenciesViewHolder

class CurrenciesAdapter(val currencyList: ArrayList<MappingObject>) :
    RecyclerView.Adapter<CurrenciesViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrenciesViewHolder {

        val view =
            LayoutInflater
                .from(parent.context)
                .inflate(R.layout.cardview_currencies, parent, false)

        return CurrenciesViewHolder(view)

    }

    override fun getItemCount(): Int = currencyList.size

    override fun onBindViewHolder(
        holder: CurrenciesViewHolder,
        position: Int) {

        val currency = currencyList.elementAt(position)

        holder.currencyCode.text = currency.key
        holder.currencyName.text = currency.value.toString()




    }
}