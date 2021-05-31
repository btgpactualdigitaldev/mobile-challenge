package com.example.desafiobtg.network.api

import org.koin.core.KoinComponent
import org.koin.core.get

object BtgApiService: KoinComponent{

    private val builder = get<ApiBuilder>()
    val btgApi: EndPoint = builder.getBtgClient().create(EndPoint::class.java)
}