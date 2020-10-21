package com.romildosf.currencyconverter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.romildosf.currencyconverter.datasource.RemoteCurrencyDataSource
import com.romildosf.currencyconverter.repository.CurrencyRepository
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import org.koin.android.ext.android.inject

class MainActivity : AppCompatActivity() {
    val ds: CurrencyRepository by inject()
    val scope = CoroutineScope(Job() + Dispatchers.Default)
    val TAG = "MAINACTIVITY"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initBtn.setOnClickListener {
            Log.e(TAG, "Clicked")
            scope.launch {
                val cResult = ds.fetchCurrencyList()

                cResult.success?.forEach {
                    Log.e(TAG, "${it.symbol} ${it.fullName}")
                } ?: Log.e(TAG, "Failure CurrencyList", cResult.failure)

                val qResult = ds.fetchCurrencyQuotation("BRL2", "ZWL2")
                qResult.success?.let {
                    Log.e(TAG, "${it.pair} ${it.value}")
                } ?: Log.e(TAG, "Failure Quotation", qResult.failure)
            }
        }
    }
}