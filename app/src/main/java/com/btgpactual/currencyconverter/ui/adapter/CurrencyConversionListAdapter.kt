package com.btgpactual.currencyconverter.ui.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.ConversionEntity
import com.btgpactual.currencyconverter.util.*
import kotlinx.android.synthetic.main.item_currency_conversion.view.*
import java.util.*

class CurrencyConversionListAdapter(
    private val list: List<ConversionEntity>
) : RecyclerView.Adapter<CurrencyConversionListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_currency_conversion, parent, false)

        return ViewHolder(
            view
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindView(list[position])
    }

    override fun getItemCount(): Int = list.size

    class ViewHolder(
        itemView: View
    ) : RecyclerView.ViewHolder(itemView) {

        private val ivInitialCurrencyFlag: ImageView = itemView.item_currency_conversion_iv_initial_currency_flag
        private val ivFinalCurrencyFlag: ImageView = itemView.item_currency_conversion_iv_final_currency_flag
        private val tvInitialCurrencyValue: TextView = itemView.item_currency_conversion_tv_initial_currency_value
        private val tvFinalCurrencyValue: TextView = itemView.item_currency_conversion_tv_final_currency_value
        private val tvDate: TextView = itemView.item_currency_conversion_tv_last_update_date
        private val tvHour: TextView = itemView.item_currency_conversion_tv_last_update_hour

        @SuppressLint("SetTextI18n")
        fun bindView(conversionEntity: ConversionEntity) {

            val drawable = itemView.context.getDrawable(R.drawable.flag_unk)

            ivInitialCurrencyFlag.setImageDrawable(getFlag(itemView.context,conversionEntity.moedaInicialCodigo.toLowerCase(Locale.getDefault()))?:drawable)
            ivFinalCurrencyFlag.setImageDrawable(getFlag(itemView.context,conversionEntity.moedaFinalCodigo.toLowerCase(Locale.getDefault()))?:drawable)

            tvInitialCurrencyValue.text = "${addCommaCollection(conversionEntity.valorMoedaInicial)} ${conversionEntity.moedaInicialCodigo}"
            tvFinalCurrencyValue.text = "${addCommaCollection(conversionEntity.valorMoedaFinal)} ${conversionEntity.moedaFinalCodigo}"

            tvDate.text = convertMillisToDateFormat(conversionEntity.dataHora)
            tvHour.text = convertMillisToHourFormat(conversionEntity.dataHora)

        }


    }


}