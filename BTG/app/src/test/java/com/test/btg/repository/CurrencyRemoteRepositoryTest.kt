package com.test.btg.repository

import com.test.core.ResponseCodeException
import com.test.core.extension.alternateThreadAndBackToMain
import com.test.core.model.Lives
import com.test.core.provider.provideRetrofit
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkStatic
import io.reactivex.Observable
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertSame
import org.junit.Test
import retrofit2.Response
import retrofit2.Retrofit

class CurrencyRemoteRepositoryTest {

    private val repository = CurrencyRemoteRepository()

    @Test
    fun whenSearchLivesSuccessful_ShouldCallSuccessCallback() {
        mockkStatic("com.test.core.provider.RetrofitProviderKt")
        mockkStatic("com.test.core.extension.ObservableExtensionKt")

        val mockLives = mockk<Lives>()
        val mockResponse = mockk<Response<Lives>>()
        val observable = Observable.just(mockResponse)
        val mockCurrencyApi = mockk<CurrencyApi>()

        val mockRetrofit = mockk<Retrofit>()

        every { provideRetrofit() } returns mockRetrofit
        every { mockRetrofit.create(CurrencyApi::class.java) } returns mockCurrencyApi
        every { mockCurrencyApi.requestLive() } returns observable

        every { mockResponse.isSuccessful } returns true
        every { mockResponse.body() } returns mockLives
        every { observable.alternateThreadAndBackToMain() } returns (observable)

        repository.searchLive({
            assertNotNull(it)
            assertSame(mockLives, it)
        }) {
            throw IllegalStateException("test case error", it)
        }
    }


    @Test
    fun whenSearchLivesFailure_ShouldCallFailureCallback() {
        mockkStatic("com.test.core.provider.RetrofitProviderKt")
        mockkStatic("com.test.core.extension.ObservableExtensionKt")

        val mockLives = mockk<Lives>()
        val mockResponse = mockk<Response<Lives>>()
        val observable = Observable.just(mockResponse)
        val mockCurrencyApi = mockk<CurrencyApi>()

        val mockRetrofit = mockk<Retrofit>()

        every { provideRetrofit() } returns mockRetrofit
        every { mockRetrofit.create(CurrencyApi::class.java) } returns mockCurrencyApi
        every { mockCurrencyApi.requestLive() } returns observable

        every { mockResponse.isSuccessful } returns false
        every { mockResponse.body() } returns mockLives
        every { mockResponse.code() } returns 404

        every { observable.alternateThreadAndBackToMain() } returns (observable)

        repository.searchLive({
            throw IllegalStateException("test case error")
        }) {
            assertNotNull(it)
            assert(it is ResponseCodeException)
        }
    }


    @Test
    fun whenSearchLivesError_ShouldCallFailureCallbackWithError() {
        mockkStatic("com.test.core.provider.RetrofitProviderKt")
        mockkStatic("com.test.core.extension.ObservableExtensionKt")

        val mockCurrencyApi = mockk<CurrencyApi>()
        val observable = Observable.error<Response<Lives>>(IllegalStateException())

        val mockRetrofit = mockk<Retrofit>()

        every { provideRetrofit() } returns mockRetrofit
        every { mockRetrofit.create(CurrencyApi::class.java) } returns mockCurrencyApi
        every { mockCurrencyApi.requestLive() } returns observable

        every { observable.alternateThreadAndBackToMain() } returns (observable)

        repository.searchLive({
            throw IllegalStateException("test case error")
        }) {
            assertNotNull(it)
            assert(it is IllegalStateException)
        }
    }


}