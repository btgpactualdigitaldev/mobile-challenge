package com.br.btgteste.domain.usecase

import com.br.btgteste.data.model.CurrencyLiveDTO
import com.br.btgteste.data.model.ErrorPayload
import com.br.btgteste.data.model.QuotePayload
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository
import com.br.btgteste.test
import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.verify
import com.nhaarman.mockitokotlin2.whenever
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.MockitoAnnotations.initMocks

class CurrencyLiveUseCaseTest  {

    private lateinit var currencyLiveUseCaseMock: CurrencyLiveUseCase

    @Mock
    private lateinit var currenciesRepositoryMock: CurrenciesRepository

    @Before
    fun setup() {
        initMocks(this)
        currencyLiveUseCaseMock = Mockito.spy(CurrencyLiveUseCase(currenciesRepositoryMock))
    }

    @Test
    fun executeAsyncTasks_WhenSuccessful_ShouldReturnResponse() = test {
        lateinit var result: ApiResult<Double>

        val request = createCurrencyLiveRequest()
        val response = createCurrencyLive()
        val resultConverter = 12.0

        act {
            whenever(currenciesRepositoryMock.convertCurrencies()).doReturn(response)
            whenever(currencyLiveUseCaseMock.convertResponse(request, response)).doReturn(resultConverter)
        }
        arrange {
            result = currencyLiveUseCaseMock.executeAsyncTasks(request)
        }
        assert {
            verify(currencyLiveUseCaseMock).convertResponse(any(), any())
            assertEquals(result is ApiResult.Success<*>, true)
        }
    }

    private fun createCurrencyLiveRequest() = CurrencyLiveUseCase.Params(12.0,
        Currency("USDAA", "Pais 1"), Currency("USDBB", "Pais 2"))

    private fun createCurrencyLive() = CurrencyLiveDTO(true,
        "", "", "", "", QuotePayload(listOf()),
        ErrorPayload(123, "erro"))

}