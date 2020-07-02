package com.gui.antonio.testebtg.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.gui.antonio.testebtg.R
import com.gui.antonio.testebtg.database.AppDatabase
import com.gui.antonio.testebtg.di.DaggerAppComponent
import com.gui.antonio.testebtg.viewmodel.MainViewModel
import javax.inject.Inject

class MainActivity : AppCompatActivity() {

    @Inject
    lateinit var viewModel: MainViewModel
    @Inject
    lateinit var appDatabase: AppDatabase

    override fun onCreate(savedInstanceState: Bundle?) {
        DaggerAppComponent.factory().create(this, this).inject(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

    }
}