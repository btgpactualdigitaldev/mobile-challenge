package com.maskow.currencyconverter.ui.list

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.maskow.currencyconverter.R
import com.maskow.currencyconverter.model.Currency
import com.maskow.currencyconverter.retrofit.Retrofit
import kotlinx.android.synthetic.main.fragment_list.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ListFragment : Fragment() {

    lateinit var currency: Currency

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_list, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        progress_bar_list.visibility = View.VISIBLE
        recycler_view_list.visibility = View.GONE

        val call = Retrofit().currencyService().list()
        call.enqueue(object : Callback<Currency?> {
            override fun onResponse(
                call: Call<Currency?>?,
                response: Response<Currency?>?
            ) {
                response?.body()?.let {
                    currency = it
                    configureList()
                }
            }

            override fun onFailure(call: Call<Currency?>?, t: Throwable?) {
                t?.message?.let {
                    Log.e("onFailure error", it)
                    Toast.makeText(context, "${t.message}", Toast.LENGTH_LONG).show()
                }
            }
        })

        btn_sort_by_name.setOnClickListener {
            val sortedMap = currency.currencies.toList()
                .sortedBy { (_, value) -> value }
                .toMap()

            val currencies = ArrayList<String>()

            for (sorted in sortedMap) {
                currencies.add("(${sorted.key})" + " ${sorted.value}")
            }

            recycler_view_list.adapter = ListAdapter(currencies)
        }

        btn_sort_by_code.setOnClickListener {
            val sortedMap = currency.currencies.toList()
                .sortedBy { (key, _) -> key }
                .toMap()

            val currencies = ArrayList<String>()

            for (sorted in sortedMap) {
                currencies.add("(${sorted.key})" + " ${sorted.value}")
            }

            recycler_view_list.adapter = ListAdapter(currencies)
        }
    }

    private fun configureList() {
        val currencies = ArrayList<String>()

        for (currenc in currency.currencies) {
            currencies.add("(${currenc.key})" + " ${currenc.value}")
        }

        recycler_view_list.adapter = ListAdapter(currencies)
        recycler_view_list.layoutManager = LinearLayoutManager(context)

        progress_bar_list.visibility = View.GONE
        recycler_view_list.visibility = View.VISIBLE
    }
}