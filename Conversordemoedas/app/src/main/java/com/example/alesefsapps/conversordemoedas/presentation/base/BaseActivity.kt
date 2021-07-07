package com.example.alesefsapps.conversordemoedas.presentation.base

import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar

open class BaseActivity : AppCompatActivity() {

    protected fun setupToolbar(toolbar: Toolbar, titleIdRes: Int, showBackButton: Boolean = false) {
        toolbar.title = getString(titleIdRes)
        setSupportActionBar(toolbar)
        if (showBackButton) {
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
        }
    }
}
