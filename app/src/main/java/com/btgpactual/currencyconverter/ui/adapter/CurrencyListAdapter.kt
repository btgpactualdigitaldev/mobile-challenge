package com.btgpactual.currencyconverter.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.model.CurrencyModel
import com.btgpactual.currencyconverter.util.getFlag
import kotlinx.android.synthetic.main.item_currency.view.*
import java.util.*

class CurrencyListAdapter(
    private val list: List<CurrencyModel>,
    private val onItemClickListener: (currencyModel: CurrencyModel) -> Unit
) : RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_currency, parent, false)

        return ViewHolder(
            view,
            onItemClickListener
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindView(list[position])
    }

    override fun getItemCount(): Int = list.size

    class ViewHolder(
        itemView: View,
        private val onItemClickListener: (currencyModel: CurrencyModel) -> Unit
    ) : RecyclerView.ViewHolder(itemView) {

        private val ivFlag: ImageView = itemView.item_currency_iv_flag
        private val tvCode: TextView = itemView.item_currency_tv_code
        private val tvName: TextView = itemView.item_currency_tv_name

        fun bindView(currencyModel: CurrencyModel) {
            val drawable = itemView.context.getDrawable(R.drawable.flag_unk)

            ivFlag.setImageDrawable(
                getFlag(itemView.context,currencyModel.codigo.toLowerCase(
                    Locale.getDefault())) ?:drawable)

            tvCode.text = currencyModel.codigo
            tvName.text = currencyModel.nome

            itemView.setOnClickListener {
                onItemClickListener.invoke(currencyModel)
            }
        }
    }
}