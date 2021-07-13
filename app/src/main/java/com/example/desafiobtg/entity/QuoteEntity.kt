package com.example.desafiobtg.entity

import com.orm.SugarRecord
import com.orm.dsl.Table
import com.orm.dsl.Unique

@Table
class QuoteEntity: SugarRecord {

    @Unique
    var cod: String? = null
    var value: Double? = null

    constructor()
    constructor(cod: String?, value: Double?): super(){
        this.cod = cod
        this.value = value
    }

}