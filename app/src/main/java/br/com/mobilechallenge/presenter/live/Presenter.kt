package br.com.mobilechallenge.presenter.live

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View

import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.model.live.Model

class Presenter : MVP.Presenter {
    private lateinit var view: MVP.View
    private val model: MVP.Model = Model(this)

    override val context: Context
        get() = view as Context

    override fun setView(view: MVP.View) { this.view = view }

    override fun showProgressBar(status: Boolean) {
        val visible: Int = if (status) View.VISIBLE else View.GONE
        view.showProgressBar(visible)
    }

    override fun resultData(requestCode: Int, data: Intent?) {
        var item: ListBean? = null
        val bundle: Bundle? = data?.extras
        if (bundle != null) {
            item = bundle.getParcelable("ITEM_RESULT")
        }

        view.resultData(requestCode, item)
    }

    override fun retrieveData(codeFrom: ListBean?, codeTo: ListBean?, amount: Double) {
        model.retrieveData(codeFrom, codeTo, amount)
    }

    override fun resultCalc(price: Double) {
        view.resultCalc(price)
    }
}