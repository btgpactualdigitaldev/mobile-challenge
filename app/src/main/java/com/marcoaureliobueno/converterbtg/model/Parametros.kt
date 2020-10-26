package com.marcoaureliobueno.converterbtg.model

import java.io.Serializable

data class Parametros(val list: ArrayList<Currency>) : Serializable {
    var listCurrency : ArrayList<Currency>? = null
    var currde : String  = "nono"
    var currpara : String = "nono"
    var operacao : String = "nono"

    /*init{
        this.listCurrency = list
        this.currde = currdepass
        this.currpara = currparapass
        this.operacao = operacaopass
    }*/
    //(val list: ArrayList<Currency>, val currdepass: String, val currparapass: String, val operacaopass:String)
}