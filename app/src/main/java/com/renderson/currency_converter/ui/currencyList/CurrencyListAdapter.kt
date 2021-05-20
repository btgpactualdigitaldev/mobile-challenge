package com.renderson.currency_converter.ui.currencyList

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.renderson.currency_converter.R
import com.renderson.currency_converter.models.Currency
import kotlinx.android.synthetic.main.item_currency_layout.view.*

class CurrencyListAdapter: RecyclerView.Adapter<CurrencyListAdapter.CurrencyViewHolder>() {

    inner class CurrencyViewHolder(itemView: View): RecyclerView.ViewHolder(itemView)

    private val diffCallback = object : DiffUtil.ItemCallback<Currency>() {
        override fun areItemsTheSame(oldItem: Currency, newItem: Currency): Boolean {
            return oldItem.initials == newItem.initials
        }

        override fun areContentsTheSame(oldItem: Currency, newItem: Currency): Boolean {
            return oldItem.hashCode() == newItem.hashCode()
        }
    }

    private val differ = AsyncListDiffer(this, diffCallback)

    fun submitList(list: List<Currency>) = differ.submitList(list)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder(
            LayoutInflater.from(
                parent.context
            ).inflate(
                R.layout.item_currency_layout,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val item = differ.currentList[position]

        holder.itemView.apply {
            currency.text = item.initials
            country.text = item.name
        }
    }

    override fun getItemCount(): Int {
        return differ.currentList.size
    }
}