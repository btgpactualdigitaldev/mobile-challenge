package br.com.android.challengeandroid.list.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatTextView
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.android.challengeandroid.R
import br.com.android.challengeandroid.list.view.recyclerview.ItemCoinAdapter
import br.com.android.challengeandroid.list.view.recyclerview.ItemCoinClickListener
import br.com.android.challengeandroid.list.viewmodel.ListViewModel
import br.com.android.challengeandroid.list.viewmodel.ListViewModelFactory
import br.com.android.challengeandroid.list.viewmodel.states.ListEvent
import br.com.android.challengeandroid.model.CoinList
import br.com.android.challengeandroid.repository.CoinRepository
import br.com.android.challengeandroid.usecase.CoinUseCase
import com.google.android.material.snackbar.Snackbar

class ListActivity : AppCompatActivity(), ItemCoinClickListener {
    private lateinit var repository: CoinRepository
    private lateinit var useCase: CoinUseCase
    private lateinit var factory: ListViewModelFactory
    private lateinit var viewModel: ListViewModel
    private lateinit var adapterItemCoin: ItemCoinAdapter
    private val coinSource = "USD"
    private var typeList = RC_LIST_SOURCE

    private lateinit var rvList: RecyclerView
    private lateinit var progressBar: ProgressBar
    private lateinit var showerror: AppCompatTextView


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list)

        initViews()
        initViewModel()
        getExtras()
        loadsData()
        configureListCoin()
    }

    private fun initViewModel() {
        repository = CoinRepository()
        useCase = CoinUseCase(repository)
        factory = ListViewModelFactory(useCase)
        viewModel = ViewModelProviders.of(this, factory).get(ListViewModel::class.java)
        initObservable()
    }

    private fun initViews() {
        rvList = findViewById(R.id.rv_list)
        progressBar = findViewById(R.id.pb_loading)
    }

    private fun getExtras() {
        val extras = intent.extras
        if (extras != null) {
            typeList = extras.getInt(EXTRA_TYPE_LIST)
        }
    }

    private fun configureListCoin() {
        adapterItemCoin = ItemCoinAdapter(this)
        rvList.adapter = adapterItemCoin
        rvList.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
    }

    private fun loadsData() {
        viewModel.getCoinList(coinSource)
    }

    private fun initObservable() {
        viewModel.viewEvent.observe(this, Observer {
            when (it) {
                is ListEvent.LoadingVisible -> showLoading()
                is ListEvent.LoadingGone -> goneLoading()
                is ListEvent.Error -> showError()
                is ListEvent.SuccessList -> showSuccessList(it.list)
            }
        })
    }

    private fun goneLoading() {
        progressBar.visibility = View.GONE
    }

    private fun showLoading() {
        progressBar.visibility = View.VISIBLE
    }

    private fun showError() {
        Snackbar.make(showerror, "Tente novamente", Snackbar.LENGTH_LONG).show()
    }

    private fun showSuccessList(list: List<CoinList>) {
        val currenciesAccepted = viewModel.currenciesAccepted(typeList)
        adapterItemCoin.setList(list, currenciesAccepted)
        adapterItemCoin.notifyDataSetChanged()

    }

    override fun clickItem(code: String) {
        val data = Intent()
        data.putExtra(AR_CODE, code)
        setResult(Activity.RESULT_OK, data)
        finish()
    }

    companion object {
        const val RC_LIST_SOURCE = 1
        const val RC_LIST_DESTINY = 2

        const val EXTRA_TYPE_LIST = "type_list"
        const val AR_CODE = "code"
    }
}
