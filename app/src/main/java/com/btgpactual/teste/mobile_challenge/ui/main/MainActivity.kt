package com.btgpactual.teste.mobile_challenge.ui.main

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.ImageButton
import android.widget.TextView
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.btgpactual.teste.mobile_challenge.R
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.data.preferences.PreferencesData
import com.btgpactual.teste.mobile_challenge.databinding.ActivityMainBinding
import com.btgpactual.teste.mobile_challenge.ui.main.dialog.CurrencyListDialog
import com.btgpactual.teste.mobile_challenge.util.ViewModelProviderFactory
import dagger.android.support.DaggerAppCompatActivity
import java.lang.Exception
import javax.inject.Inject

class MainActivity : DaggerAppCompatActivity(), ISelectedCurrency {

    private val TAG = "MainActivity"

    private lateinit var btOrigin: Button

    private lateinit var btTarget: Button

    private lateinit var etEntryValue: EditText

    private lateinit var txtLastSyncDate: TextView

    private lateinit var txtConvertedValue: TextView

    private var originQuote: Double = 0.0

    private var targetQuote: Double = 0.0

    private var valueUSD: Double = 0.0

    private var convertedValue: Double = 0.0

    lateinit var currencyList: MutableList<CurrencyEntity>

    lateinit var mainViewModel: MainViewModel

    var currencyDialog = CurrencyListDialog()

    @Inject
    lateinit var providerFactory: ViewModelProviderFactory

    @Inject
    lateinit var preferences: PreferencesData

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        mainViewModel = ViewModelProvider(this, providerFactory).get(MainViewModel::class.java)

        setObservers()

        val binding = DataBindingUtil.setContentView<ActivityMainBinding>(this, R.layout.activity_main)

        btOrigin = binding.btOrigin

        btTarget = binding.btTarget

        txtLastSyncDate = binding.txtLastSyncDate

        txtConvertedValue = binding.txtConvertedValue

        etEntryValue = binding.etEntryValue

        etEntryValue.addTextChangedListener(object: TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                takeConversion()
            }

            override fun afterTextChanged(p0: Editable?) {

            }

        })

        btOrigin.setOnClickListener { getCurrency(TypeCurrency.ORIGIN) }

        btTarget.setOnClickListener { getCurrency(TypeCurrency.TARGET) }

        txtLastSyncDate.text = preferences.getLastUpdate()

        startConf()
    }

    private fun startConf() {
        mainViewModel.getCurrencyOrigin(preferences.getOrigin())
        mainViewModel.getOriginQuote(preferences.getOrigin())
        mainViewModel.getCurrencyTarget(preferences.getTarget())
        mainViewModel.getQuotation(preferences.getTarget())
    }

    private fun getCurrency(typeCurrency: TypeCurrency) {
        currencyDialog.setListener(this, typeCurrency)
        currencyDialog.setList(currencyList)
        currencyDialog.show(supportFragmentManager, "currencyListDialog")
    }

    override fun onSelectedCurrency(cod: String, typeCurrency: TypeCurrency) {
        Log.d("MainActivity", "onSelectedCurrency: $cod")
        when(typeCurrency) {
            TypeCurrency.ORIGIN -> {
                preferences.setOrigin(cod)
                mainViewModel.getCurrencyOrigin(cod)
                mainViewModel.getOriginQuote(preferences.getOrigin())
            }
            TypeCurrency.TARGET -> {
                preferences.setTarget(cod)
                mainViewModel.getCurrencyTarget(cod)
                mainViewModel.getQuotation(cod)
            }
        }
        currencyDialog.dismissAllowingStateLoss()
    }

    fun setObservers() {
        mainViewModel.getCurrencyList()?.removeObservers(this)
        mainViewModel.getCurrencyList()?.observe(this, {
            currencyList = it as MutableList<CurrencyEntity>
        })

        mainViewModel.currencyOrigin.removeObservers(this)
        mainViewModel.currencyOrigin.observe(this, {
            btOrigin.text = it.id
        })

        mainViewModel.currencyTarget.removeObservers(this)
        mainViewModel.currencyTarget.observe(this, {
            btTarget.text = it.id
        })

        mainViewModel.currencyQuotation.removeObservers(this)
        mainViewModel.currencyQuotation.observe(this, {
            preferences.setQuotation(it.value.toFloat())
            targetQuote = it.value
            takeConversion()
        })

        mainViewModel.originQuote.removeObservers(this)
        mainViewModel.originQuote.observe(this, {
            originQuote = it.value
            takeConversion()
        })
    }

    private fun takeConversion() {
        var valueToConvert = 0.0
        try {
            valueToConvert = etEntryValue.text.toString().toDouble()
        } catch (ex: Exception) {
            Log.e(TAG, "takeConversion: error converting input", ex)
        }
        valueUSD = (valueToConvert/originQuote)
        convertedValue = valueUSD * targetQuote

        txtConvertedValue.text = convertedValue.toString()
    }
}