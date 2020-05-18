package com.btg.teste.moneyConvert

import android.view.View
import com.btg.teste.viewmodel.MoneyConvert

interface MoneyConvertContracts {

    interface MoneyConvertPresenterInput {
        fun startOrigin()

        fun startRecipient()

        fun startCalculate(moneyConvert: MoneyConvert)
    }

    interface MoneyConvertPresenterOutput {

        fun returnErrorMessage(value: Int)

        fun returnValueFinal(value: String)

        fun returnValue(value: String)
    }


    interface MoneyConvertClick {

        fun origin(view: View?)

        fun recipient(view: View?)

        fun calculate(editable: android.text.Editable)
    }
}