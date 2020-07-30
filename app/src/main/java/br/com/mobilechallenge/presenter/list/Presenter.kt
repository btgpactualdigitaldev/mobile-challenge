package br.com.mobilechallenge.presenter.list

import android.content.Context
import android.view.View
import br.com.mobilechallenge.model.bean.ListBean

import br.com.mobilechallenge.model.list.Model

class Presenter : MVP.Presenter {
    private lateinit var view: MVP.View

    private val model: MVP.Model = Model(this)
    private var list: MutableList<ListBean> = emptyList<ListBean>().toMutableList()

    override val context: Context
        get() = view as Context
    override val items: MutableList<ListBean>
        get() = list

    override fun setView(view: MVP.View) { this.view = view }
    override fun showProgressBar(status: Boolean) {
        val visible: Int = if (status) View.VISIBLE else View.GONE
        view.showProgressBar(visible)
    }

    override fun retriveData() {
        model.retriveData()
    }

    override fun updateListRecycler(list: MutableList<ListBean>) {
        this.list.clear()
        this.list.addAll(list)
        view.updateListRecycler()
    }
}