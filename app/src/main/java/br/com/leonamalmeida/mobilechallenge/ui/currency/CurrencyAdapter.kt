package br.com.leonamalmeida.mobilechallenge.ui.currency

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.data.Currency
import kotlinx.android.synthetic.main.item_currency.view.*

/**
 * Created by Leo Almeida on 28/06/20.
 */

class CurrencyAdapter(private val onCurrencySelected: ((Currency) -> Unit)) :
    RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    var currencies = emptyList<Currency>()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun getItemViewType(position: Int): Int {
        return if (itemCount == 1 && currencies.isEmpty()) CurrencyAdapterType.EMPTY.ordinal
        else CurrencyAdapterType.ITEM.ordinal
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            CurrencyAdapterType.EMPTY.ordinal -> EmptyVH(
                LayoutInflater.from(parent.context).inflate(R.layout.item_empty, parent, false)
            )
            else -> CurrencyVH(
                LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
            )
        }
    }

    override fun getItemCount(): Int = if (currencies.isEmpty()) 1 else currencies.size

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is CurrencyVH)
            holder.bind(currencies[position])
    }

    inner class EmptyVH(itemView: View) : RecyclerView.ViewHolder(itemView)

    inner class CurrencyVH(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(currency: Currency) {
            itemView.run {
                itemCurrencyTv.text = currency.toString()
                setOnClickListener { onCurrencySelected.invoke(currency) }
            }
        }
    }

    enum class CurrencyAdapterType {
        EMPTY, ITEM
    }
}