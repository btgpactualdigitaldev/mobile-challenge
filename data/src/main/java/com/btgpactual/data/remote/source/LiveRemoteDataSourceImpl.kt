package com.btgpactual.data.remote.source

import com.btgpactual.data.remote.api.CurrencyLayerApi
import com.btgpactual.data.remote.mapper.QuotePayloadMapper
import com.btgpactual.domain.entity.Quote
import io.reactivex.Single

class LiveRemoteDataSourceImpl(val api: CurrencyLayerApi) : LiveRemoteDataSource {
    override fun getLive(apiKey: String): Single<List<Quote>> {
        return api.getLive(apiKey).flatMap {response ->
            Single.create<List<Quote>>{ emitter ->
                if (response.success) {
                    emitter.onSuccess(QuotePayloadMapper.map(response.quotes.payloads))
                }else{
                    emitter.onError(Throwable("${response.error?.code} - ${response.error?.info}"))
                }
            }
        }
    }

}