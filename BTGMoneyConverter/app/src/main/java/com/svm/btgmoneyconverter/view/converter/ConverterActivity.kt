package com.svm.btgmoneyconverter.view.converter

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import com.svm.btgmoneyconverter.R
import com.svm.btgmoneyconverter.utils.*
import com.svm.btgmoneyconverter.utils.CommonFunctions.replaceCharConverterActivity
import com.svm.btgmoneyconverter.view.list.ListActivity
import com.svm.btgmoneyconverter.viewmodel.ConverterVM
import kotlinx.android.synthetic.main.activity_main.*
import java.text.NumberFormat


class ConverterActivity : AppCompatActivity() {

    lateinit var viewModel: ConverterVM
    lateinit var tW: TextWatcher

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        DBAccess.initAccess(this)

        viewModel = ConverterVM()
        viewModel.initContext(this)

        btnConverter.isEnabled = false

        //Observers
        setObservables()

        //clickListenners
        setClickListeners()

        viewModel.chooseDefaultInitialValues()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val bundle = data?.extras
        if(resultCode == Activity.RESULT_OK){
            edtxTo.text = ""
            edtxFrom.text.clear()

            this.viewModel.onCurrencySelected(
                bundle?.getInt(CURRENCY_ORDER),
                bundle?.getString(CURRENCY_SELECTED)
            )
        }
    }

    private fun setObservables(){
        viewModel.inputCurrency.observe(this, Observer { inpCur ->
            tvFrom.text = replaceCharConverterActivity(
                getString(R.string.main_from_text), inpCur.name, inpCur.symbol )
        })

        viewModel.outputCurrency.observe(this, Observer { outCur ->
            tvTo.text = replaceCharConverterActivity(getString(R.string.main_to_text), outCur.name,outCur.symbol)
        })

        viewModel.enableConverter.observe(this, Observer { enabled ->
            btnConverter.isEnabled = enabled
        })

        viewModel.convertedValue.observe(this, Observer {value ->
            edtxTo.text = value
        })

    }

    private fun setClickListeners(){
        btnFrom.setOnClickListener {
            starListActivity(INPUT_CURRENCY)
        }

        btTo.setOnClickListener{
            starListActivity(OUTPUT_CURRENCY)
        }

        btnConverter.setOnClickListener{
            viewModel.makeConvert(edtxFrom.text.toString())
        }

        edtxFrom.addTextChangedListener(CurrencyTextWatcher())

    }

    private fun starListActivity(requestCode: Int){
        val intent = Intent(this, ListActivity::class.java)
        intent.putExtra("flow",requestCode)
        startActivityForResult(
            intent,
            requestCode
        )
    }





}