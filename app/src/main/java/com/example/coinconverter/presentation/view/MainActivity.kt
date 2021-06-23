package com.example.coinconverter.presentation.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.example.coinconverter.R
import com.example.coinconverter.databinding.ActivityMainBinding
import com.example.coinconverter.presentation.adapter.ViewPagerAdapter
import com.google.android.material.tabs.TabLayoutMediator

class MainActivity : AppCompatActivity() {

    private lateinit var dataBinding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        dataBinding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        dataBinding.viewPager.adapter = ViewPagerAdapter(this)
        TabLayoutMediator(dataBinding.tabLayout, dataBinding.viewPager) { tab, position ->
            when(position){
                0->{
                    tab.text = "Conversor"
                }
                1->{
                    tab.text = "Moedas"
                }
            }
            
        }.attach()
    }
}