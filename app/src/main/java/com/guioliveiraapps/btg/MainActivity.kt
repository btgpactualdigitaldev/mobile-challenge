package com.guioliveiraapps.btg

import android.os.Bundle
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.guioliveiraapps.btg.ui.currencies.CurrenciesFragment
import com.guioliveiraapps.btg.ui.exchange.ExchangeFragment


class MainActivity : AppCompatActivity() {

    val fragment1: Fragment = ExchangeFragment()
    val fragment2: Fragment = CurrenciesFragment()
    val fm: FragmentManager = supportFragmentManager
    var active: Fragment = fragment1

    lateinit var viewModel: MainActivityViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val navigation: BottomNavigationView = findViewById(R.id.nav_view)
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)

        fm.beginTransaction().add(R.id.main_container, fragment2, "2").hide(fragment2).commit()
        fm.beginTransaction().add(R.id.main_container, fragment1, "1").commit()

        setupViewMoldel()
    }

    private fun setupViewMoldel() {
        viewModel = ViewModelProviders.of(this).get(MainActivityViewModel::class.java)
        viewModel.getCurrencies(this)
        viewModel.getQuotes(this)

        viewModel.currencies.observe(this, Observer {
            if (!viewModel.quotes.value.isNullOrEmpty()) {
                viewModel.showFragments.postValue(true)
            }
        })

        viewModel.quotes.observe(this, Observer {
            if (!viewModel.currencies.value.isNullOrEmpty()) {
                viewModel.showFragments.postValue(true)
            }
        })
    }

    private val mOnNavigationItemSelectedListener: BottomNavigationView.OnNavigationItemSelectedListener =
        object : BottomNavigationView.OnNavigationItemSelectedListener {
            override fun onNavigationItemSelected(item: MenuItem): Boolean {
                when (item.itemId) {
                    R.id.navigation_exchange -> {
                        fm.beginTransaction().hide(active).show(fragment1).commit()
                        active = fragment1
                        return true
                    }
                    R.id.navigation_currencies -> {
                        fm.beginTransaction().hide(active).show(fragment2).commit()
                        active = fragment2
                        return true
                    }
                }
                return false
            }
        }

}
