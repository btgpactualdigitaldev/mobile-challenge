package com.kaleniuk2.conversordemoedas.common.ui

import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar

abstract class BaseActivity : AppCompatActivity() {
    protected fun setupToolbar(toolbar: Toolbar, withBackButton: Boolean = false) {
        setSupportActionBar(toolbar)
        if (withBackButton)
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }
}