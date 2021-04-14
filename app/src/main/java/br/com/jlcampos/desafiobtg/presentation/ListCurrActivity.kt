package br.com.jlcampos.desafiobtg.presentation

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.jlcampos.desafiobtg.data.model.Currency
import br.com.jlcampos.desafiobtg.databinding.ActivityListCurrBinding
import br.com.jlcampos.desafiobtg.presentation.adapter.CurrenciesAdapter

class ListCurrActivity : AppCompatActivity(), TextWatcher, View.OnClickListener {

    private lateinit var binding: ActivityListCurrBinding

    private lateinit var viewModel: ListCurrenciesViewModel

    private var mDestOrig: Int = 0
    private var allCurrencies: ArrayList<Currency> = ArrayList()

    companion object {
        const val LAUNCH_SECOND_ACTIVITY = 1
        const val EXTRA_LIST = "EXTRA_LIST"
        const val EXTRA_FLAG = "EXTRA_FLAG"
        const val EXTRA_RESULT = "EXTRA_RESULT"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityListCurrBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val bundle: Bundle? = intent.extras

        if (bundle != null) {
            allCurrencies = bundle.getParcelableArrayList<Currency>(EXTRA_LIST) as ArrayList<Currency>
            mDestOrig = bundle.getInt(EXTRA_FLAG)
        }

        viewModel = ViewModelProvider(this).get(ListCurrenciesViewModel::class.java)

        binding.listCurrBtBack.setOnClickListener(this)
        binding.listCurrEtResearch.addTextChangedListener(this)

        allCurrencies.let { allCurr ->
            with(binding.listCurrRv) {
                layoutManager = LinearLayoutManager(context)
                setHasFixedSize(true)
                adapter = CurrenciesAdapter(allCurr) {
                    selected(it, mDestOrig)
                }
            }
        }

        viewModel.listCurrLiveData.observe(this, fun(list: ArrayList<Currency>) {
            binding.listCurrRv.adapter = CurrenciesAdapter(list) {
                selected(it, mDestOrig)
            }
        })
    }

    override fun onClick(view: View) {
        when (view) {
            binding.listCurrBtBack -> {
                finish()
            }
        }
    }

    private fun selected(currency: Currency, mFlag: Int) {
        val returnIntent = Intent()
        returnIntent.putExtra(EXTRA_RESULT, currency)
        returnIntent.putExtra(EXTRA_FLAG, mFlag)
        setResult(Activity.RESULT_OK, returnIntent)
        finish()
    }

    override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
    }

    override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        viewModel.filterCurr(binding.listCurrEtResearch.text.toString(), allCurrencies, false)
    }

    override fun afterTextChanged(p0: Editable?) {
    }
}