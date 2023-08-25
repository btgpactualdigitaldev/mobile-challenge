package br.com.btg.mobile.challenge.helper

import okhttp3.mockwebserver.MockWebServer
import org.junit.rules.TestWatcher
import org.junit.runner.Description

private const val PORT = 8055

class MockWebServerRule : TestWatcher() {

    private var _mockServer: MockWebServer? = MockWebServer()

    val mockServer: MockWebServer
        get() = _mockServer ?: error("No MockWebServer found")

    override fun starting(description: Description?) {
        super.starting(description)
        _mockServer?.start(PORT)
    }

    override fun finished(description: Description?) {
        super.finished(description)
        _mockServer?.shutdown()
    }
}
