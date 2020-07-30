package br.com.mobilechallenge.presenter.splashscreen

import android.content.Context

class MVP {
    interface Model {
        fun retriveData()
    }

    interface Presenter {
        val context: Context
        fun setView(view: View)
        fun retriveData()
        fun loadData()
    }

    interface View {
        fun loadData()
    }
}