package br.com.leandrospidalieri.btgpactualconversion

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.FragmentManager
import br.com.leandrospidalieri.btgpactualconversion.database.getDatabase
import br.com.leandrospidalieri.btgpactualconversion.repository.CurrencyRepository
import br.com.leandrospidalieri.btgpactualconversion.util.hasNetwork
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlin.properties.Delegates

class MainActivity : AppCompatActivity() {
    private val viewModelJob = Job()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val coroutineScope = CoroutineScope(viewModelJob + Dispatchers.Main)
        val database = getDatabase(application)
        val currenciesRepository = CurrencyRepository(database)

        coroutineScope.launch {
            if(hasNetwork(applicationContext))
                currenciesRepository.refreshCurrencies()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        viewModelJob.cancel()
    }
}