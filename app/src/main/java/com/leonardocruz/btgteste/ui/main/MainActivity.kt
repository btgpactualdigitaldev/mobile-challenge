package com.leonardocruz.btgteste.ui.main

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.View.VISIBLE
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.leonardocruz.btgteste.ui.currencyList.view.CurrencyActivity
import com.leonardocruz.btgteste.R
import com.leonardocruz.btgteste.databinding.ActivityMainBinding
import com.leonardocruz.btgteste.model.Currencies
import com.leonardocruz.util.Constants.CURRENCY_KEY
import com.leonardocruz.util.Constants.PREFERENCES_RATES
import com.leonardocruz.util.Util
import com.leonardocruz.util.safeDouble
import kotlinx.android.synthetic.main.activity_main.*
import java.text.DecimalFormat

class MainActivity : AppCompatActivity(), View.OnClickListener {
    private val requestCodeFrom = 10
    private val requestCodeTo = 20
    private var currencyFrom: Currencies? = null
    private var currencyTo: Currencies? = null
    private var listRates = mutableListOf<Currencies>()
    private var currentValue: Double = -1.0
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        initViews()
        readShared()
    }

    private fun initViews() {
        binding.tvFrom.setOnClickListener(this)
        binding.tvTo.setOnClickListener(this)
        binding.btConvert.setOnClickListener(this)
    }

    @SuppressLint("SetTextI18n")
    private fun verifyAndConvert() {
        if (!et_currency.text.toString().isNullOrEmpty()) currentValue =
            et_currency.text.toString().safeDouble()
        if (currencyFrom == null || currencyTo == null) {
            Toast.makeText(
                this,
                getString(R.string.msg_currency_empty),
                Toast.LENGTH_SHORT
            ).show()
            return
        }
        if (currentValue <= 0f) {
            Toast.makeText(
                this,
                getString(R.string.msg_value_empty),
                Toast.LENGTH_SHORT
            ).show()
            return
        }
        if(listRates.isNullOrEmpty()){
            Toast.makeText(this, getString(R.string.generic_error), Toast.LENGTH_SHORT).show()
            return
        }
        val result = Util.convertValues(
            currentValue,
            currencyFrom!!.initials,
            currencyTo!!.initials,
            listRates
        )
        val dec = DecimalFormat("#,###,###,###.##")
        binding.tvResult.visibility = VISIBLE
        binding.tvResultTo.text = "${dec.format(result)} ${currencyTo!!.initials}"
    }

    override fun onResume() {
        super.onResume()
        readShared()
    }

    private fun readShared() {
        val listPrefes = Util.readPrefs(this, PREFERENCES_RATES)
        if (listPrefes.isNullOrEmpty()) return
        else listRates = listPrefes
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK && requestCode == 10) {
            currencyFrom = data?.getSerializableExtra(CURRENCY_KEY) as Currencies
            tv_from.text = "${currencyFrom?.initials} - ${currencyFrom?.value}"
        } else if (resultCode == RESULT_OK && requestCode == 20) {
            currencyTo = data?.getSerializableExtra(CURRENCY_KEY) as Currencies
            tv_to.text = "${currencyTo?.initials} - ${currencyTo?.value}"
        }
    }

    override fun onClick(view: View?) {
        when (view) {
            binding.tvFrom -> {
                startActivityForResult(Intent(this, CurrencyActivity::class.java), requestCodeFrom)
            }
            binding.tvTo -> {
                startActivityForResult(Intent(this, CurrencyActivity::class.java), requestCodeTo)
            }
            bt_convert -> {
                verifyAndConvert()
            }
        }
    }
}
