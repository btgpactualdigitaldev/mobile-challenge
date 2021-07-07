package br.com.leonamalmeida.mobilechallenge.ui.currency

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.MutableLiveData
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.RxImmediateSchedulerRule
import br.com.leonamalmeida.mobilechallenge.data.Currency
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.data.repositories.CurrencyRepository
import br.com.leonamalmeida.mobilechallenge.getOrAwaitValue
import br.com.leonamalmeida.mobilechallenge.observeForTesting
import com.google.common.truth.Truth.assertThat
import com.nhaarman.mockito_kotlin.whenever
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mock
import org.mockito.MockitoAnnotations

/**
 * Created by Leo Almeida on 30/06/20.
 */
@RunWith(JUnit4::class)
class CurrencyViewModelTest {

    @get:Rule
    val instantTaskExecutorRule = InstantTaskExecutorRule()

    @get:Rule
    val testSchedulerRule = RxImmediateSchedulerRule()

    @Mock
    lateinit var repository: CurrencyRepository

    lateinit var viewModel: CurrencyViewModel

    private val fakedCurrencies = listOf(Currency("USD", "Dólar"), Currency("BRL", "Real"))

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
        viewModel = CurrencyViewModel(repository)
    }

    @Test
    fun getCurrencies_shouldReturnCurrencyList() {
        whenever(repository.getCurrencies(true, "", false))
            .thenReturn(MutableLiveData(Result.Success(fakedCurrencies)))

        viewModel.getCurrencies()

        viewModel.currencies.observeForTesting {
            assertThat(viewModel.currencies.getOrAwaitValue()).hasSize(2)
        }
    }

    @Test
    fun getCurrencies_searchCurrency_MustNotBeFound() {
        whenever(repository.getCurrencies(false, "GBP", false))
            .thenReturn(MutableLiveData(Result.Success(fakedCurrencies.filter { it.code == "GBP" })))

        viewModel.getCurrencies()
        viewModel.searchCurrency("GBP")

        viewModel.currencies.observeForTesting {
            assertThat(viewModel.currencies.getOrAwaitValue()).hasSize(0)
        }
    }

    @Test
    fun getCurrencies_searchCurrency_MustBeFound() {
        whenever(repository.getCurrencies(false, "BRL", false))
            .thenReturn(MutableLiveData(Result.Success(fakedCurrencies.filter { it.code.contains("BRL") })))

        viewModel.getCurrencies()
        viewModel.searchCurrency("BRL")

        viewModel.currencies.observeForTesting {
            assertThat(viewModel.currencies.getOrAwaitValue()).isNotEmpty()
        }
    }

    @Test
    fun getCurrencies_orderByName() {
        whenever(repository.getCurrencies(false, "", true))
            .thenReturn(MutableLiveData(Result.Success(fakedCurrencies.sortedBy { it.name })))

        viewModel.getCurrencies()
        viewModel.orderBy(keyToSearch = "", orderByName = true)

        viewModel.currencies.observeForTesting {
            assertThat(viewModel.currencies.getOrAwaitValue().first().name).isEqualTo("Dólar")
        }
    }

    @Test
    fun getCurrencies_orderByCode() {
        whenever(repository.getCurrencies(false, "", false))
            .thenReturn(MutableLiveData(Result.Success(fakedCurrencies.sortedBy { it.code })))

        viewModel.getCurrencies()
        viewModel.orderBy(keyToSearch = "", orderByName = false)

        viewModel.currencies.observeForTesting {
            assertThat(viewModel.currencies.getOrAwaitValue().first().code).isEqualTo("BRL")
        }
    }

    @Test
    fun getCurrencies_onError_shouldReturnMessageRes() {
        whenever(repository.getCurrencies(true, "", false))
            .thenReturn(MutableLiveData(Result.Error(R.string.fetch_currency_default_error_message)))

        viewModel.getCurrencies()

        viewModel.error.observeForTesting {
            assertThat(viewModel.error.getOrAwaitValue()).isEqualTo(R.string.fetch_currency_default_error_message)
        }
    }
}