package com.btgpactual.mobilechallenge.features.converter

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import com.btgpactual.domain.entity.Currency
import com.btgpactual.mobilechallenge.R
import com.btgpactual.mobilechallenge.databinding.ActivityConverterBinding
import com.btgpactual.mobilechallenge.extensions.visible
import com.btgpactual.mobilechallenge.features.listcurrencies.CurrenciesActivity
import com.btgpactual.mobilechallenge.viewmodel.ViewState
import org.koin.android.ext.android.inject
import org.koin.androidx.viewmodel.ext.android.viewModel
import java.lang.NumberFormatException


const val REQUEST_CODE_FROM = 551
const val REQUEST_CODE_TO = 552

class ConverterActivity : AppCompatActivity() {

    private lateinit var binding : ActivityConverterBinding

    private val viewModel : ConverterViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this,R.layout.activity_converter)

        binding.converterButton.setOnClickListener {
            val value = binding.amountEditText.text.toString()
            try{
                val amount = value.toDouble()
                viewModel.converter(amount)
            }catch (e: NumberFormatException){
                binding.amountEditText.error = getString(R.string.error_invalid_amount)
                binding.amountEditText.requestFocus()
            }
        }

        binding.changeCurrencyFromTextView.setOnClickListener {
            getCurrency(REQUEST_CODE_FROM)
        }

        binding.changeCurrencyToTextView.setOnClickListener {
            getCurrency(REQUEST_CODE_TO)
        }

        setupToolbar()
        setupObservers()
    }


    override fun onDestroy() {
        removeObservers()
        super.onDestroy()
    }


    private fun removeObservers() {
        viewModel.conversionData.removeObservers(this)
        viewModel.currencyFromData.removeObservers(this)
        viewModel.currencyToData.removeObservers(this)
    }


    @SuppressLint("SetTextI18n")
    private fun setupObservers() {
        viewModel.conversionData.observe(this, Observer {
            when(it){
                is ViewState.Success -> onSuccess(it.data)
                is ViewState.Failed -> onFailed(it.throwable)
                is ViewState.Loading -> {setVisibilities(showProgressBar = true)}
            }
        })

        viewModel.currencyFromData.observe(this, Observer {
            clearValues()
            binding.currencyFromTextView.text = "${it.code} ${it.name}"
        })

        viewModel.currencyToData.observe(this, Observer {
            clearValues()
            binding.currencyToTextView.text = "${it.code} ${it.name}"
        })
    }

    private fun onFailed(throwable: Throwable) {
        setVisibilities()
        Toast.makeText(this, throwable.message,Toast.LENGTH_LONG).show()
    }

    private fun getCurrency(requestCode : Int){
        startActivityForResult(Intent(this,CurrenciesActivity::class.java),requestCode)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (Activity.RESULT_OK == resultCode){
            val currency: Currency? = data?.extras?.getParcelable("currency")
            currency?.let {
                when(requestCode){
                    REQUEST_CODE_FROM -> {
                        viewModel.setCurrentFrom(it)
                    }
                    REQUEST_CODE_TO -> {
                        viewModel.setCurrentTo(it)
                    }
                }
            }
        }
    }

    fun clearValues(){
        binding.valueOriginTextView.text = ""
        binding.valueResultTextView.text = ""
    }

    @SuppressLint("SetTextI18n")
    private fun onSuccess(data: Double) {
        setVisibilities(showResult = true)
        binding.valueOriginTextView.text = "${binding.amountEditText.text} ${viewModel.currencyFromData.value?.code}"
        binding.valueResultTextView.text = "$data ${viewModel.currencyToData.value?.code}"
    }

    private fun setupToolbar(){
        binding.mainToolbar.setTitle(R.string.title_converter)
        setSupportActionBar(binding.mainToolbar)
    }

    private fun setVisibilities(
        showProgressBar: Boolean = false,
        showResult: Boolean = false
    ) {
        binding.progressBar.visible(showProgressBar)
        binding.resultGroup.visible(showResult)
    }
}
