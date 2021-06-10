package clcmo.com.btgcurrency.view.holder

import android.view.ViewGroup
import clcmo.com.btgcurrency.view.model.CurrencyUI
import java.lang.ref.WeakReference
import androidx.recyclerview.widget.ListAdapter
import clcmo.com.btgcurrency.view.holder.CAdapterDiffUtilItemCallback
import clcmo.com.btgcurrency.view.holder.CViewHolder

typealias CAdapterClickListener = (currencyUI: CurrencyUI) -> Unit

class CAdapter(private val cAdapterClickListener: CAdapterClickListener)
    : ListAdapter<CurrencyUI, CViewHolder>(CAdapterDiffUtilItemCallback()){

    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): CViewHolder =
        CViewHolder(viewGroup)

    override fun onBindViewHolder(viewHolder: CViewHolder, position: Int) {
        viewHolder.bindListener(getItem(position), WeakReference(cAdapterClickListener))
    }
}