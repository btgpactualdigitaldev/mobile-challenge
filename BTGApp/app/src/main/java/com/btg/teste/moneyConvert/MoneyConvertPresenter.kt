package com.btg.teste.moneyConvert

import android.app.Activity
import android.view.View
import com.btg.teste.R
import com.btg.teste.components.notNull
import com.btg.teste.utils.MoneyFormact
import com.btg.teste.viewmodel.MoneyConvert
import java.lang.Exception
import java.math.RoundingMode
import javax.inject.Inject

class MoneyConvertPresenter(
    activity: Activity,
    view: View,
    private val iMoneyConvertPresenterOutput: MoneyConvertContracts.MoneyConvertPresenterOutput
) : MoneyConvertContracts.MoneyConvertPresenterInput {

    @Inject
    lateinit var moneyConvertRouter: MoneyConvertRouter

    init {
        DaggerMoneyConvertComponents
            .builder()
            .moneyConvertModule(MoneyConvertModule(activity, view, moneyConvertPresenter = this))
            .build()
            .inject(this)
    }

    override fun startOrigin() {
        try {
            moneyConvertRouter.navigationToConvertListOrigin()
        } catch (ex: Exception) {
        }
    }

    override fun startRecipient() {
        try {
            moneyConvertRouter.navigationToConvertListRecipient()
        } catch (ex: Exception) {
        }
    }

    override fun startCalculate(moneyConvert: MoneyConvert) {
        if (moneyConvert.origin.notNull() &&
            moneyConvert.destination.notNull() &&
            moneyConvert.value.isNotEmpty()
        ) {

            val resultCalculate = (moneyConvert.destination!!.value /
                    moneyConvert.origin!!.value).times(
                moneyConvert.value.toDouble()
            )

            iMoneyConvertPresenterOutput.returnValueFinal(
//                MoneyFormact.mask(result)
                resultCalculate.toBigDecimal().setScale(3, RoundingMode.UP).toString()
            )
        } else if (moneyConvert.value.isNotEmpty() && moneyConvert.origin == null) {
            iMoneyConvertPresenterOutput.returnErrorMessage(R.string.error_value_origin)
        } else if (moneyConvert.value.isNotEmpty() && moneyConvert.destination == null) {
            iMoneyConvertPresenterOutput.returnErrorMessage(R.string.error_value_recipient)
        }
    }
}
