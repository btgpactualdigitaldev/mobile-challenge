package com.test.btg

import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.test.btg.adapter.CurrencyAdapter
import com.test.btg.viewmodel.CurrencyAnswer
import com.test.btg.viewmodel.CurrencyInteracts
import com.test.btg.viewmodel.CurrencyViewModel
import com.test.core.model.Lives

class MainActivity : AppCompatActivity() {

    private val viewModel = CurrencyViewModel()

    private val progressBar by lazy { findViewById<View>(R.id.progress_bar) }
    private val recyclerView by lazy { findViewById<RecyclerView>(R.id.recyclerview) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        viewModel.interact(CurrencyInteracts.CreatedActivity)
        viewModel.answers.observe(this, Observer {
            when (it) {
                is CurrencyAnswer.CurrencyLives -> currencyLives(it.lives)
                is CurrencyAnswer.Error -> errorNoData(it.message)
                is CurrencyAnswer.LoadingStatus -> progressBar.visibility = it.visibility
            }
        })

        viewModel.loadingStatus.observe(this, Observer {
            progressBar.visibility = it.visibility
        })
    }

    private fun errorNoData(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    private fun currencyLives(lives: Lives) {
        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = CurrencyAdapter(lives.quotes)
    }
}
