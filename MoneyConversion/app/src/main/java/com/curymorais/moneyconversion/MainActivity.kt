package com.curymorais.moneyconversion

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.curymorais.moneyconversion.currencyConversion.ConversionFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.container, ConversionFragment())
                .commitNow()
        }
    }
}