package academy.mukandrew.currencyconverter.domain.repositories

import academy.mukandrew.currencyconverter.commons.Result.Success
import academy.mukandrew.currencyconverter.commons.Result.Failure
import academy.mukandrew.currencyconverter.commons.errors.NetworkException
import academy.mukandrew.currencyconverter.commons.errors.NoContentException
import academy.mukandrew.currencyconverter.data.datasources.CurrencyDataSource
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.models.CurrencyQuote
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito

class CurrencyRepositoryTest {
    @Mock
    private lateinit var localDataSource: CurrencyDataSource

    @Mock
    private lateinit var remoteDataSource: CurrencyDataSource

    private lateinit var repository: CurrencyRepository
    private val currencyMap = mapOf(
        "AED" to "United Arab Emirates Dirham",
        "AFN" to "Afghan Afghani",
        "ALL" to "Albanian Lek",
        "AMD" to "Armenian Dram"
    )
    private val quoteMap = mapOf(
        "USDAED" to 3.67285f,
        "USDAFN" to 76.803991f,
        "USDALL" to 105.000368f,
        "USDAMD" to 487.670403f
    )
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

    @Before
    fun before() {
        localDataSource = Mockito.mock(CurrencyDataSource::class.java)
        remoteDataSource = Mockito.mock(CurrencyDataSource::class.java)
        repository = CurrencyRepositoryImpl(localDataSource, remoteDataSource)
    }

    @Test
    fun `list currencies from remote`() = runBlocking {
        Mockito.`when`(remoteDataSource.list()).thenReturn(Success(currencyMap))

        val result = repository.list()
        Mockito.verify(remoteDataSource, Mockito.times(1)).list()
        Mockito.verify(localDataSource, Mockito.never()).list()
        assert(result is Success)
        assert((result as Success).data == currencyList)
    }

    @Test
    fun `list currencies from local`() = runBlocking {
        Mockito.`when`(remoteDataSource.list()).thenReturn(Failure(NetworkException()))
        Mockito.`when`(localDataSource.list()).thenReturn(Success(currencyMap))

        val result = repository.list()
        Mockito.verify(remoteDataSource, Mockito.times(1)).list()
        Mockito.verify(localDataSource, Mockito.times(1)).list()
        assert(result is Success)
        assert((result as Success).data == currencyList)
    }

    @Test
    fun `list currencies return no content exception`() = runBlocking {
        Mockito.`when`(remoteDataSource.list()).thenReturn(Failure(NoContentException()))
        Mockito.`when`(localDataSource.list()).thenReturn(Success(emptyMap()))
        val result = repository.list()
        Mockito.verify(remoteDataSource, Mockito.times(1)).list()
        Mockito.verify(localDataSource, Mockito.times(1)).list()
        assert(result is Failure)
        assert((result as Failure).error is NoContentException)
    }

    @Test
    fun `list currencies return network exception`() = runBlocking {
        Mockito.`when`(remoteDataSource.list()).thenReturn(Failure(NetworkException()))
        Mockito.`when`(localDataSource.list()).thenReturn(Success(emptyMap()))
        val result = repository.list()
        Mockito.verify(remoteDataSource, Mockito.times(1)).list()
        Mockito.verify(localDataSource, Mockito.times(1)).list()
        assert(result is Failure)
        assert((result as Failure).error is NetworkException)
    }

    @Test
    fun `list quotes from remote`() = runBlocking {
        Mockito.`when`(remoteDataSource.quotes()).thenReturn(Success(quoteMap))
        val result = repository.quotes()
        Mockito.verify(remoteDataSource, Mockito.times(1)).quotes()
        Mockito.verify(localDataSource, Mockito.never()).quotes()
        assert(result is Success)
        assert((result as Success).data == quoteList)
    }

    @Test
    fun `list quotes from local`() = runBlocking {
        Mockito.`when`(remoteDataSource.quotes()).thenReturn(Failure(NetworkException()))
        Mockito.`when`(localDataSource.quotes()).thenReturn(Success(quoteMap))

        val result = repository.quotes()
        Mockito.verify(remoteDataSource, Mockito.times(1)).quotes()
        Mockito.verify(localDataSource, Mockito.times(1)).quotes()
        assert(result is Success)
        assert((result as Success).data == quoteList)
    }

    @Test
    fun `list quotes return no content exception`() = runBlocking {
        Mockito.`when`(remoteDataSource.quotes()).thenReturn(Failure(NoContentException()))
        Mockito.`when`(localDataSource.quotes()).thenReturn(Success(emptyMap()))
        val result = repository.quotes()
        Mockito.verify(remoteDataSource, Mockito.times(1)).quotes()
        Mockito.verify(localDataSource, Mockito.times(1)).quotes()
        assert(result is Failure)
        assert((result as Failure).error is NoContentException)
    }

    @Test
    fun `list quotes return network exception`() = runBlocking {
        Mockito.`when`(remoteDataSource.quotes()).thenReturn(Failure(NetworkException()))
        Mockito.`when`(localDataSource.quotes()).thenReturn(Success(emptyMap()))
        val result = repository.quotes()
        Mockito.verify(remoteDataSource, Mockito.times(1)).quotes()
        Mockito.verify(localDataSource, Mockito.times(1)).quotes()
        assert(result is Failure)
        assert((result as Failure).error is NetworkException)
    }
}