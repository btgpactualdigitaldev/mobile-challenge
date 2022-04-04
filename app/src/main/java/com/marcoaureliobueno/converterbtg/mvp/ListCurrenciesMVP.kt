package com.marcoaureliobueno.converterbtg.mvp

import com.marcoaureliobueno.converterbtg.model.Currency
import java.util.*
import kotlin.collections.ArrayList

interface ListCurrenciesMVP{

    interface View{
        fun reordenarAlfabeticoView()
        fun atualizaView()
        fun reordenaPeloCodigo()
    }


    interface Presenter{
        var listacurrencies : java.util.ArrayList<Currency>
        fun reordenarAlfabetico()
        fun reordenaCodigo()
    }


}