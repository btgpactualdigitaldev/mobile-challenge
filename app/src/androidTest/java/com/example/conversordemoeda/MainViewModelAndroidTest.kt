package com.example.conversordemoeda

import android.app.Activity
import android.app.Instrumentation
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.IdlingRegistry
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.contrib.RecyclerViewActions
import androidx.test.espresso.intent.Intents
import androidx.test.espresso.intent.matcher.IntentMatchers.hasComponent
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.rule.ActivityTestRule
import com.example.conversordemoeda.model.retrofit.OkHttpProvider
import com.example.conversordemoeda.view.ListaDeMoedasActivity
import com.example.conversordemoeda.view.MainActivity
import com.jakewharton.espresso.OkHttp3IdlingResource
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class MainViewModelAndroidTest {

    private val MOCK_COTACAO_RESPONSE_OK = "cotacao_live_succes.json"
    private val MOCK_COTACAO_RESPONSE_104 = "cotacao_live_error_104.json"

    @get:Rule
    val activityRule = ActivityTestRule(MainActivity::class.java, true, false)

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
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.etValor)).check(matches(isDisplayed()))
    }

    @Test
    fun teste_de_falha_na_requisicao() {
        mockResponse(MOCK_COTACAO_RESPONSE_104)
        activityRule.launchActivity(null)

        onView(withText("Your monthly usage limit has been reached. Please upgrade your subscription plan.")).check(matches(isDisplayed()))
    }

    @Test
    fun quando_activity_abrir_edit_text_deve_estar_habilitado() {
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.etValor)).check(matches(isEnabled()))
    }

    @Test
    fun quando_activity_abrir_botao_cambio_origem_deve_estar_visivel() {
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.btCambioOrigem)).check(matches(isDisplayed()))
    }

    @Test
    fun quando_activity_abrir_botao_cambio_destino_deve_estar_visivel() {
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.btCambioDestino)).check(matches(isDisplayed()))
    }

    @Test
    fun quando_activity_abrir_setas_deve_estar_visivel() {
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.setas)).check(matches(isDisplayed()))
    }

    @Test
    fun quando_activity_abrir_botao_cambio_destino_deve_estar_habilitado() {
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.btCambioDestino)).check(matches(isEnabled()))
    }

    @Test
    fun quando_activity_abrir_botao_cambio_origem_deve_estar_habilitado() {
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)

        onView(withId(R.id.btCambioOrigem)).check(matches(isEnabled()))
    }

    @Test
    fun navegacao_do_botao_cabio_de_origem(){
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)
        Intents.init()
        val matcher = hasComponent(ListaDeMoedasActivity::class.java.name)

        val result = Instrumentation.ActivityResult(Activity.RESULT_OK, null)
        Intents.intending(matcher).respondWith(result)

        onView(withId(R.id.btCambioOrigem))
            .perform(
                ViewActions.click()
            )

        Intents.intended(matcher)
        Intents.release()
    }

    @Test
    fun navegacao_do_botao_cabio_de_destino(){
        mockResponse(MOCK_COTACAO_RESPONSE_OK)
        activityRule.launchActivity(null)
        Intents.init()
        val matcher = hasComponent(ListaDeMoedasActivity::class.java.name)

        val result = Instrumentation.ActivityResult(Activity.RESULT_OK, null)
        Intents.intending(matcher).respondWith(result)

        onView(withId(R.id.btCambioDestino))
            .perform(
                ViewActions.click()
            )

        Intents.intended(matcher)
        Intents.release()
    }

    private fun mockResponse(asset: String, responseCode: Int = 200) {
        mockWebServer.enqueue(
            MockResponse()
                .setResponseCode(responseCode)
                .setBody(LerArquivoJson.lerStringDoArquivo(asset))
        )
    }
}