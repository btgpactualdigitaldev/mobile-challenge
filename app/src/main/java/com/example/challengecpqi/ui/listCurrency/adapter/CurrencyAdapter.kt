package com.example.challengecpqi.ui.listCurrency.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.example.challengecpqi.R
import com.example.challengecpqi.databinding.ItemCurrencyBinding
import com.example.challengecpqi.model.Currency

class CurrencyAdapter : RecyclerView.Adapter<CurrencyAdapter.ItemViewHolder>() {

    private val list = mutableListOf<Currency>()
    private var callBack : ((data: Currency, position: Int) -> Unit?)? = null

    fun setData(list: List<Currency>) {
        this.list.clear()
        this.list.addAll(list)
        notifyDataSetChanged()
    }

    fun setOnClickListener(onCallBackSaveSuccess: (Currency, Int) -> Unit) {
        this.callBack = onCallBackSaveSuccess
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        return ItemViewHolder (
            DataBindingUtil.inflate(
                LayoutInflater.from(parent.context),
            R.layout.item_currency, parent, false))
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        holder.setData(list[position])
    }

    override fun getItemCount(): Int = list.size

    inner class ItemViewHolder(private var mBinding: ItemCurrencyBinding) : RecyclerView.ViewHolder(mBinding.root) {

        fun setData (currency: Currency) {
            mBinding.currency  = currency

            mBinding.card.setOnClickListener {
                callBack?.invoke(currency, adapterPosition)
            }
        }
    }
}