package br.com.mobilechallenge.presenter.live

import android.content.Context
import android.content.Intent

import br.com.mobilechallenge.model.bean.ListBean

class MVP {
    interface Model {
        fun retrieveData(codeFrom: ListBean?, codeTo: ListBean?, amount: Double)
    }

    interface Presenter {
        val context: Context
        fun setView(view: View)
        fun showProgressBar(status: Boolean)
        fun resultData(requestCode: Int, data: Intent?)
        fun retrieveData(codeFrom: ListBean?, codeTo: ListBean?, amount: Double)
        fun resultCalc(price: Double)
    }

    interface View {
        fun showProgressBar(visible: Int)
        fun resultData(requestCode: Int, item: ListBean?)
        fun resultCalc(price: Double)
    }
}