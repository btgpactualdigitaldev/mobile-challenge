package com.example.btgconvert.presentation.base


import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar

open class BaseActivity : AppCompatActivity() {
    protected fun setToolbar(toolbar : Toolbar, title : Int, isBackButton: Boolean = true){
        toolbar.title = getString(title)
        setSupportActionBar(toolbar)
        supportActionBar?.setDisplayHomeAsUpEnabled(isBackButton)
    }
}