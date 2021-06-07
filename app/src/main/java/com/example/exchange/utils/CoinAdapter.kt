package com.example.exchange.utils

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.exchange.R
import com.example.exchange.model.CoinDetails

class CoinAdapter(private val listCoinDetails: List<CoinDetails>) : RecyclerView.Adapter<CoinAdapter.ViewHolder>() {

    inner class ViewHolder(listItemView: View) : RecyclerView.ViewHolder(listItemView) {
        val abbreviation: TextView = itemView.findViewById(R.id.textview_abbreviation)
        val description: TextView = itemView.findViewById(R.id.textview_description)

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CoinAdapter.ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.recycler_item, parent, false))
    }

    override fun onBindViewHolder(viewHolder: CoinAdapter.ViewHolder, position: Int) {
        val coinDetails: CoinDetails = listCoinDetails[position]

        viewHolder.abbreviation.text = coinDetails.abbreviation
        viewHolder.description.text = coinDetails.description
    }

    override fun getItemCount(): Int {
        return listCoinDetails.size
    }
}