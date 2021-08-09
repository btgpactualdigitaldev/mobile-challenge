package com.matheus.conversordemoedas.contract

import android.content.Context
import android.content.Intent

interface MainContract {

    interface View {
        fun showMsgError(msg: String)
        fun getValueString(): String
        fun confirmCurrencyFrom(currencyCode: String, currencyDescription: String)
        fun confirmCurrencyTo(currencyCode: String, currencyDescription: String)
        fun getContext(): Context
        fun showProgress()
        fun hideProgress()
        fun setResult(text: String)
    }

    interface Presenter {
        fun setView(view: View)
        fun convertCurrency(codeFrom: String, descriptionFrom: String, codeTo: String, descriptionTo: String)
        fun validConvert(from: String, to: String) : Boolean
        fun onDestroy()
        fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?)
    }

}