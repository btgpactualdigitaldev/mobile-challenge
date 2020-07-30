package br.com.mobilechallenge.presenter.splashscreen

import android.content.Context
import br.com.mobilechallenge.model.splashscreen.Model

class Presenter : MVP.Presenter {
    private lateinit var view: MVP.View
    private val model: MVP.Model = Model(this)

    override val context: Context
        get() = view as Context

    override fun setView(view: MVP.View) { this.view = view }
    override fun retriveData() {
        model.retriveData()
    }

    override fun loadData() {
        view.loadData()
    }
}