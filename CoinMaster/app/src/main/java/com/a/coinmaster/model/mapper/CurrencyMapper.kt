package com.a.coinmaster.model.mapper

import com.a.coinmaster.model.response.CurrencyResponse
import com.a.coinmaster.model.vo.CurrenciesListVO

class CurrencyMapper(): Mapper<CurrencyResponse, CurrenciesListVO> {
    override fun map(from: CurrencyResponse): CurrenciesListVO {
        with(from) {
            return CurrenciesListVO(quotes)
        }
    }
}