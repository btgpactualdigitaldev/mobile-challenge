package com.vald3nir.btg_challenge.ui.home

import android.content.Intent
import android.os.Bundle
import androidx.core.widget.doOnTextChanged
import com.vald3nir.btg_challenge.core.base.BaseActivity
import com.vald3nir.btg_challenge.databinding.ActivityHomeBinding
import com.vald3nir.btg_challenge.extensions.animateRotate90Degrees
import com.vald3nir.btg_challenge.ui.currencies.CurrenciesFragmentDialog
import kotlinx.android.synthetic.main.activity_home.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class HomeActivity : BaseActivity() {

    companion object {

        fun startHomeActivity(activity: BaseActivity) {
            val intent = Intent(activity, HomeActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            activity.startActivity(intent)
        }
    }

    private lateinit var activityBinding: ActivityHomeBinding
    private val viewModel by viewModel<HomeViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        activityBinding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(activityBinding.root)

        initObservers()
        viewModel.initCurrencies()
    }

    private fun initObservers() {

        imvChangeCurrencies?.setOnClickListener {
            viewModel.changeCurrencies()
            imvChangeCurrencies.animateRotate90Degrees()
        }

        tilInputValue.editText?.doOnTextChanged { text, _, _, _ ->
            viewModel.updateInputValue(text.toString().trim())
            viewModel.calculateConversion()
        }

        tilInputValue.setEndIconOnClickListener {
            tilInputValue.editText?.setText("")
        }

        viewModel.loadCurrenciesFinished.observe(this, {
            activityBinding.model = viewModel
            viewModel.calculateConversion()
        })

        viewModel.calculateInputValueConversion.observe(this, {
            txvValueConverted?.text = it.toString()
        })

        viewModel.selectInputCurrency.observe(this, {
            showAlertDialog(object : CurrenciesFragmentDialog.ICurrenciesFragmentDialog {
                override fun onClickCurrency(code: String?) {
                    viewModel.updateInputCurrency(code)
                }
            })
        })

        viewModel.selectOutputCurrency.observe(this, {
            showAlertDialog(object : CurrenciesFragmentDialog.ICurrenciesFragmentDialog {
                override fun onClickCurrency(code: String?) {
                    viewModel.updateOutputCurrency(code)
                }
            })
        })
    }

    private fun showAlertDialog(listener: CurrenciesFragmentDialog.ICurrenciesFragmentDialog) {
        CurrenciesFragmentDialog.showDialog(this, listener)
    }
}