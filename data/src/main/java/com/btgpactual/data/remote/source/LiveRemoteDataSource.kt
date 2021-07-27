package com.btgpactual.data.remote.source

import com.btgpactual.domain.entity.Quote
import io.reactivex.Single

interface LiveRemoteDataSource{

    fun getLive(apiKey : String) : Single<List<Quote>>

}