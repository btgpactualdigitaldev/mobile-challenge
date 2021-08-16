package com.br.cambio.data.repository

import com.br.cambio.data.datasource.RemoteDataSource
import com.br.cambio.data.local.datasource.LocalDataSource
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.repository.CurrencyRepository
import com.br.cambio.presentation.mapper.ExchangePresentation
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import junit.framework.Assert.assertEquals
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Test

@ExperimentalCoroutinesApi
class CurrencyRepositoryTest {

    private val dataSource: RemoteDataSource = mock()
    private val localDataSource: LocalDataSource = mock()

    private val repository: CurrencyRepository by lazy {
        CurrencyRepositoryImpl(dataSource, localDataSource)
    }

    @Test
    fun `When get users from remote data source should return success`() = runBlockingTest {
        // Given
        whenever(dataSource.getCurrencies()).thenReturn(mockResponse())

        // When
        val result = repository.getCurrencies(false)

        // Then
        val data = result as ExchangePresentation.SuccessResponse
        assertEquals(data.items?.get(0)?.codigo, "BRL")
    }

    @Test
    fun `When get currencies from remote data source should return failure`() = runBlockingTest {
        // Given
        whenever(dataSource.getCurrencies()).thenReturn(null)

        // When
        val result = repository.getCurrencies(false)

        // Then
        assertEquals(result, ExchangePresentation.ErrorResponse)
    }

    private fun mockResponse() =
        listOf(
            CurrencyDomain(
                key = "BRL",
                value = "Brazilian Real"
            )
        )

    private fun mockEmptyResponse() = emptyList<CurrencyDomain>()
}