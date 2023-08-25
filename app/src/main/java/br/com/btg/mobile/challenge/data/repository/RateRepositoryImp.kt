package br.com.btg.mobile.challenge.data.repository

import br.com.btg.mobile.challenge.data.model.Rate
import br.com.btg.mobile.challenge.data.remote.MobileChallengeApi
import br.com.btg.mobile.challenge.extension.async

class RateRepositoryImp(private val api: MobileChallengeApi) : RateRepository {
    override suspend fun getRates(): List<Rate>? = async { api.getRates().data }
}
