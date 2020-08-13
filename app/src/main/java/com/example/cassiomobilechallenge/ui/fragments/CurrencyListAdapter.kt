package com.example.cassiomobilechallenge.ui.fragments

import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.example.cassiomobilechallenge.R
import com.example.cassiomobilechallenge.interfaces.CurrencyInterface
import com.example.cassiomobilechallenge.models.Currency

class CurrencyListAdapter(
    private val values: ArrayList<Currency>,
    private val currencyInterface: CurrencyInterface
) : RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.fragment_currency, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = values[position]
        holder.idView.text = item.currencyCode
        holder.contentView.text = item.currencyName

        holder.curencyHolder.setOnClickListener {
            currencyInterface.onCurrencyClick(item)
        }
    }

    override fun getItemCount(): Int = values.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val curencyHolder: View = view.findViewById(R.id.currencyHolder)
        val idView: TextView = view.findViewById(R.id.currencyCode)
        val contentView: TextView = view.findViewById(R.id.currencyName)
    }
}