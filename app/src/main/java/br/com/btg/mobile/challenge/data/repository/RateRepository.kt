package br.com.btg.mobile.challenge.data.repository

import br.com.btg.mobile.challenge.data.model.Rate

interface RateRepository {
    suspend fun getRates(): List<Rate>?
}
