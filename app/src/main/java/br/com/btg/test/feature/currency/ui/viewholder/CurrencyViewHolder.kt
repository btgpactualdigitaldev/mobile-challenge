package br.com.btg.test.feature.currency.ui.viewholder

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import kotlinx.android.synthetic.main.layout_currency_item.view.*

class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    fun bind(currencyEntity: CurrencyEntity, onClick: ((currencyEntity: CurrencyEntity) -> Unit)?) {
        itemView.currencyCode.text = currencyEntity.code
        itemView.currencyName.text = currencyEntity.name
        itemView.currency_item_main_layout.setOnClickListener {
            onClick?.invoke(currencyEntity)
        }
    }

}