package com.example.conversordemoeda

import androidx.test.espresso.Espresso
import androidx.test.espresso.IdlingRegistry
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.contrib.RecyclerViewActions
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.rule.ActivityTestRule
import com.example.conversordemoeda.model.retrofit.OkHttpProvider
import com.example.conversordemoeda.view.ListaDeMoedasActivity
import com.example.conversordemoeda.view.adapter.AdapterListaDeMoedas
import com.jakewharton.espresso.OkHttp3IdlingResource
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class ListaDeMoedasAndroidTest {

    private val MOCK_CAMBIO_RESPONSE_OK = "cambio_list_success.json"

    @get:Rule
    val activityRule = ActivityTestRule(ListaDeMoedasActivity::class.java, true, false)

    private val mockWebServer = MockWebServer()

    @Before
    fun setup() {
        mockWebServer.start(8080)
        IdlingRegistry.getInstance().register(
            OkHttp3IdlingResource.create(
                "okhttp",
                OkHttpProvider.getOkHttpProvider()
            )
        )
    }

    @After
    fun teardowm() {
        mockWebServer.shutdown()
    }

    @Test
    fun quando_activity_abrir_edit_text_deve_estar_visivel() {
        mockResponse(MOCK_CAMBIO_RESPONSE_OK)
        activityRule.launchActivity(null)

        Espresso.onView(ViewMatchers.withId(R.id.rvMoeda))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    @Test
    fun teste_de_navegacao(){
        mockResponse(MOCK_CAMBIO_RESPONSE_OK)
        activityRule.launchActivity(null)

        Espresso.onView(withId(R.id.rvMoeda))
            .perform(
                RecyclerViewActions.actionOnItemAtPosition<AdapterListaDeMoedas.ViewHolder>(
                    0,
                    ViewActions.click()
                )
            )
        assert(activityRule.activity.isFinishing)
    }

    private fun mockResponse(asset: String, responseCode: Int = 200) {
        mockWebServer.enqueue(
            MockResponse()
                .setResponseCode(responseCode)
                .setBody(LerArquivoJson.lerStringDoArquivo(asset))
        )
    }
}