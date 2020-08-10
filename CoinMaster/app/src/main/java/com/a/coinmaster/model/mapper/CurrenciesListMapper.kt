package com.a.coinmaster.model.mapper

import com.a.coinmaster.model.response.CurrenciesListResponse
import com.a.coinmaster.model.vo.CurrenciesListVO

class CurrenciesListMapper : Mapper<CurrenciesListResponse, CurrenciesListVO> {
    override fun map(from: CurrenciesListResponse): CurrenciesListVO {
        with(from) {
            return CurrenciesListVO(currencies)
        }
    }
}