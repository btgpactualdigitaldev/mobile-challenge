package com.sugarspoon.desafiobtg.ui.conversion

import android.content.Intent
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.viewModelScope
import com.sugarspoon.data.local.database.BtgDataBase
import com.sugarspoon.data.local.repositories.RepositoryLocal
import com.sugarspoon.data.repositories.ExchangeRateRepository
import com.sugarspoon.desafiobtg.R
import com.sugarspoon.desafiobtg.utils.extensions.setVisible
import com.sugarspoon.desafiobtg.ui.coins.CoinsActivity
import com.sugarspoon.desafiobtg.utils.CurrencyMask
import com.sugarspoon.desafiobtg.utils.DefaultDialogFactory
import com.sugarspoon.desafiobtg.utils.extensions.afterTextChanged
import kotlinx.android.synthetic.main.activity_conversion.*
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import java.util.*

class ConversionActivity : AppCompatActivity() {

    private val database = BtgDataBase.getDatabase(this)
    private val factory = ConversionViewModel.Factory(
        ExchangeRateRepository,
        RepositoryLocal(database.currencyDao(), database.quotationDao())
    )
    private val viewModel by viewModels<ConversionViewModel> { factory }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conversion)
        setupListeners()
        setupObservers()
        viewModel.loadDataOnDb()
    }

    private fun setupListeners() {
        originBt.setOnClickListener {
            startActivityForResult(
                CoinsActivity.intent(this),
                RESULT_FROM_ORIGIN
            )
        }
        destinyBt.setOnClickListener {
            startActivityForResult(
                CoinsActivity.intent(this),
                RESULT_FROM_DESTINY
            )
        }
        insertValueTil.editText?.run {
            addTextChangedListener(
                CurrencyMask.insert(
                    Locale(LANGUAGE, COUNTRY),
                    this
                )
            )
        }
        insertValueTil.editText?.afterTextChanged {
            viewModel.setValueFromConvert(it)
        }
        convertBt.setOnClickListener {
            viewModel.convertCurrency()
        }

    }

    private fun setupObservers() {
        viewModel.run {
            state.observe(this@ConversionActivity, { state ->
                state.run {
                    stateLoading?.run {
                        conversionLoadingPb.setVisible(this)
                        originBt.isEnabled = !this
                        destinyBt.isEnabled = !this
                    }
                    stateOriginText?.run {
                        originCoinTv.text = this
                    }
                    stateDestinyText?.run {
                        destinyCoinTv.text = this
                    }
                    amount?.run {
                        conversionResultTv.text = this
                    }
                    buttonOriginIsVisible?.run {
                        originBt.isEnabled = this
                    }
                    buttonDestinyIsVisible?.run {
                        destinyBt.isEnabled = this
                    }
                    displayError?.run {
                        DefaultDialogFactory.createError(
                            context = this@ConversionActivity,
                            title = getString(R.string.error_dialog_title),
                            body = this
                        ).show()
                    }
                }
            })
        }
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ) {
        super.onActivityResult(
            requestCode,
            resultCode,
            data
        )
        viewModel.onActivityResult(
            requestCode = requestCode,
            resultCode = resultCode,
            data = data
        )
    }

    override fun onPause() {
        super.onPause()
        viewModel.updateData()
    }

    override fun onDestroy() {
        super.onDestroy()
        viewModel.onClear()
    }

    companion object {
        private const val RESULT_FROM_ORIGIN = 100
        private const val RESULT_FROM_DESTINY = 200
        private const val LANGUAGE = "pt"
        private const val COUNTRY = "BR"
    }
}