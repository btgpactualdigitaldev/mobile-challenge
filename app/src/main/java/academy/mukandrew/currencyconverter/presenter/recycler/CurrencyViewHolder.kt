package academy.mukandrew.currencyconverter.presenter.recycler

import academy.mukandrew.currencyconverter.R
import academy.mukandrew.currencyconverter.presenter.models.CurrencyUI
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.view_currency_item.view.*
import java.lang.ref.WeakReference

class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    constructor(parent: ViewGroup) : this(
        LayoutInflater.from(parent.context).inflate(
            R.layout.view_currency_item,
            parent,
            false
        )
    )

    fun bind(
        item: CurrencyUI,
        clickListener: WeakReference<CurrencyAdapterClickListener>
    ) = with(itemView) {
        codeValue.text = item.code
        nameValue.text = item.name
        currencyViewHolder.setOnClickListener {
            clickListener.get()?.invoke(item)
        }
    }
}