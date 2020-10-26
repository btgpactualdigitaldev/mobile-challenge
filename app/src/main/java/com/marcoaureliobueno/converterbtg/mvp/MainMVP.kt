package com.marcoaureliobueno.converterbtg.mvp

import android.content.BroadcastReceiver
import androidx.appcompat.view.menu.MenuAdapter
import com.marcoaureliobueno.converterbtg.model.Currency
import com.marcoaureliobueno.converterbtg.model.ListCurrenciesResponse
import com.marcoaureliobueno.converterbtg.model.ResultadoConversao
import kotlinx.coroutines.Deferred

interface MainMVP {
    interface View {
        fun converte()
        fun validaCampos() : Boolean
        fun retornaValorResultado(valor : Double)

    }
    interface Presenter {

        //fun getMenus(): List<Menu>
        //fun getQuickAccessMenus(): List<Menu>
        fun checkInternet()
        fun listCurrencies(): Deferred<ListCurrenciesResponse>
        fun getListaCurrencies(): ArrayList<Currency>
        //val networkReceiver: BroadcastReceiver
        fun setLit(list: ArrayList<Currency>)
        fun enviaParaConverter(currdeenvia : String, currparaenvia : String, valorenvia : String): Deferred<ResultadoConversao>
    }

}