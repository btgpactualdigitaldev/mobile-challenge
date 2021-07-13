package com.example.desafiobtg.entity

import com.orm.SugarRecord
import com.orm.dsl.Table
import com.orm.dsl.Unique

@Table
class CoinEntity: SugarRecord {

    @Unique
    var cod: String? = null
    var name: String? = null

    constructor()
    constructor(cod: String?, name: String?): super(){
        this.cod = cod
        this.name = name
    }

}