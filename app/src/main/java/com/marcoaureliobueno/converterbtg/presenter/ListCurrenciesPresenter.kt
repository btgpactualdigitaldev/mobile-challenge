package com.marcoaureliobueno.converterbtg.presenter

import android.widget.ListView
import com.marcoaureliobueno.converterbtg.model.Currency
import com.marcoaureliobueno.converterbtg.mvp.ListCurrenciesMVP
import com.marcoaureliobueno.converterbtg.mvp.MainMVP
import com.marcoaureliobueno.converterbtg.view.ListCurrenciesActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import java.lang.ref.WeakReference
import java.util.ArrayList
import kotlin.coroutines.CoroutineContext

class ListCurrenciesPresenter (
    view : ListCurrenciesMVP.View
) : ListCurrenciesMVP.Presenter, CoroutineScope {
    override val coroutineContext: CoroutineContext = Dispatchers.Main
    private val view: WeakReference<ListCurrenciesMVP.View> = WeakReference(view)

    override var listacurrencies = ArrayList<Currency>()
    override fun reordenarAlfabetico() {
        listacurrencies.sortBy { it.name }
        view.get()?.atualizaView()
    }
    override fun reordenaCodigo(){
        listacurrencies.sortBy { it.code }
        view.get()?.atualizaView()
    }

}