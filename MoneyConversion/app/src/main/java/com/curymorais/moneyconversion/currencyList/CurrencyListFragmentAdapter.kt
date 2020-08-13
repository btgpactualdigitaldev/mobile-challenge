package com.curymorais.moneyconversion.currencyList

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.recyclerview.widget.RecyclerView
import com.curymorais.moneyconversion.R
import com.curymorais.moneyconversion.currencyConversion.ConversionFragment
import com.curymorais.moneyconversion.data.local.Conversion

class CurrencyListFragmentAdapter(code: Int, activity: FragmentActivity?) : RecyclerView.Adapter<CurrencyListFragmentAdapter.ViewHolder>() {

    private var code = code
    private var activity = activity
    private var currencyNameArray : ArrayList<String> = ArrayList()
    private var currencyValueArray : ArrayList<String> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.list_item_coin, parent, false))
    }

    override fun getItemCount(): Int {
        return currencyNameArray.size
    }

    override fun onBindViewHolder(view: ViewHolder, position: Int) {
        view.code.text = currencyNameArray[position]
        view.country.text = currencyValueArray[position]

        view.item.setOnClickListener {
            Log.i("CURY", "Clicou ${view.code.text}")

            if(code == 1) {
                Conversion.firstCurrency = view.code.text.toString()
            } else {
                Conversion.secondCurrency = view.code.text.toString()
            }

            val myFragment: Fragment = ConversionFragment()
            activity?.supportFragmentManager?.beginTransaction()?.replace(R.id.container, myFragment)?.addToBackStack(null)?.commit()
        }
    }

    fun updateList(currency: HashMap<String, String>){
        this.currencyNameArray.addAll(currency.keys)
        if (currency.values != null) {
            this.currencyValueArray.addAll(currency.values)
        }
        notifyDataSetChanged()
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val code: TextView = itemView.findViewById(R.id.item_coin_code_value)
        val country: TextView = itemView.findViewById(R.id.item_coin_name_value)
        val item: ConstraintLayout = itemView.findViewById(R.id.list_item_coin)
    }
}