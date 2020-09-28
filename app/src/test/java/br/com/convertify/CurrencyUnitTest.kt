package br.com.convertify

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import br.com.convertify.api.DataState
import br.com.convertify.models.CurrencyItem
import br.com.convertify.models.QuotationItem
import br.com.convertify.viewmodel.ConvertViewModel
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import java.util.concurrent.CompletableFuture

class CurrencyUnitTest {

  @get:Rule
  val instantTaskExecutorRule = InstantTaskExecutorRule()

  lateinit var viewModel: ConvertViewModel

  @Before
  fun setUp() {
    viewModel = ConvertViewModel()
  }

  @Test
  fun `should return success fetching currencies`() {

    viewModel.getCurrencies()

    val future: CompletableFuture<DataState<Array<CurrencyItem>>> = CompletableFuture()

    viewModel.currencyLiveDataState.observeForever {
      future.complete(it)
    }

    val fetchIsNotError = !future.get().isError
    assert(fetchIsNotError) { "Some problem happening to get currencies" }
  }

  @Test
  fun `should return success fetching quotations`() {

    viewModel.getQuotations()

    val future: CompletableFuture<DataState<Array<QuotationItem>>> = CompletableFuture()

    viewModel.quotationLiveDataState.observeForever {
      future.complete(it)
    }

    val fetchIsNotError = !future.get().isError
    assert(fetchIsNotError) { "some problem happening to get quotations" }
  }
}


