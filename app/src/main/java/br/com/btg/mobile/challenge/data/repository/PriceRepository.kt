package br.com.btg.mobile.challenge.data.repository

import br.com.btg.mobile.challenge.data.model.Price

interface PriceRepository {
    suspend fun getPrices(): List<Price>?
}
