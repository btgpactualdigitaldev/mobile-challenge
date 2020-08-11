package com.svm.btgmoneyconverter.view.list

import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.svm.btgmoneyconverter.R
import com.svm.btgmoneyconverter.model.Currency

class CurrencyVH(view: View): RecyclerView.ViewHolder(view) {

    val tvInitials: TextView = view.findViewById(R.id.tvInitials)
    val tvName: TextView = view.findViewById(R.id.tvName)

    fun setAdapterData(currency: Currency){
        tvInitials.text = currency.symbol
        tvName.text = currency.name
    }

}