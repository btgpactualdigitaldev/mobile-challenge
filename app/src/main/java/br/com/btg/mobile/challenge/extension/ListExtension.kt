package br.com.btg.mobile.challenge.extension

import br.com.btg.mobile.challenge.data.model.Rate

fun List<Rate>.coins(): List<String> = this.map { it.coin.orEmpty() }
