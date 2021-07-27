package com.btgpactual.data.remote.source

import com.btgpactual.data.remote.api.CurrencyLayerApi
import com.btgpactual.data.remote.mapper.CurrencyPayloadMapper
import com.btgpactual.domain.entity.Currency
import io.reactivex.Single

class ListRemoteDataSourceImpl(
    private val api : CurrencyLayerApi
) : ListRemoteDataSource{
    override fun getCurrencies(apiKey : String): Single<List<Currency>> {
        return api.getList(apiKey).flatMap {response ->
            Single.create<List<Currency>>{emitter ->
                if (response.success) {
                    emitter.onSuccess(CurrencyPayloadMapper.map(response.currencies.payloads))
                }else{
                    emitter.onError(Throwable("${response.error?.code} - ${response.error?.info}"))
                }
            }
        }
    }

}