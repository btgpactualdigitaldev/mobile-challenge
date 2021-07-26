package fps.daniel.conversormoedas.viewmodel

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import fps.daniel.conversormoedas.R
import fps.daniel.conversormoedas.enity.CurrencyLayer

class CurrencyAdapter (private val context: Context, private val currencyList: ArrayList<CurrencyLayer>) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.view_currency, parent, false)
        return ViewHolder(v)
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        bindCellViewHolder(holder as ViewHolder, position)
    }

    fun bindCellViewHolder(holder: ViewHolder, index: Int) {
        holder.cellLayout.tag = currencyList[index]
        holder.currencySymbol.text = currencyList[index].symbol
        holder.currencyName.text = currencyList[index].name
    }

    override fun getItemCount(): Int {
        return currencyList.size
    }

    class ViewHolder internal constructor(v: View) : RecyclerView.ViewHolder(v) {
        internal var currencySymbol: TextView
        internal var currencyName: TextView
        internal var cellLayout: LinearLayout

        init {
            currencySymbol = v.findViewById(R.id.codigoMoeda)
            currencyName = v.findViewById(R.id.nomeMoeda)
            cellLayout = v.findViewById(R.id.currencyLayout)
        }
    }
}