package clcmo.com.btgcurrency.view.holder

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import clcmo.com.btgcurrency.view.holder.CAdapterClickListener
import clcmo.com.btgcurrency.R
import clcmo.com.btgcurrency.view.model.CurrencyUI
import kotlinx.android.synthetic.main.c_item_view.view.*
import java.lang.ref.WeakReference

class CViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    constructor(viewGroup: ViewGroup) : this(LayoutInflater
        .from(viewGroup.context)
        .inflate(R.layout.c_item_view, viewGroup, false)
    )

    fun bindListener(currencyUI: CurrencyUI, clickListener: WeakReference<CAdapterClickListener>) =
        with(itemView){
            idTV.text = currencyUI.id
            nameTV.text = currencyUI.name
            currencyVH.setOnClickListener{
                clickListener.get()?.invoke(currencyUI)
            }
        }
}