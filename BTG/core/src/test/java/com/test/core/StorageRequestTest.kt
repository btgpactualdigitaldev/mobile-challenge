package com.test.core

import com.test.core.extension.alternateThreadAndBackToMain
import com.test.core.model.Lives
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkStatic
import io.reactivex.Observable
import org.junit.Assert
import org.junit.Assert.assertEquals
import org.junit.Test
import retrofit2.Response

class StorageRequestTest {

    @Test
    fun whenRequestWasSuccessful_ShouldCallSuccessListener() {
        mockkStatic("com.test.core.extension.ObservableExtensionKt")

        val mockLives = mockk<Lives>()
        val mockResponse = mockk<Response<Lives>>()
        val observable = Observable.just(mockResponse)

        every { mockResponse.isSuccessful } returns true
        every { mockResponse.body() } returns mockLives
        every { observable.alternateThreadAndBackToMain() } returns (observable)

        doRemoteStorageRequest(
            { observable },
            { Assert.assertSame(mockLives, it) },
            { throw IllegalStateException("test case error") }
        )
    }

    @Test
    fun whenRequestWasFailure_ShouldCallFailureListener() {
        mockkStatic("com.test.core.extension.ObservableExtensionKt")

        val mockLives = mockk<Lives>()
        val mockResponse = mockk<Response<Lives>>()
        val observable = Observable.just(mockResponse)
        val responseCodeMock = 404

        every { mockResponse.isSuccessful } returns false
        every { mockResponse.body() } returns mockLives
        every { mockResponse.code() } returns responseCodeMock
        every { observable.alternateThreadAndBackToMain() } returns (observable)

        doRemoteStorageRequest(
            { observable },
            { throw IllegalStateException("test case error") },
            {
                assert(it is ResponseCodeException)
                assertEquals((it as ResponseCodeException).responseCode, responseCodeMock)
            }
        )
    }

    @Test
    fun whenRequestThrowException_ShouldCallFailureListener() {
        mockkStatic("com.test.core.extension.ObservableExtensionKt")
        val observable = Observable.error<Response<Any>>(IllegalStateException())

        every { observable.alternateThreadAndBackToMain() } returns (observable)

        doRemoteStorageRequest<Any>(
            { observable },
            { throw IllegalStateException("test case error") },
            { assert(it is IllegalStateException) }
        )
    }
}