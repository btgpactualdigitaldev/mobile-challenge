package com.btg.converter.presentation.view.converter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import com.btg.converter.R
import com.btg.converter.databinding.ActivityConverterBinding
import com.btg.converter.domain.entity.currency.Conversion
import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.presentation.util.base.BaseActivity
import com.btg.converter.presentation.util.base.BaseViewModel
import com.btg.converter.presentation.util.constants.TWO_DECIMAL_NUMBER
import com.btg.converter.presentation.util.extension.observe
import com.btg.converter.presentation.util.extension.onTextChanges
import com.btg.converter.presentation.util.extension.setSafeClickListener
import com.btg.converter.presentation.view.currency.list.ListCurrenciesActivity
import com.btg.converter.presentation.view.currency.list.ListCurrenciesActivity.Companion.CURRENCY_EXTRA
import org.koin.android.viewmodel.ext.android.viewModel

class ConverterActivity : BaseActivity() {

    override val baseViewModel: BaseViewModel get() = _viewModel
    private val _viewModel: ConverterViewModel by viewModel()

    private lateinit var binding: ActivityConverterBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_converter)
        setupUi()
    }

    override fun subscribeUi() {
        super.subscribeUi()
        _viewModel.placeholder.observe(this) { binding.placeholderView.setPlaceholder(it) }
        _viewModel.conversion.observe(this, ::onConversionReceived)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                ORIGIN_CURRENCY_CODE -> {
                    val originCurrency = data?.getSerializableExtra(CURRENCY_EXTRA) as? Currency
                    _viewModel.conversionForm.originCurrency = originCurrency
                    binding.originCurrencyText = originCurrency?.getFormattedString(this)
                }
                DESTINATION_CURRENCY_CODE -> {
                    val destinationCurrency =
                        data?.getSerializableExtra(CURRENCY_EXTRA) as? Currency
                    _viewModel.conversionForm.destinationCurrency = destinationCurrency
                    binding.destinationCurrencyText = destinationCurrency?.getFormattedString(this)
                }
            }
        }
    }

    private fun setupUi() {
        with(binding) {
            textInputConversionValue.onTextChanges(_viewModel::setConversionValue)
            originCoinChooser.root.setSafeClickListener { chooseCurrency(ORIGIN_CURRENCY_CODE) }
            originCurrencyText = getString(R.string.hint_origin_currency)
            destinationCoinChooser.root.setSafeClickListener {
                chooseCurrency(
                    DESTINATION_CURRENCY_CODE
                )
            }
            destinationCurrencyText = getString(R.string.hint_destination_currency)
            buttonConvert.setSafeClickListener { _viewModel.performConversion() }
        }
    }

    private fun chooseCurrency(resultCode: Int) {
        startActivityForResult(
            ListCurrenciesActivity.createIntent(this),
            resultCode
        )
    }

    private fun onConversionReceived(conversion: Conversion?) {
        conversion?.let {
            with(binding) {
                textViewConvertedValue.text = String.format(TWO_DECIMAL_NUMBER, it.convertedValue)
                textViewOriginCurrency.text = it.originCurrency?.name ?: ""
                textViewDestinationCurrency.text = it.destinationCurrency?.name ?: ""
            }
        }
    }

    companion object {
        const val ORIGIN_CURRENCY_CODE = 123
        const val DESTINATION_CURRENCY_CODE = 321

        fun createIntent(context: Context) = Intent(context, ConverterActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
    }
}