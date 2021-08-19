package com.example.challengesavio.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.example.challengesavio.R

class CurrenciesAdapter(
    context: Context,
    var dataSource: ArrayList<String>
) : BaseAdapter() {

    private val inflater: LayoutInflater =
        context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater

    override fun getItem(position: Int): String {
        return dataSource[position]
    }

    override fun getCount(): Int {
        return dataSource.size
    }


    fun setCurrencies(dataSource: ArrayList<String>){
        this.dataSource= dataSource
        notifyDataSetChanged()
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getView(position: Int, recycledView: View?, parent: ViewGroup): View {
        val view: View
        val vh: ItemHolder
        if (recycledView == null) {
            view = inflater.inflate(R.layout.item_spinner, parent, false)
            vh = ItemHolder(view)
            view?.tag = vh
        } else {
            view = recycledView
            vh = view.tag as ItemHolder
        }
        vh.label.text = dataSource[position]

        return view
    }

    private class ItemHolder(row: View?) {
        val label: TextView =
            row?.findViewById(R.id.currency_acronym) as TextView
    }

}