package com.marcoaureliobueno.converterbtg.model

import java.util.ArrayList

class ListCurrenciesResponse(l : ArrayList<Currency>) {
    var lista : ArrayList<Currency>? = null

    init{
        lista = l

    }

}