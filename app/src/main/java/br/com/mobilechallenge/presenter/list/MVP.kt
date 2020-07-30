package br.com.mobilechallenge.presenter.list

import android.content.Context
import br.com.mobilechallenge.model.bean.ListBean

class MVP {
    interface Model {
        fun retriveData()
    }

    interface Presenter {
        val context: Context
        val items: MutableList<ListBean>
        fun setView(view: View)
        fun showProgressBar(status: Boolean)
        fun retriveData()
        fun updateListRecycler(list: MutableList<ListBean>)
    }

    interface View {
        fun showProgressBar(visible: Int)
        fun updateListRecycler()
    }
}