package br.com.albertomagalhaes.btgcurrencies.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.albertomagalhaes.btgcurrencies.R
import br.com.albertomagalhaes.btgcurrencies.fragment.CurrencyConversionFragment

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onBackPressed() = when(getForegroundFragment()){
        is CurrencyConversionFragment -> finish()
        else -> super.onBackPressed()
    }

    fun getForegroundFragment(): Fragment? {
        val navHostFragment = getSupportFragmentManager().findFragmentById(R.id.activity_main_fcv)
        return navHostFragment?.getChildFragmentManager()?.getFragments()?.get(0)
    }
}