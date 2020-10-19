package com.btgpactual.teste.mobile_challenge.ui.main.dialog

import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.dialog_list_currency_item.view.*

class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    var codCurrency: TextView = itemView.txtCodeCurrencyList
    var descCurrency: TextView = itemView.txtDescCurrencyList
    var itemCurrency: LinearLayout = itemView.llCurrencyItem
}