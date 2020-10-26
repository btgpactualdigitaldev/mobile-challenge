package com.marcoaureliobueno.converterbtg.adapter

import android.app.Activity
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.marcoaureliobueno.converterbtg.R
import com.marcoaureliobueno.converterbtg.model.Currency

class MyListAdapter(private val context: Activity, private val title: Array<String>, private val listCurr: ArrayList<Currency>)
    : ArrayAdapter<String>(context, R.layout.custom_list , title) {

    override fun getView(position: Int, view: View?, parent: ViewGroup): View {
        val inflater = context.layoutInflater
        val rowView = inflater.inflate(R.layout.custom_list, null, true)

        val titleText = rowView.findViewById(R.id.title) as TextView
        //val imageView = rowView.findViewById(R.id.icon) as ImageView
        val subtitleText = rowView.findViewById(R.id.description) as TextView

        titleText.text = listCurr[position].code
        //imageView.setImageResource(imgid[position])
        subtitleText.text = listCurr[position].name

        println("inflate  position =" + position  + " code = " + listCurr[position].code + " descrip = " + listCurr[position].name)

        return rowView
    }
}