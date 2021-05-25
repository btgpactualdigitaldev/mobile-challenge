package com.vald3nir.btg_challenge.ui.splash

import android.os.Bundle
import com.vald3nir.btg_challenge.R
import com.vald3nir.btg_challenge.core.base.BaseActivity
import com.vald3nir.btg_challenge.ui.home.HomeActivity
import org.koin.androidx.viewmodel.ext.android.viewModel

class FullscreenActivity : BaseActivity() {

    private val viewModel by viewModel<FullscreenViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_fullscreen)

        supportActionBar?.hide()

        viewModel.flagLoadDatabaseCompleted.observe(this, {
            HomeActivity.startHomeActivity(this)
        })
        viewModel.fillDatabase()
    }
}