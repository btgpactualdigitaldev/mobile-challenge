package com.alexandreac.mobilechallenge.view.ui

import android.app.Application
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.inputmethod.InputMethodManager
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.doOnTextChanged
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.room.Room
import com.alexandreac.mobilechallenge.R
import com.alexandreac.mobilechallenge.databinding.ActivityCurrencyListBinding
import com.alexandreac.mobilechallenge.model.api.CurrencyApi
import com.alexandreac.mobilechallenge.model.dao.CurrencyDao
import com.alexandreac.mobilechallenge.model.data.Currency
import com.alexandreac.mobilechallenge.model.database.AppDatabase
import com.alexandreac.mobilechallenge.model.datasource.CurrencyDataSource
import com.alexandreac.mobilechallenge.model.datasource.CurrencyLocalDataSource
import com.alexandreac.mobilechallenge.model.repository.CurrencyRepository
import com.alexandreac.mobilechallenge.util.AppExecutors
import com.alexandreac.mobilechallenge.view.adapter.BindingAdapters
import com.alexandreac.mobilechallenge.view.adapter.CurrenciesAdapter
import com.alexandreac.mobilechallenge.viewmodel.CurrencyListViewModel
import com.alexandreac.mobilechallenge.viewmodel.factory.CurrencyListViewModelFactory
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class CurrencyListActivity : AppCompatActivity() {

    lateinit var viewModel: CurrencyListViewModel
    private var convertFrom = false
    private var convertTo = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding: ActivityCurrencyListBinding =
            DataBindingUtil.setContentView(this, R.layout.activity_currency_list)
        convertFrom = intent.getBooleanExtra(MainActivity.CONVERT_FROM, false)
        convertTo = intent.getBooleanExtra(MainActivity.CONVERT_TO, false)
        viewModel = createViewModel(application)
        binding.viewModel = viewModel
        binding.currencyListBack.setOnClickListener {
            finish()
        }
        var adapter = CurrenciesAdapter(emptyList())
        adapter.onItemClick = {
            returnToMain(it)
        }
        binding.currencyListItems.adapter = adapter
        binding.currencyListItems.layoutManager = LinearLayoutManager(this)
        binding.lifecycleOwner = this
        val observer = object : Observer<List<Currency>>{
            override fun onChanged(t: List<Currency>?) {
                BindingAdapters.setItems(binding.currencyListItems, t!!.toMutableList())
            }
        }
        binding.currencyListSearchEdt.doOnTextChanged { text, _, _, _ ->
            viewModel.search(text.toString())
        }

        binding.currencyListSearchBtn.setOnClickListener {
            viewModel.search(binding.currencyListSearchEdt.text.toString())
        }
        binding.currencyListSwitch.setOnCheckedChangeListener{compoundButton, isChecked ->
            if(isChecked){
                viewModel.orderListByName()
            } else {
                viewModel.orderListByInitials()
            }
        }
        viewModel.currencies.observe(this, observer)
        this.lifecycle.addObserver(viewModel)
    }

    fun returnToMain(item:Currency){
        var returnIntent = Intent()
        if(convertFrom){
            returnIntent.putExtra(MainActivity.CONVERT_FROM_RESULT_INITIALS, item.initials)
            returnIntent.putExtra(MainActivity.CONVERT_FROM_RESULT_NAME, item.name)
            setResult(MainActivity.CONVERT_FROM_RESULT_OK, returnIntent)
        } else if(convertTo){
            returnIntent.putExtra(MainActivity.CONVERT_TO_RESULT_INITIALS, item.initials)
            returnIntent.putExtra(MainActivity.CONVERT_TO_RESULT_NAME, item.name)
            setResult(MainActivity.CONVERT_TO_RESULT_OK, returnIntent)
        }
        finish()
    }

    fun createViewModel(application: Application):CurrencyListViewModel{
        val retrofit = Retrofit.Builder().baseUrl("http://apilayer.net/api/")
            .addConverterFactory(GsonConverterFactory.create()).build()
        val currencyDataSource = CurrencyDataSource(retrofit.create(CurrencyApi::class.java))
        val localDataSource = CurrencyLocalDataSource(currencyDao(application), AppExecutors())
        val repository = CurrencyRepository(currencyDataSource, localDataSource)
        val factory = CurrencyListViewModelFactory(repository, application)
        return ViewModelProviders.of(this, factory).get(CurrencyListViewModel::class.java)
    }

    fun currencyDao(applicationContext: Application):CurrencyDao{
        return Room.databaseBuilder(applicationContext,
                                    AppDatabase::class.java,"currency-app")
                                    .build()
                                    .currencyDao()
    }
}
