package com.maskow.currencyconverter.ui.list

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.maskow.currencyconverter.R
import kotlinx.android.synthetic.main.currency_list_item.view.*

class ListAdapter(private var currencies: ArrayList<String>) :
    RecyclerView.Adapter<ListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val itemView = LayoutInflater.from(parent.context)
            .inflate(R.layout.currency_list_item, parent, false)
        return ViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindView(currencies[position])
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bindView(currency: String) {
            val title = itemView.txt_list_item
            title.text = currency
        }

    }

}