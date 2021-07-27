package io.felipeandrade.currencylayertest.ui.currency.selection

import android.content.Context
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import android.graphics.drawable.GradientDrawable
import android.graphics.drawable.ShapeDrawable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import io.felipeandrade.currencylayertest.R
import io.felipeandrade.domain.CurrencyModel
import kotlinx.android.synthetic.main.currency_list_item.view.*


class CurrencyListAdapter : RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {


    private var elements: List<CurrencyModel> = listOf()
    private var filteredElements: List<CurrencyModel> = listOf()

    var onItemClicked: (CurrencyModel) -> Unit = {}

    override fun getItemCount(): Int = filteredElements.size
    override fun getItemViewType(position: Int): Int = R.layout.currency_list_item

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(parent.inflate(viewType))

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
        holder.bind(filteredElements[position], position, onItemClicked)

    fun setData(newElements: List<CurrencyModel>?) {
        elements = newElements?.sortedBy { it.symbol } ?: listOf()
        removeFilter()
        notifyDataSetChanged()
    }

    fun setFilter(query: String?) {
        if (query == null || query.trim() == "") {
            removeFilter()
            return
        }

        filteredElements = elements.filter {
            it.symbol.contains(query, true) ||
            it.name.contains(query, true)
        }

        notifyDataSetChanged()
    }

    private fun removeFilter() {
        filteredElements = elements.toMutableList()
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(
            currency: CurrencyModel,
            position: Int,
            onItemClicked: (CurrencyModel) -> Unit
        ) {
            itemView.apply {
                tv_currency_symbol.text = currency.symbol
                tv_currency_name.text = currency.name

                paintBackground(context, tv_currency_symbol.background, randomColor(position))

                setOnClickListener { onItemClicked(currency) }
            }
        }

        private fun paintBackground(context: Context, background: Drawable, bgColor: Int) {
            when (background) {
                is ShapeDrawable -> background.paint.color =
                    ContextCompat.getColor(context, bgColor)
                is GradientDrawable -> background.setColor(ContextCompat.getColor(context, bgColor))
                is ColorDrawable -> background.color = ContextCompat.getColor(context, bgColor)
            }
        }

        private fun randomColor(position: Int): Int {

            val colorList = arrayListOf(
                R.color.portrait_blue,
                R.color.portrait_red,
                R.color.portrait_orange,
                R.color.portrait_purple,
                R.color.portrait_teal
            )

            val index = position % colorList.size

            return colorList[index]
        }
    }
}

fun ViewGroup.inflate(@LayoutRes layoutRes: Int, attachToRoot: Boolean = false): View {
    return LayoutInflater.from(context).inflate(layoutRes, this, attachToRoot)
}