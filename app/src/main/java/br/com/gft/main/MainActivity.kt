package br.com.gft.main

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.inputmethod.EditorInfo
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.doOnTextChanged
import br.com.gft.R
import br.com.gft.main.PickCurrencyActivity.Companion.CURRENCY_PICKED
import br.com.gft.main.iteractor.model.Currency
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.activity_main.errorMessage
import kotlinx.android.synthetic.main.activity_pick_currency.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class MainActivity : AppCompatActivity() {
    private val viewModel: MainViewModel by viewModel()

    val REQUEST_CURRENCY_FROM = 1
    val REQUEST_CURRENCY_TO = 2

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        makeObservables()

        makeButtonListeners()

        makeListenerOfAmountToConvert()
    }

    private fun makeListenerOfAmountToConvert() {

        amountToConvertText.doOnTextChanged { text, start, before, count ->
            clearResultAmount()
            updateViewModelWithFieldValue(text)
        }
        setSentByKeyboard()

    }
    private fun setSentByKeyboard() {
        amountToConvertText.setOnEditorActionListener { v, actionId, event ->
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                buttonConvertCurrency.performClick()
                true
            } else {
                false
            }
        }
    }

    private fun updateViewModelWithFieldValue(text: CharSequence?) {
        val amount = text.toString().toFloatOrNull()
        if (amount != null) {
            viewModel.amountToConvertLiveData.value = amount
        } else {
            viewModel.amountToConvertLiveData.value = 0f
        }
    }

    private fun clearResultAmount() {
        convertedAmount.text = ""
    }

    private fun makeButtonListeners() {
        val intent = Intent(this, PickCurrencyActivity::class.java)

        buttonChooseCurrencyFrom.setOnClickListener {
            startActivityForResult(intent, REQUEST_CURRENCY_FROM)
        }

        buttonChooseCurrencyTo.setOnClickListener {
            startActivityForResult(intent, REQUEST_CURRENCY_TO)
        }

        buttonConvertCurrency.setOnClickListener {
            viewModel.convertAmountToAnotherCurrency()
        }
    }

    private fun makeObservables() {
        viewModel.loadingLiveData.observe(this, { isLoading ->
            if (isLoading) {
                showLoading()
            } else {
                dismissLoading()
            }
        })

        viewModel.pickedCurrencyFromLiveData.observe(this, { currency ->
            buttonChooseCurrencyFrom.text =
                getString(R.string.from_currency_button_label, currency.name, currency.code)
            couldEnableNextField()
        })

        viewModel.pickedCurrencyToLiveData.observe(this, { currency ->
            buttonChooseCurrencyTo.text =
                getString(R.string.to_currency_button_label, currency.name, currency.code)
            couldEnableNextField()

        })

        viewModel.valueConvertedLiveData.observe(this, { amount ->
            convertedAmount.text = amount.toString()
            buttonConvertCurrency.isEnabled = false
        })

        viewModel.amountToConvertLiveData.observe(this, { amout ->
            buttonConvertCurrency.isEnabled = viewModel.canIEnableButtonConvert()
        })

        viewModel.errorLiveData.observe(this,{error->
            if(error.isNullOrEmpty()){
                errorMessage.visibility=View.GONE
            }else{
                errorMessage.text=error
                errorMessage.visibility = View.VISIBLE
            }
        })
    }

    private fun dismissLoading() {
        progressCircular.visibility = View.GONE
    }

    private fun showLoading() {
        progressCircular.visibility = View.VISIBLE
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            val currency = data?.getSerializableExtra(CURRENCY_PICKED) as Currency

            when (requestCode) {
                REQUEST_CURRENCY_FROM -> {
                    viewModel.pickedCurrencyFromLiveData.postValue(currency)
                }
                REQUEST_CURRENCY_TO -> {
                    viewModel.pickedCurrencyToLiveData.postValue(currency)
                }
            }
        }
    }

    private fun couldEnableNextField() {
        buttonChooseCurrencyTo.isEnabled = viewModel.canIEnableButtonCurrencyTo()
        fieldAmountToConvertInputLayout.isEnabled = viewModel.canIEnableFieldAmountToConvert()
        buttonConvertCurrency.isEnabled = viewModel.canIEnableButtonConvert()
    }
}