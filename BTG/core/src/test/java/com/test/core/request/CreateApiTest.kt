package com.test.core.request

import org.junit.Assert.*
import org.junit.Test
import retrofit2.http.GET

class CreateApiTest {

    @Test
    fun testIfReallyCreateApi() {
        assertNotNull(createApi<TestApi>())
    }

    private interface TestApi {
        @GET
        fun functionExampleRequestTest()
    }
}