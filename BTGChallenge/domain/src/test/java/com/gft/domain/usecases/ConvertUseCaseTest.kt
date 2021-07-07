package com.gft.domain.usecases

import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.entities.Resource
import com.gft.domain.repository.CurrencyRepository
import io.mockk.MockKAnnotations
import io.mockk.coEvery
import io.mockk.impl.annotations.MockK
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class ConvertUseCaseTest {
    @MockK
    lateinit var repository: CurrencyRepository

    lateinit var useCase: ConvertUseCase

    private val quotes = Resource.success(
        CurrencyValueList(
            quotes = hashMapOf(
                "USDBRL" to "5.422278",
                "USDUSD" to "1",
                "USDEUR" to "0.844423"
            )
        )
    )

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        this.useCase = ConvertUseCase(repository)
    }

    @Test
    fun convert_USDBRL() = runBlocking {
        coEvery { repository.getValues() } returns quotes
        val convertedValue = useCase.execute("USD", "BRL", 1.0)

        assertEquals(5.42, convertedValue)
    }

    @Test
    fun convert_BRLUSD() = runBlocking {
        coEvery { repository.getValues() } returns quotes
        val convertedValue = useCase.execute("BRL", "USD", 5.42)

        assertEquals(1.0, convertedValue)
    }

    @Test
    fun convert_EURBRL() = runBlocking {
        coEvery { repository.getValues() } returns quotes
        val convertedValue = useCase.execute("EUR", "BRL", 1.0)

        assertEquals(6.42, convertedValue)
    }
}