package com.sugarspoon.desafiobtg.ui.coins

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import com.sugarspoon.data.local.database.BtgDataBase
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.data.local.repositories.RepositoryLocal
import com.sugarspoon.desafiobtg.R
import com.sugarspoon.desafiobtg.utils.Constants.CODE_EXTRA_INTENT
import com.sugarspoon.desafiobtg.utils.extensions.intentFor
import com.sugarspoon.desafiobtg.utils.extensions.setVisible
import kotlinx.android.synthetic.main.activity_coins.*
import kotlinx.coroutines.flow.collect

class CoinsActivity : AppCompatActivity() {

    private val database = BtgDataBase.getDatabase(this)
    private val factory = CurrencyViewModel.Factory(
        RepositoryLocal(database.currencyDao(), database.quotationDao())
    )
    private val viewModel by viewModels<CurrencyViewModel> { factory }

    private val adapter by lazy {
        CurrencyAdapter(
            object : CurrencyAdapter.Listener {
                override fun onItemClicked(item: CurrencyEntity) {
                    val returnIntent = Intent()
                    returnIntent.putExtra(CODE_EXTRA_INTENT, item.code)
                    setResult(RESULT_OK, returnIntent)
                    finish()
                }
            }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_coins)
        setupUi()
        setupObservers()
    }

    private fun setupUi() {
        chooseCoinsRv.layoutManager = LinearLayoutManager(this)
        chooseCoinsRv.adapter = adapter
    }

    private fun setupObservers() {
        this.lifecycleScope.launchWhenResumed {
            viewModel.currencies.collect {
                adapter.setCurrencyList(it)
                chooseCoinsLoading.setVisible(false)
            }
        }
    }

    companion object {
        fun intent(context: Context) = context.intentFor<CoinsActivity>()
    }
}