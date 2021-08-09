package com.matheus.conversordemoedas.adapter

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.matheus.conversordemoedas.R
import com.matheus.conversordemoedas.model.CurrencyResult
import java.util.regex.Pattern

class CurrencyListAdapter(private var activity: Activity, private var items: ArrayList<CurrencyResult>): BaseAdapter(){

    private var searchEnabled = false
    private var searchTerm: String? = null
    private val filteredItems: ArrayList<CurrencyResult> = ArrayList<CurrencyResult>()

    private class ViewHolder(row: View?) {
        var txtCode: TextView? = null
        var txtDescription: TextView? = null

        init {
            this.txtCode = row?.findViewById(R.id.textCode)
            this.txtDescription = row?.findViewById(R.id.textDescription)
        }
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: ViewHolder
        if (convertView == null) {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.item_currencylist, null)
            viewHolder = ViewHolder(view)
            view?.tag = viewHolder
        } else {
            view = convertView
            viewHolder = view.tag as ViewHolder
        }

        if (searchEnabled){
            val item : CurrencyResult = filteredItems[position]
            viewHolder.txtCode?.text = item.code
            viewHolder.txtDescription?.text = item.description
        } else {
            val item: CurrencyResult = items[position]
            viewHolder.txtCode?.text = item.code
            viewHolder.txtDescription?.text = item.description
        }
        return view as View
    }

    override fun getItem(position: Int): CurrencyResult {
        if(searchEnabled) {
            return filteredItems[position]
        }
        return items[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        if(searchEnabled) {
            return filteredItems.size;
        }
        return items.size
    }

    fun setSearchEnabled(enabled: Boolean, text: String) {
        searchEnabled = enabled
        if (!searchEnabled) {
            searchTerm = ""
            filteredItems.clear()
            notifyDataSetChanged()
            return
        }
        searchTerm = text.toLowerCase()
        filter()
    }

    private fun filter() {
        filteredItems.clear()
        if (searchTerm!!.length == 0) {
            filteredItems.addAll(items)
        } else {
            for (row in items) {
                if (Pattern.compile(Pattern.quote(searchTerm), Pattern.CASE_INSENSITIVE).matcher(row.code).find()) {
                    filteredItems.add(row)
                } else if (Pattern.compile(Pattern.quote(searchTerm), Pattern.CASE_INSENSITIVE).matcher(row.description).find()) {
                    filteredItems.add(row)
                }
            }
        }
        notifyDataSetChanged()
    }

}