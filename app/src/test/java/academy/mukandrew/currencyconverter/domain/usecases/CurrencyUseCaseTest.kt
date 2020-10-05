package academy.mukandrew.currencyconverter.domain.usecases

import academy.mukandrew.currencyconverter.commons.Result.*
import academy.mukandrew.currencyconverter.commons.errors.NetworkException
import academy.mukandrew.currencyconverter.commons.errors.NoContentException
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.models.CurrencyQuote
import academy.mukandrew.currencyconverter.domain.repositories.CurrencyRepository
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito

class CurrencyUseCaseTest {
    @Mock
    lateinit var repositoryMock: CurrencyRepository
    private lateinit var useCase: CurrencyUseCase

    private val currencyList = listOf(
        Currency("AED", "United Arab Emirates Dirham"),
        Currency("AFN", "Afghan Afghani"),
        Currency("ALL", "Albanian Lek"),
        Currency("AMD", "Armenian Dram")
    )

    private val quoteList = listOf(
        CurrencyQuote("USDAED", 1f, 3.67285f),
        CurrencyQuote("USDAFN", 1f, 76.803991f),
        CurrencyQuote("USDALL", 1f, 105.000368f),
        CurrencyQuote("USDAMD", 1f, 487.670403f)
    )

    private val currencyQuoteList = listOf(
        Currency("AED", "United Arab Emirates Dirham", CurrencyQuote("USDAED", 1f, 3.67285f)),
        Currency("AFN", "Afghan Afghani", CurrencyQuote("USDAFN", 1f, 76.803991f)),
        Currency("ALL", "Albanian Lek", CurrencyQuote("USDALL", 1f, 105.000368f)),
        Currency("AMD", "Armenian Dram", CurrencyQuote("USDAMD", 1f, 487.670403f))
    )

    @Before
    fun before() {
        repositoryMock = Mockito.mock(CurrencyRepository::class.java)
        useCase = CurrencyUseCaseImpl(repositoryMock)
    }

    @Test
    fun `list all currencies with quotes`() = runBlocking {
        Mockito.`when`(repositoryMock.list()).thenReturn(Success(currencyList))
        Mockito.`when`(repositoryMock.quotes()).thenReturn(Success(quoteList))

        val result = useCase.list()

        Mockito.verify(repositoryMock, Mockito.times(1)).list()
        Mockito.verify(repositoryMock, Mockito.times(1)).quotes()
        assert(result is Success)
        assert((result as Success).data == currencyQuoteList)
    }

    @Test
    fun `list currencies return a no content exception`() = runBlocking {
        Mockito.`when`(repositoryMock.list()).thenReturn(Failure(NoContentException()))
        val result = useCase.list()
        Mockito.verify(repositoryMock, Mockito.times(1)).list()
        Mockito.verify(repositoryMock, Mockito.never()).quotes()
        assert(result is Failure)
        assert((result as Failure).error is NoContentException)
    }

    @Test
    fun `list quotes return a network exception`() = runBlocking {
        Mockito.`when`(repositoryMock.list()).thenReturn(Success(currencyList))
        Mockito.`when`(repositoryMock.quotes()).thenReturn(Failure(NetworkException()))

        val result = useCase.list()
        Mockito.verify(repositoryMock, Mockito.times(1)).list()
        Mockito.verify(repositoryMock, Mockito.times(1)).quotes()
        assert(result is Failure)
        assert((result as Failure).error is NetworkException)
    }

    @Test
    fun `convert currency success`() = runBlocking {
        val quantity = 10000.00f
        val fromCurrencyValue = currencyQuoteList[0].quote!!.value
        val toCurrencyValue = currencyQuoteList[1].quote!!.value
        val manualResult = (quantity / fromCurrencyValue) * toCurrencyValue

        val result = useCase.convert(quantity, currencyQuoteList[0], currencyQuoteList[1])
        assert(result is Success)
        assert((result as Success).data == manualResult)
    }

    @Test
    fun `convert currency error`() = runBlocking {
        val result = useCase.convert(
            0f,
            currencyQuoteList[0].apply { quote = null },
            currencyQuoteList[1].apply { quote = null }
        )
        assert(result is Failure)
    }
}