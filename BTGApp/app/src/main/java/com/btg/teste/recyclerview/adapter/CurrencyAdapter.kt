package com.btg.teste.recyclerview.adapter

import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import android.view.*
import com.btg.teste.R
import com.btg.teste.databinding.ItemCurrencyBinding
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.recyclerview.viewholder.ListCurrencyViewHolder
import com.btg.teste.viewmodel.Conversion
import com.btg.teste.viewmodel.MoneyConvertViewModel
import retrofit2.Response
import kotlin.collections.ArrayList

class CurrencyAdapter(
    val itens: MutableList<Conversion> = ArrayList(),
    val callback: (conversion: Conversion?) -> Unit
    ) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val binding = DataBindingUtil.inflate<ItemCurrencyBinding>(
            LayoutInflater.from(parent.context),
            R.layout.item_currency,
            parent,
            false
        )
        return ListCurrencyViewHolder(binding)
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ListCurrencyViewHolder) {
            holder.binding.conversion = itens[position]
            holder.binding.cardViewItemCurrency.setOnClickListener {
                callback.invoke(itens[position])
            }
        }
    }

    override fun getItemCount(): Int = itens.size

}