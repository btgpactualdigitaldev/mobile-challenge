package com.sugarspoon.desafiobtg.ui.coins

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.desafiobtg.R
import kotlinx.android.synthetic.main.item_coins.view.*

class CurrencyAdapter(private val onItemClicked: Listener) :
    RecyclerView.Adapter<BaseViewHolder<*>>() {

    var list: MutableList<CurrencyEntity> = mutableListOf()

    fun setCurrencyList(cardList: List<CurrencyEntity>) {
        list.addAll(cardList)
        notifyDataSetChanged()
    }

    override fun onBindViewHolder(holder: BaseViewHolder<*>, position: Int) {
        if (holder is ItemViewHolder) {
            holder.bind(list[position])
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BaseViewHolder<*> {
        return ItemViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.item_coins, parent, false)
        )
    }

    override fun getItemCount() = list.size

    inner class ItemViewHolder(itemView: View) : BaseViewHolder<CurrencyEntity>(itemView) {
        override fun bind(item: CurrencyEntity) {
            itemView.apply {
                item.run {
                    itemNameTv.text = item.name
                    itemCodeTv.text = item.code
                    setOnClickListener {
                        onItemClicked.onItemClicked(item)
                    }
                }
            }
        }
    }

    interface Listener {
        fun onItemClicked(item: CurrencyEntity)
    }
}

abstract class BaseViewHolder<T>(itemView: View) : RecyclerView.ViewHolder(itemView) {
    abstract fun bind(item: T)
}
