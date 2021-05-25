package br.com.btg.test.feature.currency.ui.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import br.com.btg.test.feature.currency.ui.viewholder.CurrencyViewHolder
import br.com.btg.test.R

class CurrenciesListAdapter(
    val list: MutableList<CurrencyEntity>,
    val onClick: ((currencyEntity: CurrencyEntity) -> Unit)?
) :
    RecyclerView.Adapter<CurrencyViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        CurrencyViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.layout_currency_item, parent, false)
        )

    override fun getItemCount() = list.size

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bind(list[position], onClick)
    }
}