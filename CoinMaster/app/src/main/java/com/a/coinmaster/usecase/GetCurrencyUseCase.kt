package com.a.coinmaster.usecase

import com.a.coinmaster.model.mapper.Mapper
import com.a.coinmaster.model.response.CurrencyResponse
import com.a.coinmaster.model.vo.CurrenciesListVO
import com.a.coinmaster.repository.CoinMasterRepository
import io.reactivex.Single

class GetCurrencyUseCase(
    private val repository: CoinMasterRepository,
    private val mapper: Mapper<CurrencyResponse, CurrenciesListVO>
) : UseCase<String, Single<CurrenciesListVO>> {

    override fun execute(coin: String): Single<CurrenciesListVO> =
        repository
            .getCurrency(coin)
            .map {
                mapper.map(it)
            }
}