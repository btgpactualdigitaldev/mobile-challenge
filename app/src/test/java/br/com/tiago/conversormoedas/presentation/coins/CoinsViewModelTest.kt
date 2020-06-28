package br.com.tiago.conversormoedas.presentation.coins

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import br.com.tiago.conversormoedas.R
import br.com.tiago.conversormoedas.data.CoinsRepository
import br.com.tiago.conversormoedas.data.CoinsResult
import br.com.tiago.conversormoedas.data.model.Coin
import com.nhaarman.mockitokotlin2.verify
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner

@RunWith(MockitoJUnitRunner::class)
class CoinsViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @Mock
    private lateinit var coinsLiveDataObserver: Observer<List<Coin>>

    @Mock
    private lateinit var viewFlipperLiveDataObserver: Observer<Pair<Int, Int?>>

    private lateinit var viewModel: CoinsViewModel

    @Test
    fun `when view model getCoinsDB get success then set coinsLiveData`() {

        // Arrange
        val coins = listOf(
            Coin(1, "BRL", "Brazilian Real")
        )
        val resultSuccess = MockRepository(CoinsResult.Success(coins))
        viewModel = CoinsViewModel(resultSuccess)
        viewModel.coinsLiveData.observeForever(coinsLiveDataObserver)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        // Act
        viewModel.getCoinsDB(type = null)

        // Assert
        verify(coinsLiveDataObserver).onChanged(coins)
        verify(viewFlipperLiveDataObserver).onChanged(Pair(1, null))
    }

    @Test
    fun `when view model getCoins get api error 401 then set viewFlipperData`() {

        val statusCode = 401

        //Arrange
        val resultApiError = MockRepository(CoinsResult.ApiError(statusCode))
        viewModel = CoinsViewModel(resultApiError)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        //Act
        viewModel.getCoins()

        // Assert
        verify(viewFlipperLiveDataObserver).onChanged(Pair(2, R.string.coins_error_401))
    }

    @Test
    fun `when view model getBooks get api error 400 then set viewFlipperData`() {

        val statusCode = 400

        //Arrange
        val resultApiError = MockRepository(CoinsResult.ApiError(statusCode))
        viewModel = CoinsViewModel(resultApiError)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        //Act
        viewModel.getCoins()

        // Assert
        verify(viewFlipperLiveDataObserver).onChanged(Pair(2, R.string.coins_error_400_generic))
    }

    @Test
    fun `when view model getBooks get error then set viewFlipperData`() {

        //Arrange
        val resultServerError = MockRepository(CoinsResult.ServerError)
        viewModel = CoinsViewModel(resultServerError)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        //Act
        viewModel.getCoins()

        // Assert
        verify(viewFlipperLiveDataObserver).onChanged(Pair(2, R.string.coins_error_500_generic))
    }
}

class MockRepository(private val result: CoinsResult): CoinsRepository {

    override fun getCoins(coinsResultsCallback: (result: CoinsResult) -> Unit) {
        coinsResultsCallback(result)
    }

    override fun getCoinsDB(coinsResultsCallback: (result: CoinsResult) -> Unit) {
        coinsResultsCallback(result)
    }

}