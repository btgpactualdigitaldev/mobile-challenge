package com.btg.conversormonetario.view.activity

import android.os.Bundle
import com.btg.conversormonetario.R
import com.btg.conversormonetario.shared.observeNonNull
import com.btg.conversormonetario.view.viewmodel.WelcomeViewModel
import kotlinx.android.synthetic.main.activity_welcome.*

class WelcomeActivity : BaseActivity<WelcomeViewModel>() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_welcome)

        initObservers()
    }

    private fun initObservers() {
        viewModel.onActivityCreated()
        viewModel.shouldChangeLayout.observeNonNull(this) { layout ->
            ctlWelcomeInitialLayout.visibility = layout.isWelcomeLayoutVisible
            ctlWelcomeLoadingContent.visibility = layout.isInitialSettingsVisible
        }
    }
}