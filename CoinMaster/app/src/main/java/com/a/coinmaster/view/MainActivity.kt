package com.a.coinmaster.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.a.coinmaster.MainApplication
import com.a.coinmaster.R
import com.a.coinmaster.extension.changeVisibility
import com.a.coinmaster.model.StateError
import com.a.coinmaster.model.StateLoading
import com.a.coinmaster.model.StateSuccess
import com.a.coinmaster.utils.decimalMaskAutoFormat
import com.a.coinmaster.utils.formatDoubleToString
import com.a.coinmaster.utils.formatStringToDouble
import com.a.coinmaster.view.CoinListActivity.Companion.ITEM_SELECTED_BUNDLE
import com.a.coinmaster.viewmodel.MainViewModel
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_main.btClear
import kotlinx.android.synthetic.main.activity_main.btCoinSource
import kotlinx.android.synthetic.main.activity_main.btCoinTarget
import kotlinx.android.synthetic.main.activity_main.etResult
import kotlinx.android.synthetic.main.activity_main.etValue
import kotlinx.android.synthetic.main.activity_main.flLoading
import javax.inject.Inject

class MainActivity : AppCompatActivity() {

    @Inject
    lateinit var viewModel: MainViewModel

    private val parentLayout: View by lazy { findViewById<View>(android.R.id.content) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        MainApplication.getComponent()?.inject(this)
        setupButtons()
        setupObservable()
        setupTextWatchers()
        showHint(R.string.welcome_message)
    }

    private fun setupTextWatchers() {
        setSourceTextWatcher()
        setTargetTextWatcher()
    }

    private fun setupObservable() {
        setupCurrencyObservable()
        setupTargetValueObservable()
    }

    private fun setupTargetValueObservable() {
        viewModel
            .targetValueLiveData
            .observe({ lifecycle }, {
                etResult.setText(formatDoubleToString(it))
            })
    }

    private fun setupCurrencyObservable() {
        viewModel
            .currencyLiveData
            .observe({ lifecycle }, { state ->
                enableLoading(false)
                when (state) {
                    is StateLoading -> enableLoading(true)
                    is StateSuccess -> viewModel.calculateTargetValue(viewModel.lastSourceValue)
                    is StateError -> showError()
                }
            })
    }

    private fun showError() {
        Snackbar
            .make(parentLayout, getString(R.string.generic_error), Snackbar.LENGTH_LONG)
            .setAction(getString(R.string.try_again)) {
                viewModel.getCurrency()
            }
            .setActionTextColor(ContextCompat.getColor(this, android.R.color.black))
            .show()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                CHOOSE_COIN_SOURCE_REQUEST_CODE -> {
                    getResultData(data)?.let {
                        viewModel.getCurrency(it.first, isSourceCoin = true)
                        showHint(stringRes = R.string.choose_coin_target)
                    }
                }
                CHOOSE_COIN_TARGET_REQUEST_CODE -> {
                    getResultData(data)?.let {
                        viewModel.getCurrency(it.first, isSourceCoin = false)
                    }
                }
                else -> Unit
            }

        }
    }

    private fun showHint(stringRes: Int) {
        Snackbar
            .make(
                parentLayout,
                getString(stringRes),
                Snackbar.LENGTH_LONG
            )
            .setActionTextColor(ContextCompat.getColor(this, android.R.color.white))
            .show()
    }

    private fun getResultData(data: Intent?): Pair<String, String>? =
        data
            ?.getSerializableExtra(ITEM_SELECTED_BUNDLE)
            ?.run {
                if (this is Pair<*, *>) {
                    this as Pair<String, String>
                } else null
            }

    private fun setSourceTextWatcher() {
        var update = false
        val textWatcher = object : TextWatcher {
            override fun afterTextChanged(s: Editable?) = Unit

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) =
                Unit

            override fun onTextChanged(
                text: CharSequence?,
                start: Int,
                before: Int,
                count: Int
            ) {
                if (update) {
                    update = false
                    return
                }

                val decimalFormatted = decimalMaskAutoFormat(text.toString())
                val result = "${viewModel.lastSourceInitial} $decimalFormatted"
                update = true
                etValue.setText(result)
                etValue.setSelection(result.length)
                viewModel.calculateTargetValue(formatStringToDouble(decimalFormatted))
            }
        }
        etValue.addTextChangedListener(textWatcher)
    }

    private fun setTargetTextWatcher() {
        var update = false
        val textWatcher = object : TextWatcher {
            override fun afterTextChanged(s: Editable?) = Unit

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) =
                Unit

            override fun onTextChanged(
                text: CharSequence?,
                start: Int,
                before: Int,
                count: Int
            ) {
                if (update) {
                    update = false
                    return
                }

                val decimalFormatted = decimalMaskAutoFormat(text.toString())
                update = true
                val result = "${viewModel.lastTargetInitial} $decimalFormatted"
                etResult.setText(result)
                etResult.setSelection(result.length)
            }
        }
        etResult.addTextChangedListener(textWatcher)
    }

    private fun enableLoading(isVisible: Boolean) {
        flLoading.changeVisibility(isVisible)
    }

    private fun setupButtons() {
        onSourceButtonClickListener()
        onTargetButtonClickListener()
        onClearButtonClickListener()
    }

    private fun onClearButtonClickListener() {
        btClear.setOnClickListener {
            etValue.setText(formatDoubleToString(ZERO))
        }
    }

    private fun onSourceButtonClickListener() {
        btCoinSource.setOnClickListener {
            val intent = Intent(this, CoinListActivity::class.java)
            startActivityForResult(intent, CHOOSE_COIN_SOURCE_REQUEST_CODE)
        }
    }

    private fun onTargetButtonClickListener() {
        btCoinTarget.setOnClickListener {
            val intent = Intent(this, CoinListActivity::class.java)
            startActivityForResult(intent, CHOOSE_COIN_TARGET_REQUEST_CODE)
        }
    }

    companion object {
        const val CHOOSE_COIN_SOURCE_REQUEST_CODE = 100
        const val CHOOSE_COIN_TARGET_REQUEST_CODE = 200
        const val ZERO = 0.0
    }
}