package com.br.cambio.customviews

import android.view.View
import android.widget.Button
import androidx.core.content.res.ResourcesCompat
import androidx.recyclerview.widget.RecyclerView
import com.br.cambio.R

class DialogSpinnerViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    var btDialogSpinnerItem: Button? = itemView.findViewById(R.id.btDialogSpinnerItem)

    fun bindData(data: String?, font: Int) {
        btDialogSpinnerItem?.run {
            typeface = ResourcesCompat.getFont(context, font)
            text = data
        }
    }

}