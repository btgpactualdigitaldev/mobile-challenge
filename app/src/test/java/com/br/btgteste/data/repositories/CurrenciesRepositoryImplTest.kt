package com.br.btgteste.data.repositories

import com.br.btgteste.data.model.CurrencyListDTO
import com.br.btgteste.data.model.CurrencyPayload
import com.br.btgteste.data.model.ErrorPayload
import com.br.btgteste.data.remote.CurrencyApi
import com.br.btgteste.domain.repository.CurrenciesRepository
import com.br.btgteste.test
import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.verify
import com.nhaarman.mockitokotlin2.whenever
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.MockitoAnnotations.initMocks

class CurrenciesRepositoryImplTest {

    @Mock
    private val api: CurrencyApi = Mockito.mock(CurrencyApi::class.java)

    private lateinit var currenciesRepository: CurrenciesRepository

    @Before
    fun setup() {
        initMocks(this)
        currenciesRepository = CurrenciesRepositoryImpl(api)
    }

    @Test
    fun getCurrencies_whenCalledListCurrencies_ShouldReturnSuccessful() = test {
        lateinit var result: CurrencyListDTO
        arrange {
            whenever(api.getCurrencyList()).doReturn(getCurrencyListResponse())
        }
        act {
            result = currenciesRepository.getCurrencies()
        }
        assert {
            assertEquals(result.success, true)
            verify(api).getCurrencyList()
        }
    }

    private fun getCurrencyListResponse() = CurrencyListDTO(
        true,"sdsds", "sdsdsds", CurrencyPayload(listOf()),
        ErrorPayload(123, "erro")
    )
}