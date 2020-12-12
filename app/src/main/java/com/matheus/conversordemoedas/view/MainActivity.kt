package com.matheus.conversordemoedas.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import com.matheus.conversordemoedas.R
import com.matheus.conversordemoedas.contract.MainContract
import com.matheus.conversordemoedas.presenter.MainPresenter

class MainActivity : AppCompatActivity(), MainContract.View {

    var btnFrom: Button? = null
    var btnTo: Button? = null
    var edtAmount: EditText? = null
    var btnCalc: Button? = null
    var txtResult: TextView? = null
    var PBProgress: ProgressBar? = null

    var currencyCodeFrom: String = ""
    var currencyCodeTo: String = ""

    var currencyDescriptionFrom: String = ""
    var currencyDescriptionTo: String = ""

    var presenter : MainPresenter = MainPresenter()

    companion object{
        val ACTIONFROM = 1
        val ACTIONTO = 2
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupView()

        presenter.setView(this)
    }

    private fun setupView() {
        edtAmount = findViewById(R.id.edtAmount)
        btnCalc = findViewById(R.id.btnCalc)
        btnFrom = findViewById(R.id.btnFrom)
        btnTo = findViewById(R.id.btnTo)
        txtResult = findViewById(R.id.txtResult)
        PBProgress = findViewById(R.id.PBProgress)

        btnFrom!!.setOnClickListener {
            val intent = Intent(this, CurrencyListActivity::class.java)
            startActivityForResult(intent, ACTIONFROM)
        }

        btnTo!!.setOnClickListener {
            val intent = Intent(this, CurrencyListActivity::class.java)
            startActivityForResult(intent, ACTIONTO)
        }

        btnCalc!!.setOnClickListener {
            if (presenter.validConvert(currencyCodeFrom, currencyCodeTo)){
                presenter.convertCurrency(currencyCodeFrom, currencyDescriptionFrom, currencyCodeTo, currencyDescriptionTo)
            }
        }
    }

    override fun showMsgError(msg: String) {
        Toast.makeText(this@MainActivity,  msg, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.onDestroy()
    }

    override fun getValueString(): String {
        return edtAmount!!.text.toString()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        presenter.onActivityResult(requestCode, resultCode, data)
    }

    override fun confirmCurrencyFrom(currencyCode: String, currencyDescription: String) {
        currencyCodeFrom = currencyCode
        currencyDescriptionFrom = currencyDescription
        btnFrom?.setText(currencyCode + " - " + currencyDescription)
    }

    override fun confirmCurrencyTo(currencyCode: String, currencyDescription: String) {
        currencyCodeTo = currencyCode
        currencyDescriptionTo = currencyDescription
        btnTo?.setText(currencyCode + " - " + currencyDescription)
    }

    override fun getContext(): Context {
        return this
    }

    override fun hideProgress() {
        PBProgress!!.visibility = View.GONE
    }

    override fun showProgress() {
        PBProgress!!.visibility = View.VISIBLE
    }

    override fun setResult(text: String){
        txtResult!!.setText(text)
    }

}