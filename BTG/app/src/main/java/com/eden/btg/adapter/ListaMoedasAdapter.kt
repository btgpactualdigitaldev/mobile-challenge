@file:Suppress("NAME_SHADOWING")

package com.eden.btg.adapter

import android.app.Activity.RESULT_OK
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.cardview.widget.CardView
import com.eden.btg.R
import com.eden.btg.http.SetValorEmDollar
import com.eden.btg.model.Moeda


class ListaMoedasAdapter(items: ArrayList<Moeda>, private val ctx: AppCompatActivity) :
    ArrayAdapter<Moeda>(ctx, R.layout.adapter_lista_moedas, items) {

    //view holder is used to prevent findViewById calls
    private class MoedaItemViewHolder {
        internal var sigla: TextView? = null
        internal var nome: TextView? = null
        internal var card: CardView? = null
    }

    override fun getView(i: Int, view: View?, viewGroup: ViewGroup): View {
        var view = view
        val viewHolder: MoedaItemViewHolder

        if (view == null) {
            val inflater = LayoutInflater.from(context)
            view = inflater.inflate(R.layout.adapter_lista_moedas, viewGroup, false)

            viewHolder = MoedaItemViewHolder()
            viewHolder.sigla = view!!.findViewById<View>(R.id.adapter_lista_moeda_txt_sigla) as TextView
            viewHolder.nome = view.findViewById<View>(R.id.adapter_lista_moeda_txt_nome) as TextView
            viewHolder.card = view.findViewById<View>(R.id.adapter_lista_moeda_card) as CardView
        } else {
            viewHolder = view.tag as MoedaItemViewHolder
        }

        val moeda = getItem(i)

        viewHolder.sigla!!.text = moeda!!.sigla
        viewHolder.nome!!.text = moeda.nome

        viewHolder.card!!.setOnClickListener {
            SetValorEmDollar(moeda,ctx).execute()
        }

        view.tag = viewHolder

        return view
    }
}