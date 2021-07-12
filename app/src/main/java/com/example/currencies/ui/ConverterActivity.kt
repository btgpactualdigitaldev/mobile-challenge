// Franz Blauth Ximenes
// franz@wolppi.com
// Desafio - BTG 12/07/2021

package com.example.currencies.ui

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.currencies.R

class ConverterActivity : AppCompatActivity() {

    lateinit var mConverterViewModel: ConverterViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.converter_activity)

        mConverterViewModel = ViewModelProvider(this).get(ConverterViewModel::class.java)

        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.container, ConverterFragment.newInstance())
                .commitNow()
        }
        observe()
        mConverterViewModel.checkCheckConnection()

    }

    private fun observe(){

        mConverterViewModel.connection.observe(this, androidx.lifecycle.Observer {
            if (it) {
                loadRemoteCurrencies()
                loadRemoteRates()
            } else {
                mConverterViewModel.dialogMessage(getString(R.string.no_connection), this)
            }
        })

        mConverterViewModel.onFailureMessage.observe(this, Observer {
            mConverterViewModel.dialogMessage(it, this)
        })
    }

    private fun loadRemoteCurrencies() {
        mConverterViewModel.loadCurrenciesRemote()
    }

    private fun loadRemoteRates() {
        mConverterViewModel.loadRatesRemote()
    }

}