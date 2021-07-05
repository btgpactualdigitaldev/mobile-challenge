package br.com.android.challengeandroid.repository

import br.com.android.challengeandroid.service.APIKEY
import br.com.android.challengeandroid.service.ServiceWeb
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class CoinRepository {

    suspend fun getCoinsList(coinSource: String) =
        withContext(Dispatchers.IO)
        { ServiceWeb.service.getCoins(APIKEY, "", "") }

    suspend fun getPriceByCoin(source: String, destiny: String) =
        withContext(Dispatchers.IO)
        { ServiceWeb.service.getPrice(APIKEY, "", "") }


}
