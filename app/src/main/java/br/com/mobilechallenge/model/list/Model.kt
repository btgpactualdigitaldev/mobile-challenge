package br.com.mobilechallenge.model.list

import android.os.Handler
import br.com.mobilechallenge.model.CurrenciesDAO
import br.com.mobilechallenge.model.bean.ListBean

import br.com.mobilechallenge.presenter.list.MVP

class Model(private val presenter: MVP.Presenter): MVP.Model {
    override fun retriveData() {
        Handler().postDelayed({
            presenter.showProgressBar(true)

            val repository = CurrenciesDAO(presenter.context)
            val list: MutableList<ListBean> = repository.list()

            repository.close()

            presenter.updateListRecycler(list)
            presenter.showProgressBar(false)
        }, 100)
    }
}