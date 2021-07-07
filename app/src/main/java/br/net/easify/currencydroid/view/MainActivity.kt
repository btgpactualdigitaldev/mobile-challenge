package br.net.easify.currencydroid.view

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.app.AppCompatDelegate
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.services.RateService
import br.net.easify.currencydroid.util.ServiceUtil
import javax.inject.Inject

class MainActivity : AppCompatActivity() {

    @Inject
    lateinit var serviceUtil: ServiceUtil

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        (application as MainApplication).getAppComponent()?.inject(this)

        startRateService()

        delegate.localNightMode = AppCompatDelegate.MODE_NIGHT_YES;
    }

    private fun startRateService() {
        val intent = Intent(application, RateService::class.java)
        if (!serviceUtil.isMyServiceRunning(RateService::class.java)) {
            startService(intent)
        }
    }
}