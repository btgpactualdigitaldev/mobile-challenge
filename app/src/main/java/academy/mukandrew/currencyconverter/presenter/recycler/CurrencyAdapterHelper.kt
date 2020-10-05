package academy.mukandrew.currencyconverter.presenter.recycler

import academy.mukandrew.currencyconverter.presenter.models.CurrencyUI
import androidx.recyclerview.widget.DiffUtil

typealias CurrencyAdapterClickListener = (currencyUI: CurrencyUI) -> Unit

class CurrencyAdapterDiffUtil : DiffUtil.ItemCallback<CurrencyUI>() {

    override fun areItemsTheSame(oldItem: CurrencyUI, newItem: CurrencyUI): Boolean {
        return oldItem.code == newItem.code
    }

    override fun areContentsTheSame(oldItem: CurrencyUI, newItem: CurrencyUI): Boolean {
        return oldItem == newItem
    }
}