package com.br.cambio.customviews

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.br.cambio.R

class DialogSpinnerAdapter(
    private var listItems: List<DialogSpinnerModel>,
    private val context: Context?,
    private val listener: (DialogSpinnerModel) -> Unit
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private lateinit var viewHolder: DialogSpinnerViewHolder

    private var textFont = R.font.text_light

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.item_dialogspinner, parent,false)

        viewHolder = DialogSpinnerViewHolder(view)

        return viewHolder
    }

    override fun getItemCount(): Int = listItems.size

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val value = "${listItems[position].codigo} - ${listItems[position].nome}"

        (holder as DialogSpinnerViewHolder).bindData(value, textFont)

        holder.itemView.setOnClickListener {
            listener(listItems[position])
        }
    }

    fun updateList(listItems: List<DialogSpinnerModel>) {
        this.listItems = listItems
        notifyDataSetChanged()
    }

    fun setTextStyle(textFont: Int) {
        this.textFont = textFont
    }
}