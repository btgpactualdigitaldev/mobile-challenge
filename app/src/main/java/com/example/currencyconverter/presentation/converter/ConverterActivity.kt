package com.example.currencyconverter.presentation.converter

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.currencyconverter.R
import com.example.currencyconverter.infrastructure.database.DatabaseInstance
import com.example.currencyconverter.logic.ConverterInteractor
import com.example.currencyconverter.presentation.currencies.CurrenciesActivity
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_converter.*

class ConverterActivity : AppCompatActivity(), ConverterView, MessageView {

    private var converterInteractor : ConverterInteractor? = null
    private val compositeDisposable = CompositeDisposable()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_converter)

        //Scene setup and Dependency injection
        converterInteractor = ConverterInteractor(this as ConverterView, this as MessageView, DatabaseInstance(), compositeDisposable)
        converterInteractor?.onCreate(this)

        originalValueEditText.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {
                converterInteractor?.originalValueChanged(p0?.toString() ?: "")
            }
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(resultCode== Activity.RESULT_OK) converterInteractor?.treatActivityResult(requestCode, resultCode, data)
    }

    override fun setOriginalValueText(text: String) {
        originalValueEditText.setText(text)
    }

    override fun onOriginalCurrencyButtonClick(view: View) {
        converterInteractor?.selectOriginalCurrency()
    }

    override fun onConvertedCurrencyButtonClick(view: View) {
        converterInteractor?.selectTargetCurrency()
    }

    override fun onConvertButtonClick(view: View) {
        converterInteractor?.convert()
    }

    override fun setOriginalCurrencyButtonText(text: String) {
        originalCurrencyButton.text = text
    }

    override fun setConvertedCurrencyButtonText(text: String) {
        convertedCurrencyButton.text = text
    }

    override fun setConvertedValueText(text : String) {
        convertedValueTextView.text = text
    }

    override fun showCurrencyList(requestCode: Int) {
        startActivityForResult(Intent(this, CurrenciesActivity::class.java), requestCode)
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        converterInteractor?.onDestroy()
        super.onDestroy()
    }
}
