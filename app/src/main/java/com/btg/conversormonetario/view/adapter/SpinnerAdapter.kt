package com.btg.conversormonetario.view.adapter

import android.annotation.SuppressLint
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.View.VISIBLE
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.core.content.ContextCompat
import com.btg.conversormonetario.R
import com.btg.conversormonetario.shared.setOnSingleClickListener
import kotlinx.android.synthetic.main.item_spinner.view.*

class SpinnerAdapter(
    ctx: Context,
    private var fields: ArrayList<String>
) :
    ArrayAdapter<String>(ctx, R.layout.item_spinner, fields) {
    var reasonPosition: (String) -> Unit = { }

    @SuppressLint("ViewHolder")
    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val rowView =
            LayoutInflater.from(context).inflate(R.layout.item_spinner, parent, false)
        val tvwOptionName = rowView.tvwItemSpinnerOption
        val ctlBase = rowView.ctlItemSpinnerBase
        val imvCheck = rowView.imvItemSpinnerCheck

        tvwOptionName.text = fields[position]
        tvwOptionName.setOnSingleClickListener {
            ctlBase.background = ContextCompat.getDrawable(context, R.drawable.bg_item_spinner_touched)
            tvwOptionName.setTextColor(ContextCompat.getColor(context, R.color.ice))
            imvCheck.visibility = VISIBLE

            reasonPosition.invoke(fields[position])
        }
        return rowView
    }

}