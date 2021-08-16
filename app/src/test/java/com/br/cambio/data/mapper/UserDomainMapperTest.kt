package com.br.cambio.data.mapper

import com.br.cambio.data.model.Currency
import com.br.cambio.domain.model.CurrencyDomain
import org.junit.Test
import kotlin.test.assertEquals

class UserDomainMapperTest {

    private val mapper: CurrencyToDomainMapper = CurrencyToDomainMapper()

    @Test
    fun `when mapper should map to presentation`() {
        // When
        val result = mapper.map(mockResponse())

        // Then
        assertEquals(listOf(result), mockExpected())
    }

    private fun mockResponse() =
        Currency(
            key = "BRL",
            value = "Brazilian Real"
        )

    private fun mockExpected() =
        listOf(
            CurrencyDomain(
                key = "BRL",
                value = "Brazilian Real"
            )
        )
}