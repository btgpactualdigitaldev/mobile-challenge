package com.example.challengesavio

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View.*
import android.widget.ProgressBar
import android.widget.Spinner
import androidx.databinding.DataBindingUtil
import com.example.challengesavio.adapters.CurrenciesAdapter
import com.example.challengesavio.databinding.ActivityMainBinding
import com.example.challengesavio.utilities.CurrenciesListener
import com.example.challengesavio.viewmodels.CurrenciesViewModel
import org.koin.android.viewmodel.ext.android.viewModel

class MainActivity : AppCompatActivity(), CurrenciesListener{

    private var currenciesList : ArrayList<String>? = ArrayList()
    private var quotesList : HashMap<String,Double>? = null
    private lateinit var binding: ActivityMainBinding
    private var adapter: CurrenciesAdapter? = null
    private lateinit var spinnerOrigin : Spinner
    private lateinit var spinnerDestiny : Spinner
    private lateinit var progress : ProgressBar
    private val currenciesViewModel : CurrenciesViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        binding.lifecycleOwner = this
        binding.executePendingBindings()

        spinnerOrigin= binding.selectOrigin
        spinnerDestiny= binding.selectDestiny
        progress= binding.progressCircular

        this.let {
            currenciesViewModel.init(this,this)
        }

        initRecyclerView()
        setupObservers()

        binding.convertButton.setOnClickListener {
            val origin = spinnerOrigin.selectedItem.toString()
            val destiny = spinnerDestiny.selectedItem.toString()
            val userValue = binding.inputValue.text.toString()

            if (origin != getString(R.string.select) && destiny != getString(R.string.select) && userValue != "" && userValue != "0.0"){
                convertCurrency(origin, destiny)
            }else{
                binding.errorMessage.text= getString(R.string.error_no_input)
            }
        }

        binding.listCurrencies.setOnClickListener {

            val intent = Intent(this, ListCurrenciesActivity::class.java)
            startActivity(intent)
        }

    }

    private fun setupObservers() {
        currenciesViewModel.currenciesList.observe(this) {
            if (it != null) {
                progress.visibility= INVISIBLE
                currenciesList?.add(getString(R.string.select))
                for (item in it) {
                    currenciesList!!.add(item.key)
                }
                adapter?.setCurrencies(currenciesList!!)
            }
        }
        currenciesViewModel.quotesList.observe(this) {
            if (it != null) {
                quotesList=it
            }
        }
    }

    private fun initRecyclerView() {
        adapter = CurrenciesAdapter(this, currenciesList!!)
        spinnerOrigin.adapter = adapter;
        spinnerDestiny.adapter = adapter;
    }

    fun convertCurrency (origin : String, destiny: String){

        val junction = getString(R.string.usd)+destiny
        var userValue: String

        if (origin==getString(R.string.usd)){
            userValue = binding.inputValue.text.toString()
            binding.displayOriginValue.text= """$userValue $origin"""
        }else{
            binding.displayOriginValue.text= """${binding.inputValue.text} $origin"""
            userValue= getValueInUSD(origin).toString()
        }

        val quote :Double = quotesList?.getValue(junction)!!

        val result: String

        if(userValue != "" && userValue != "0.0" ){
            binding.containerResult.visibility= VISIBLE
            binding.errorMessage.text=""
            result = (userValue.toDouble()*quote).toString()

            binding.displayComplement.visibility= VISIBLE
            binding.displayResultValue.text= "$result $destiny"

        }else{
            binding.containerResult.visibility= GONE
            binding.errorMessage.text= getString(R.string.error_no_input)
        }

    }

    private fun getValueInUSD(origin: String) : Double{

        var result =0.0
        val quote = quotesList?.getValue(getString(R.string.usd)+origin)
        val userValue = binding.inputValue.text.toString()

        if(userValue != ""){
            result = userValue.toDouble()/quote!!
        }
        return result
    }

    override fun onCurrenciesError(message: String) {
        progress.visibility= INVISIBLE
        binding.errorMessage.text= message
    }

    override fun onQuotesError(message: String) {
        progress.visibility= INVISIBLE
        binding.errorMessage.text= message
    }

}