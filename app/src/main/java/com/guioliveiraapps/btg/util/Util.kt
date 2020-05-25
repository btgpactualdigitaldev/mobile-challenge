package com.guioliveiraapps.btg.util

import android.content.Context
import android.graphics.Color
import android.net.ConnectivityManager
import android.net.NetworkInfo
import android.view.View
import android.widget.TextView
import com.google.android.material.snackbar.Snackbar
import com.guioliveiraapps.btg.R
import com.guioliveiraapps.btg.room.Currency
import com.guioliveiraapps.btg.room.Quote

class Util {

    companion object {

        fun getCurrenciesFromResponse(currencies: Map<String, String>): List<Currency> {
            val res: MutableList<Currency> = mutableListOf()
            for (c: Map.Entry<String, String> in currencies) {
                res.add(Currency(c))
            }
            return res
        }

        fun getQuotesFromResponse(quotes: Map<String, Double>): List<Quote> {
            val res: MutableList<Quote> = mutableListOf()
            for (q: Map.Entry<String, Double> in quotes) {
                res.add(Quote(q))
            }
            return res
        }

        fun hasConnectionToInternet(context: Context): Boolean {
            val cm: ConnectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetwork: NetworkInfo? = cm.activeNetworkInfo
            return activeNetwork?.isConnectedOrConnecting == true
        }

        fun showErrorSnackBar(view: View) {
            val snackbar: Snackbar =
                Snackbar.make(view, R.string.app_error, Int.MAX_VALUE)
                    .setBackgroundTint(Color.RED)
                    .setTextColor(Color.WHITE)

            val snackTextView: TextView =
                snackbar.view.findViewById(com.google.android.material.R.id.snackbar_text)

            snackTextView.maxLines = 10
            snackbar.show()        }

    }
}