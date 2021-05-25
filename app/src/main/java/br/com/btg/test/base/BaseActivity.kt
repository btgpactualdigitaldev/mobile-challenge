package br.com.btg.test.base

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import org.koin.core.context.loadKoinModules
import org.koin.core.module.Module

abstract class BaseActivity : AppCompatActivity() {

    abstract val modules: List<Module>
    abstract val contentView: Int


    override fun onCreate(savedInstanceState: Bundle?) {
        loadKoinModules(modules)
        super.onCreate(savedInstanceState)
        setContentView(contentView)
    }
}