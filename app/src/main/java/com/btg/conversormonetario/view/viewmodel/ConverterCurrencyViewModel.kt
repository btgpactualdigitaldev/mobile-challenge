package com.btg.conversormonetario.view.viewmodel

import android.app.Application
import android.os.Bundle
import android.view.View.GONE
import android.view.View.VISIBLE
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.btg.conversormonetario.App
import com.btg.conversormonetario.R
import com.btg.conversormonetario.business.database.DataManager
import com.btg.conversormonetario.business.repository.CurrencyRepository
import com.btg.conversormonetario.shared.toCurrency
import com.btg.conversormonetario.view.activity.ChooseCurrencyActivity
import kotlinx.coroutines.launch
import java.math.BigDecimal

open class ConverterCurrencyViewModel(
    private val currencyRepository: CurrencyRepository,
    val dataManager: DataManager,
    application: Application
) :
    BaseViewModel(dataManager, application) {

    data class ButtonSelection(
        val icon: Int? = null,
        val iconVisibility: Int? = null,
        val nameCurrency: String? = ""
    )

    data class IconValueConterted(var iconOrigin: Int? = null, var iconTarget: Int? = null)
    data class AmountValueConverted(var textColor: Int? = null, val amount: String? = "")

    private val amountValueTyped = MutableLiveData<String>()
    val styleSelectionCurrencyOrigin = MutableLiveData<ButtonSelection>()
    val styleSelectionCurrencyTarget = MutableLiveData<ButtonSelection>()
    val styleIconsCurrencyConverted = MutableLiveData<IconValueConterted>()
    val styleAmountValueConverted = MutableLiveData<AmountValueConverted>()
    val textLoadingAmountField = MutableLiveData<String>()

    fun onViewModelInitiated() {
        if (dataManager.getOriginCurrencyCode() == null && dataManager.getTargetCurrencyCode() == null)
            defaultLayoutStyle()
        else
            setupLayoutStyle()
    }

    private fun defaultLayoutStyle() {
        styleSelectionCurrencyOrigin.value = ButtonSelection(
            icon = null,
            iconVisibility = GONE,
            nameCurrency = currentContext.value!!.getString(R.string.selecione)
        )
        styleSelectionCurrencyTarget.value = ButtonSelection(
            icon = null,
            iconVisibility = GONE,
            nameCurrency = currentContext.value!!.getString(R.string.selecione)
        )
        styleIconsCurrencyConverted.value = IconValueConterted(null, null)
        styleAmountValueConverted.value = AmountValueConverted(
            textColor = R.color.gray,
            amount = currentContext.value!!.getString(R.string.zero)
        )
    }

    private fun setupLayoutStyle() {
        val originCode = dataManager.getOriginCurrencyCode()
        val targetCode = dataManager.getTargetCurrencyCode()

        val iconOrigin = getCurrencyIconByCode(originCode ?: "")
        val iconTarget = getCurrencyIconByCode(targetCode ?: "")

        val nameOrigin = getCurrencyNameByCode(
            originCode ?: currentContext.value!!.getString(R.string.selecione)
        )
        val targetOrigin = getCurrencyNameByCode(
            targetCode ?: currentContext.value!!.getString(R.string.selecione)
        )

        val iconOriginVisibility = if (originCode != null) VISIBLE else GONE
        val iconTargetVisibility = if (targetCode != null) VISIBLE else GONE

        styleSelectionCurrencyOrigin.value = ButtonSelection(
            icon = iconOrigin,
            iconVisibility = iconOriginVisibility,
            nameCurrency = nameOrigin
        )
        styleSelectionCurrencyTarget.value = ButtonSelection(
            icon = iconTarget,
            iconVisibility = iconTargetVisibility,
            nameCurrency = targetOrigin
        )
        styleIconsCurrencyConverted.value = IconValueConterted(iconOrigin, iconTarget)
    }

    fun callServiceGetCurrencyConverted(amountValue: String) {
        textLoadingAmountField.value = "Carregando..."
        val codeOrigin = dataManager.getOriginCurrencyCode() ?: ""
        val targetOrigin = dataManager.getTargetCurrencyCode() ?: ""
        amountValueTyped.value = amountValue
        viewModelScope.launch(webServiceException) {
            currencyRepository.getCurrencyConverted(
                codeOrigin,
                targetOrigin,
                amountValue,
                {
                    hideLoading()
                    updateStyleAmountValue(it.result ?: BigDecimal.ZERO)
                },
                {
                    onErrorResponse(currentContext.value!!, it)
                })
        }
    }

    fun updateSelection() {
        updateStyleSelecionOrigin()
        updateStyleSelectionTarget()
    }

    private fun updateStyleSelectionTarget() {
        val codeTarget = dataManager.getTargetCurrencyCode()
        val iconTargetChoosed = getCurrencyIconByCode(codeTarget ?: "")
        val iconTargetVisibility = if (codeTarget != null) VISIBLE else GONE
        val targetName = getCurrencyNameByCode(
            codeTarget ?: currentContext.value!!.getString(R.string.selecione)
        )
        styleSelectionCurrencyTarget.value = ButtonSelection(
            icon = iconTargetChoosed,
            iconVisibility = iconTargetVisibility,
            nameCurrency = targetName
        )
        styleIconsCurrencyConverted.value?.iconTarget =
            iconTargetChoosed ?: R.drawable.ic_default_currency
    }

    private fun updateStyleSelecionOrigin() {
        val codeOrigin = dataManager.getOriginCurrencyCode()
        val iconOriginChoosed = getCurrencyIconByCode(codeOrigin ?: "")
        val iconOriginVisibility = if (codeOrigin != null) VISIBLE else GONE
        val originName = getCurrencyNameByCode(
            codeOrigin ?: currentContext.value!!.getString(R.string.selecione)
        )
        styleSelectionCurrencyOrigin.value = ButtonSelection(
            icon = iconOriginChoosed,
            iconVisibility = iconOriginVisibility,
            nameCurrency = originName
        )
        styleIconsCurrencyConverted.value?.iconOrigin =
            iconOriginChoosed ?: R.drawable.ic_default_currency
    }

    fun updateStyleAmountValue(amountTyped: BigDecimal) {
        if (amountTyped > BigDecimal.ZERO) {
            styleAmountValueConverted.value =
                AmountValueConverted(
                    textColor = R.color.green,
                    amount = amountTyped.toCurrency(getCodeTargetCurrency())
                )
        } else {
            textLoadingAmountField.value = currentContext.value!!.getString(R.string.zero)
            styleAmountValueConverted.value = AmountValueConverted(
                textColor = R.color.gray,
                amount = currentContext.value!!.getString(R.string.zero)
            )
        }
    }

    private fun getCodeTargetCurrency(): String = dataManager.getTargetCurrencyCode() ?: ""

    fun selectCurrencyOrigin() {
        val bundle = Bundle()
        bundle.putString(CURRENCY_KEY, CURRENCY_ORIGIN)
        navigateTo(ChooseCurrencyActivity::class.java, bundle = bundle)
    }

    fun selectCurrencyTarget() {
        val bundle = Bundle()
        bundle.putString(CURRENCY_KEY, CURRENCY_TARGET)
        navigateTo(ChooseCurrencyActivity::class.java, bundle = bundle)
    }

    fun getUseTerms(): String = App.getInfoCurrencyData()?.terms?.trim() ?: ""

    fun reverseOrderCurrency() {
        val auxOriginCurrency: String
        val auxTargetCurrency: String
        val auxStyleOriginCurrency: ButtonSelection
        val auxStyleTargetCurrency: ButtonSelection

        val originalOriginCurrency = dataManager.getOriginCurrencyCode()
        val originalTargetCurrency = dataManager.getTargetCurrencyCode()

        auxOriginCurrency = originalTargetCurrency ?: ""
        auxTargetCurrency = originalOriginCurrency ?: ""

        dataManager.saveOriginCurrencyCode(auxOriginCurrency)
        dataManager.saveTargetCurrencyCode(auxTargetCurrency)

        val originalOriginSelectionStyle = styleSelectionCurrencyOrigin.value
        val originalTargetSelectionStyle = styleSelectionCurrencyTarget.value

        auxStyleOriginCurrency = originalTargetSelectionStyle ?: ButtonSelection()
        auxStyleTargetCurrency = originalOriginSelectionStyle ?: ButtonSelection()

        styleSelectionCurrencyOrigin.value = auxStyleOriginCurrency
        styleSelectionCurrencyTarget.value = auxStyleTargetCurrency

        onViewModelInitiated()

        callServiceGetCurrencyConverted(amountValueTyped.value ?: "0")
    }
}