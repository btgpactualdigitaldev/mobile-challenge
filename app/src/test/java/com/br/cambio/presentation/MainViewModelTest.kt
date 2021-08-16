package com.br.cambio.presentation

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.br.cambio.customviews.DialogSpinnerModel
import com.br.cambio.domain.usecase.GetCurrenciesUseCase
import com.br.cambio.domain.usecase.GetPricesUseCase
import com.br.cambio.presentation.mapper.ExchangePresentation
import com.br.cambio.presentation.viewmodel.MainViewModel
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.verify
import com.nhaarman.mockito_kotlin.whenever
import com.br.cambio.utils.MainCoroutineRule
import com.br.cambio.utils.await
import com.br.cambio.utils.verify
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Rule
import org.junit.Test

@ExperimentalCoroutinesApi
class MainViewModelTest {

    @get:Rule
    val coroutineRule = MainCoroutineRule()

    @get:Rule
    val instantExecutorRule = InstantTaskExecutorRule()

    private val useCase: GetCurrenciesUseCase = mock()
    private val pricesUseCase: GetPricesUseCase = mock()
    private val viewModel: MainViewModel by lazy {
        MainViewModel(useCase, pricesUseCase, Dispatchers.Default)
    }

    @Test
    fun `get currencies when already load and not scrolling should not call use case`() =
        runBlockingTest {
            // Given
            whenever(useCase.invoke(false)).thenReturn(mockResponseSuccess())

            // When
            viewModel.getCurrency(false)
            viewModel.successCurrencyEvent.await(50L)
            viewModel.getCurrency(false)

            // Then
            verify(useCase).invoke(false)
            viewModel.successCurrencyEvent.verify()
        }

    private fun mockResponseSuccess(): ExchangePresentation {
        return ExchangePresentation.SuccessResponse(
            listOf(
                DialogSpinnerModel(
                    codigo = "BRL",
                    nome = "Brazilian Real"
                )
            )
        )
    }
}