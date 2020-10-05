package academy.mukandrew.currencyconverter.presenter.recycler

import academy.mukandrew.currencyconverter.presenter.models.CurrencyUI
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter

import java.lang.ref.WeakReference

class CurrencyAdapter(
    private val onItemClickListener: CurrencyAdapterClickListener
) : ListAdapter<CurrencyUI, CurrencyViewHolder>(CurrencyAdapterDiffUtil()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder(parent)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bind(getItem(position), WeakReference(onItemClickListener))
    }

}