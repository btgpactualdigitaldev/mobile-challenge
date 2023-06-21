package com.btg.convertercurrency.features.home.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.btg.convertercurrency.BR
import com.btg.convertercurrency.R
import com.btg.convertercurrency.databinding.ActivityHomeBinding
import org.koin.androidx.viewmodel.ext.android.viewModel


class HomeActivity : AppCompatActivity() {

    private val homeViewModel: HomeViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        lifecycle.addObserver(homeViewModel)

        (DataBindingUtil.setContentView(
            this,
            R.layout.activity_home
        ) as ActivityHomeBinding).apply {
            lifecycleOwner = this@HomeActivity
            setVariable(BR.viewModelHome, homeViewModel)
        }
    }


}