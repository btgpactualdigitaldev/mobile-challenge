package br.com.android.challengeandroid.home.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatTextView
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.android.challengeandroid.R
import br.com.android.challengeandroid.home.viewmodel.HomeViewModel
import br.com.android.challengeandroid.home.viewmodel.HomeViewModelFactory
import br.com.android.challengeandroid.home.viewmodel.states.HomeEvent
import br.com.android.challengeandroid.home.viewmodel.states.HomeInteractor
import br.com.android.challengeandroid.list.view.ListActivity
import br.com.android.challengeandroid.list.view.ListActivity.Companion.EXTRA_TYPE_LIST
import br.com.android.challengeandroid.list.view.ListActivity.Companion.RC_LIST_DESTINY
import br.com.android.challengeandroid.list.view.ListActivity.Companion.RC_LIST_SOURCE
import br.com.android.challengeandroid.repository.CoinRepository
import br.com.android.challengeandroid.usecase.CoinUseCase
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_home.*


class HomeActivity : AppCompatActivity() {
    private lateinit var repository: CoinRepository
    private lateinit var useCase: CoinUseCase
    private lateinit var factory: HomeViewModelFactory
    private lateinit var viewModel: HomeViewModel

    private lateinit var etValue: EditText
    private lateinit var etSource: EditText
    private lateinit var etDestiny: EditText
    private lateinit var showError: AppCompatTextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home)

        initViews()
        initViewModel()
    }

    private fun initViewModel() {
        repository = CoinRepository()
        useCase = CoinUseCase(repository)
        factory = HomeViewModelFactory(useCase)
        viewModel = ViewModelProviders.of(this, factory).get(HomeViewModel::class.java)
        initObservable()
    }

    private fun initViews() {
        etSource = findViewById(R.id.et_source)
        etDestiny = findViewById(R.id.et_destiny)
        etValue = findViewById(R.id.et_value)

        findViewById<Button>(R.id.btn_show_list_source).setOnClickListener {
            showListSource()
        }
        findViewById<Button>(R.id.btn_show_list_destiny).setOnClickListener {
            showListDestiny()
        }
        findViewById<Button>(R.id.btn_to_converter).setOnClickListener {
            if (etValue.text.toString().isNotEmpty() ) {
                toConvert()
            } else {
                Snackbar.make(btn_to_converter, "Digite um valor para ser convertido", Snackbar.LENGTH_LONG).show()
                etValue.error = "Campo vazio"
            }

        }
    }

    private fun initObservable() {
        viewModel.viewEvent.observe(this, Observer {
            when (it) {
                is HomeEvent.SuccessPrice -> successPrice(it.price)
            }
        })
    }

    private fun showLoading() {
        // mostra loading
    }

    private fun showError(message: String) {
        // mostra erro
    }

    private fun showListSource() {
        val intent = Intent(this, ListActivity::class.java)
        intent.putExtra(EXTRA_TYPE_LIST, RC_LIST_SOURCE)
        startActivityForResult(intent, RC_LIST_SOURCE)
    }

    private fun showListDestiny() {
        val intent = Intent(this, ListActivity::class.java)
        intent.putExtra(EXTRA_TYPE_LIST, RC_LIST_DESTINY)
        startActivityForResult(intent, RC_LIST_DESTINY)
    }

    private fun toConvert() {
        val source = etSource.text.toString()
        val destiny = etDestiny.text.toString()
        val value = findViewById<EditText>(R.id.et_value).text.toString().toDouble()

        viewModel.interactor(HomeInteractor.ToConvertCoin(source, destiny, value))
    }

    private fun successPrice(price: Double) {
        findViewById<TextView>(R.id.tv_result).text = price.toString()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == RC_LIST_SOURCE) {
            if (resultCode == Activity.RESULT_OK) {
                etSource.setText(data?.extras?.getString(ListActivity.AR_CODE))
            }
        } else if (requestCode == RC_LIST_DESTINY) {
            if (resultCode == Activity.RESULT_OK) {
                etDestiny.setText(data?.extras?.getString(ListActivity.AR_CODE))
            }
        }
    }
}
