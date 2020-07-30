package br.com.mobilechallenge.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

import br.com.mobilechallenge.R
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.view.ListActivity

class ItemAdapter(private val activity: ListActivity,
                  private val list: MutableList<ListBean>) : RecyclerView.Adapter<ItemAdapter.ViewHolder>()  {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater
            .from(parent.context)
            .inflate(R.layout.item_list, parent, false)
        return ViewHolder(this, view)
    }

    override fun getItemCount(): Int = list.size

    override fun getItemId(position: Int): Long = list[position].id.toLong()

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item: ListBean = getItem(position)

        holder.apply {
            itemText.text = "${item.code} - ${item.description}"
        }
    }

    fun getItem(position: Int): ListBean = list[position]

    fun result(item: ListBean) { activity.result(item) }

    class ViewHolder(itemAdapter: ItemAdapter, itemView: View): RecyclerView.ViewHolder(itemView) {
        val itemText: TextView = itemView.findViewById(R.id.itemText)
        val itemCard: LinearLayout = itemView.findViewById(R.id.itemCad)

        init {
            itemCard.setOnClickListener {
                itemAdapter.result(itemAdapter.getItem(adapterPosition))
            }
        }
    }
}