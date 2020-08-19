package com.kaleniuk2.conversordemoedas.viewmodel

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepository
import junit.framework.Assert.assertEquals
import org.junit.Rule
import org.junit.Test
import java.math.BigDecimal

class HomeViewModelTest {

    @Rule
    @JvmField
    val rule = InstantTaskExecutorRule()

    @Test
    fun `when call convert with from or to empty should return empty error`() {
        //given
        val viewModel = HomeViewModel()

        //when
        viewModel.interact(HomeViewModel.Interact.Convert("", "", ""))

        //then
        assertEquals(
            "Selecione todas moedas",
            viewModel.showError.value
        )
    }

    @Test
    fun `when call convert with input empty should return empty input error`() {
        //given
        val viewModel = HomeViewModel()

        //when
        viewModel.interact(HomeViewModel.Interact.Convert("BRL", "USD", ""))

        //then
        assertEquals(
            "Preencha o campo valor",
            viewModel.showError.value
        )
    }

    @Test
    fun `when call convert with equals from and to should return error equals`() {
        //given
        val viewModel = HomeViewModel()

        //when
        viewModel.interact(HomeViewModel.Interact.Convert("BRL", "BRL", "0"))

        //then
        assertEquals(
            "As duas moedas devem ser diferentes",
            viewModel.showError.value
        )
    }

    @Test
    fun `when call convert with correct params and api returns error should call show error`() {
        //given
        val mockResponse = DataWrapper.Error("Error")
        val mockRepository = RepositoryMock(mockResponse)
        val viewModel = HomeViewModel(mockRepository)

        //when
        viewModel.interact(HomeViewModel.Interact.Convert("BRL", "USD", "0.0"))

        //then
        assertEquals(
            "Error",
            viewModel.showError.value
        )
    }

    @Test
    fun `when call convert with correct params and api returns success should call convert success with string converted`() {
        //given
        val mockList = listOf(
            Currency("", "USDUSD", BigDecimal(1.0)),
            Currency("", "USDBRL", BigDecimal(5.508786))
        )
        val mockResponse = DataWrapper.Success(mockList)
        val mockRepository = RepositoryMock(mockResponse)
        val viewModel = HomeViewModel(mockRepository)

        //when
        viewModel.interact(HomeViewModel.Interact.Convert("USD", "BRL", "1.00"))

        //then
        assertEquals(
            "BRL 5.51",
            viewModel.convertSuccess.value
        )
    }

    @Test
    fun `when call convert with correct params but to param is usd and api returns success should call convert success with string converted starts with usd`() {
        //given
        val mockList = listOf(
            Currency("", "USDUSD", BigDecimal(1.0)),
            Currency("", "USDBRL", BigDecimal(5.508786))
        )
        val mockResponse = DataWrapper.Success(mockList)
        val mockRepository = RepositoryMock(mockResponse)
        val viewModel = HomeViewModel(mockRepository)

        //when
        viewModel.interact(HomeViewModel.Interact.Convert("BRL", "USD", "1.00"))

        //then
        assertEquals(
            "USD 0.19",
            viewModel.convertSuccess.value
        )
    }

    class RepositoryMock(private val mockResponse: DataWrapper<List<Currency>>) :
        CurrencyRepository {
        override fun getListCurrency(callback: (DataWrapper<List<Currency>>) -> Unit) {}

        override fun convert(
            currencyFrom: String,
            currencyTo: String,
            callback: (DataWrapper<List<Currency>>) -> Unit
        ) {
            callback(mockResponse)
        }

    }
}