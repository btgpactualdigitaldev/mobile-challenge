package com.a.coinmaster.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.a.coinmaster.R
import kotlinx.android.synthetic.main.item_view_coin_list.view.*

class CoinListAdapter(
    val coinList: MutableList<Pair<String, String>> = mutableListOf(),
    val onItemSelected: OnItemSelected
) : RecyclerView.Adapter<CoinListAdapter.CoinViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CoinViewHolder {
        val itemView = LayoutInflater
            .from(parent.context)
            .inflate(R.layout.item_view_coin_list, parent, false)
        return CoinViewHolder(itemView)
    }

    override fun getItemCount(): Int = coinList.size

    override fun onBindViewHolder(holder: CoinViewHolder, position: Int) {
        holder.bindViewHolder(coinList[position])
    }

    inner class CoinViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bindViewHolder(item: Pair<String, String>) {
            itemView.tvInitialsValue.text = item.first
            itemView.tvCoinValue.text = item.second
            setOnClickListener(item)
        }

        private fun setOnClickListener(item: Pair<String, String>) {
            itemView.setOnClickListener {
                it.isSelected = it.isSelected.not()
                onItemSelected.onSelected(item)
            }
        }
    }
}