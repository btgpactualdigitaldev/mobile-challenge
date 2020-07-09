package com.carlos.silva.desafiobtg.ui.adapters

import android.graphics.Movie
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.carlos.silva.desafiobtg.R
import com.carlos.silva.desafiobtg.interfaces.CurrencieClickListener


class CurrencieAdapter(val items: MutableList<Pair<String, String>>) :
    RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private var mOnClickListener: CurrencieClickListener? = null
    private var filteredItems = mutableListOf<Pair<String, String>>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = ItemViewHolder(
        LayoutInflater.from(parent.context).inflate(
            R.layout.list_item,
            parent,
            false
        )
    )

    override fun getItemCount() = if (filteredItems.size > 0) {
        filteredItems.size
    } else {
        items.size
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ItemViewHolder) {
            val item = if (filteredItems.size > 0) {
                filteredItems[position]
            } else {
                items[position]
            }

            holder.bind(item)
            holder.itemView.setOnClickListener {
                mOnClickListener?.onClick(item, it)
            }

        }
    }

    fun setOnClickListener(clickListener: CurrencieClickListener) {
        mOnClickListener = clickListener
    }

    fun filter(s: String) {

        filteredItems = if (s.isEmpty()) {
            items
        } else {
            val filteredList: MutableList<Pair<String, String>> = mutableListOf()
            for (movie in items) {
                if (movie.first.trim().toLowerCase().contains(s.toLowerCase()) ||
                    movie.second.trim().toLowerCase().contains(s.toLowerCase())) {
                    filteredList.add(movie)
                }
            }
            filteredList
        }

        notifyDataSetChanged()

    }

    inner class ItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        val text1 = itemView.findViewById<TextView>(R.id.text1)

        fun bind(item: Pair<String, String>) {
            text1.text = "${item.first} | ${item.second}"
        }
    }

}