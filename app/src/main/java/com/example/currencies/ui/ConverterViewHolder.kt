package com.example.currencies.ui

import android.view.View
import android.widget.TableRow
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.currencies.R
import com.example.currencies.listener.EventListener
import com.example.currencies.model.room.CurrenciesModelLocal

class ConverterViewHolder(itemView: View, val listener: EventListener) : RecyclerView.ViewHolder(itemView) {

    private var mAbbrevCurrency: TextView = itemView.findViewById(R.id.abbrev_currency)
    private var mNameCurrency: TextView = itemView.findViewById(R.id.name_currency)
    private var mTableRow: TableRow = itemView.findViewById(R.id.row_currencies)

    fun bindData(model: CurrenciesModelLocal) {

        mAbbrevCurrency.text = model.abbrev
        mNameCurrency.text = model.currency

        mTableRow.setOnClickListener {
            listener.onListClick(model.abbrev, model.currency)
        }
    }
}