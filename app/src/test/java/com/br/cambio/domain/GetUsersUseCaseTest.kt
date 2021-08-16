package com.br.cambio.domain

import com.br.cambio.customviews.DialogSpinnerModel
import com.br.cambio.domain.repository.CurrencyRepository
import com.br.cambio.domain.usecase.GetCurrenciesUseCase
import com.br.cambio.presentation.mapper.ExchangePresentation
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Test
import kotlin.test.assertEquals

@ExperimentalCoroutinesApi
class GetUsersUseCaseTest {

    private val repository: CurrencyRepository = mock()
    private val useCase: GetCurrenciesUseCase = GetCurrenciesUseCase(repository)

    @Test
    fun `when invoke should return list`() = runBlockingTest {
        // Given
        whenever(repository.getCurrencies(false)).thenReturn(mockResponse())

        // When
        val result = useCase.invoke(false)

        // Then
        assertEquals(result, mockResponse())
    }

    @Test
    fun `when invoke should return empty list`() = runBlockingTest {
        // Given
        whenever(repository.getCurrencies(false)).thenReturn(mockEmptyResponse())

        // When
        val result = useCase.invoke(false)

        // Then
        assertEquals(result, ExchangePresentation.EmptyResponse)
    }

    @Test
    fun `when invoke should return throwable`() = runBlockingTest {
        // Given
        whenever(repository.getCurrencies(false)).thenReturn(ExchangePresentation.ErrorResponse)

        // When
        val result = useCase.invoke(false)

        // Then
        assertEquals(result, ExchangePresentation.ErrorResponse)
    }

    private fun mockResponse() =
        ExchangePresentation.SuccessResponse(
            listOf(
                DialogSpinnerModel(
                    codigo = "BRL",
                    nome = "Brazilian Real"
                )
            )
        )

    private fun mockEmptyResponse() = ExchangePresentation.EmptyResponse
}