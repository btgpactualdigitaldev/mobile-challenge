package br.com.btg.mobile.challenge.data.repository

import br.com.btg.mobile.challenge.data.model.Price
import br.com.btg.mobile.challenge.data.remote.MobileChallengeApi
import br.com.btg.mobile.challenge.extension.async

class PriceRepositoryImp(private val api: MobileChallengeApi) : PriceRepository {
    override suspend fun getPrices(): List<Price>? = async { api.getPrices().data }
}
