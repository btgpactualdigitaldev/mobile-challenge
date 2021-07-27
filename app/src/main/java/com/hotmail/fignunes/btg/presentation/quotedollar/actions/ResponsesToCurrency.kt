package com.hotmail.fignunes.btg.presentation.quotedollar.actions

import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.presentation.common.ReadInstanceProperty
import com.hotmail.fignunes.btg.repository.remote.currencies.responses.CurrenciesResponses
import kotlin.reflect.full.memberProperties

class ResponsesToCurrency(private val readInstanceProperty: ReadInstanceProperty) {

    fun execute(response: CurrenciesResponses): List<Currency> {
        return response::class.memberProperties.map {
            Currency(it.name, readInstanceProperty.execute(response, it.name))
        }

    }
}