package com.btg.conversormonetario.view.activity

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.view.View.*
import androidx.core.content.ContextCompat
import androidx.core.text.HtmlCompat
import com.btg.conversormonetario.R
import com.btg.conversormonetario.shared.observeNonNull
import com.btg.conversormonetario.view.viewmodel.ConverterCurrencyViewModel
import com.btg.conversormonetario.view.watcher.AmountCurrencyFieldWatcher
import kotlinx.android.synthetic.main.activity_converter_currency.*

class ConverterCurrencyActivity : BaseActivity<ConverterCurrencyViewModel>() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_converter_currency)

        setupLayout()
        initObservers()
        initListeners()
    }

    override fun onStart() {
        super.onStart()
        viewModel.updateSelection()
    }

    private fun setupLayout() {
        tvwConverterCurrencyTermosUso.text =
            HtmlCompat.fromHtml(getString(R.string.termos_de_uso), HtmlCompat.FROM_HTML_MODE_LEGACY)
    }

    private fun initListeners() {
        edtConverterCurrency.addTextChangedListener(AmountCurrencyFieldWatcher(viewModel))
    }

    private fun initObservers() {
        viewModel.onViewModelInitiated()

        viewModel.styleSelectionCurrencyOrigin.observeNonNull(this) {
            updateSelecionButtonCurrencyOrigin(it)
        }

        viewModel.styleSelectionCurrencyTarget.observeNonNull(this) {
            updateSelecionButtonCurrencyTarget(it)
        }

        viewModel.styleIconsCurrencyConverted.observeNonNull(this) {
            updateIconsCurrencyConverted(it.iconOrigin, it.iconTarget)
        }

        viewModel.styleAmountValueConverted.observeNonNull(this) {
            updateValueConverted(it)
        }

        viewModel.textLoadingAmountField.observeNonNull(this) {
            tvwConverterCurrencyValueAmountConverted.text = it
        }
    }

    private fun updateValueConverted(model: ConverterCurrencyViewModel.AmountValueConverted?) {
        tvwConverterCurrencyValueAmountConverted.text = model?.amount ?: "0,00"
        tvwConverterCurrencyValueAmountConverted.setTextColor(
            ContextCompat.getColor(
                this,
                model?.textColor ?: R.color.gray
            )
        )
    }

    fun selectOriginCurrency(v: View) {
        viewModel.selectCurrencyOrigin()
    }

    fun selectTargetCurrency(v: View) {
        viewModel.selectCurrencyTarget()
    }

    private fun updateSelecionButtonCurrencyOrigin(model: ConverterCurrencyViewModel.ButtonSelection) {
        if (model.icon == null) {
            imvConverterCurrencyOriginCurrencyIcon.visibility = GONE
        } else {
            imvConverterCurrencyOriginCurrencyIcon.setImageDrawable(
                ContextCompat.getDrawable(this, model.icon)
            )
            imvConverterCurrencyOriginCurrencyIcon.visibility = VISIBLE
        }
        tvwConverterCurrencyOriginCurrencyName.text = model.nameCurrency
    }

    private fun updateSelecionButtonCurrencyTarget(model: ConverterCurrencyViewModel.ButtonSelection) {
        if (model.icon == null) {
            imvConverterCurrencyTargetCurrencyIcon.visibility = GONE
        } else {
            imvConverterCurrencyTargetCurrencyIcon.setImageDrawable(
                ContextCompat.getDrawable(this, model.icon)
            )
            imvConverterCurrencyTargetCurrencyIcon.visibility = VISIBLE
        }

        tvwConverterCurrencyTargetCurrencyName.text = model.nameCurrency
    }

    private fun updateIconsCurrencyConverted(iconOrigin: Int?, iconTarget: Int?) {
        if (iconOrigin != null) {
            imvConverterCurrencyIconCountryAmountOrigin.setImageDrawable(
                ContextCompat.getDrawable(this, iconOrigin)
            )
            imvConverterCurrencyIconCountryAmountOrigin.visibility = VISIBLE
        } else {
            imvConverterCurrencyIconCountryAmountOrigin.visibility = INVISIBLE
        }

        if (iconTarget != null) {
            imvConverterCurrencyIconCountryAmountTarget.setImageDrawable(
                ContextCompat.getDrawable(this, iconTarget)
            )
            imvConverterCurrencyIconCountryAmountArrow.visibility = VISIBLE
            imvConverterCurrencyIconCountryAmountTarget.visibility = VISIBLE
        } else {
            imvConverterCurrencyIconCountryAmountArrow.visibility = INVISIBLE
            imvConverterCurrencyIconCountryAmountTarget.visibility = INVISIBLE
        }
    }

    fun onShowUseTerms(v: View) {
        val intent = Intent(Intent.ACTION_VIEW)
        intent.data = Uri.parse(viewModel.getUseTerms())
        startActivity(intent)
    }

    fun onReverseOrderCurrency(v: View) {
        viewModel.reverseOrderCurrency()
    }
}