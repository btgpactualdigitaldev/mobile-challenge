package com.a.coinmaster.usecase

import com.a.coinmaster.model.mapper.Mapper
import com.a.coinmaster.model.response.CurrenciesListResponse
import com.a.coinmaster.model.vo.CurrenciesListVO
import com.a.coinmaster.repository.CoinMasterRepository
import io.reactivex.Single

class GetCurrenciesListUseCase(
    private val repository: CoinMasterRepository,
    private val mapper: Mapper<CurrenciesListResponse, CurrenciesListVO>
) : UseCase<Unit, Single<CurrenciesListVO>> {

    override fun execute(param: Unit): Single<CurrenciesListVO> =
        repository
            .getCurrenciesList()
            .map {
                mapper.map(it)
            }
}