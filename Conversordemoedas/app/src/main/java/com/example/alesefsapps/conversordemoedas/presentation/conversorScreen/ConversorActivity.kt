package com.example.alesefsapps.conversordemoedas.presentation.conversorScreen

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.PorterDuff
import android.os.Bundle
import android.util.Log
import android.widget.EditText
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.presentation.base.BaseActivity
import com.example.alesefsapps.conversordemoedas.presentation.selectorScreen.SelectorActivity
import com.example.alesefsapps.conversordemoedas.utils.NumberTextWatcher
import kotlinx.android.synthetic.main.activity_conversor.*
import kotlinx.android.synthetic.main.include_toolbar.*
import java.lang.Double.parseDouble
import java.lang.Exception
import java.math.BigDecimal
import java.math.RoundingMode
import java.text.SimpleDateFormat
import java.util.*


class ConversorActivity : BaseActivity() {

    private val sharedPrefFile = "kotlinsharedpreference"
    lateinit var sharedPreferences: SharedPreferences
    lateinit var editor: SharedPreferences.Editor

    lateinit var textCurrency: String
    lateinit var sharedValueIn: String
    lateinit var sharedValueOut: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conversor)

        setupToolbar(toolbarMain, R.string.conversor_title, false)

        init()
    }

    override fun onDestroy() {
        super.onDestroy()

        editor = sharedPreferences.edit()
        editor.clear()
        editor.apply()

        button_input.text = getString(R.string.coin_input)
        button_output.text = getString(R.string.coin_output)
        label_out_value.text = getString(R.string.zero)
    }

    @SuppressLint("SetTextI18n")
    private fun init() {
        setClickListeners()
        edit_text_value.myCustomTextWatcher()

        sharedPreferences = getSharedPreferences(sharedPrefFile, Context.MODE_PRIVATE)

        val sharedCodeIn = sharedPreferences.getString("EXTRA_CODE_INPUT", "defaultcode")
        val sharedNameIn = sharedPreferences.getString("EXTRA_NAME_INPUT", "defaultname")
        val sharedCodeOut = sharedPreferences.getString("EXTRA_CODE_OUTPUT", "defaultcode")
        val sharedNameOut = sharedPreferences.getString("EXTRA_NAME_OUTPUT", "defaultname")

        sharedValueIn = sharedPreferences.getString("EXTRA_VALUE_INPUT", "defaultvalue")
        sharedValueOut = sharedPreferences.getString("EXTRA_VALUE_OUTPUT", "defaultvalue")
        textCurrency = "1"


        if (!sharedCodeIn.equals("defaultcode") && !sharedNameIn.equals("defaultname")) {
            button_input.text = "$sharedCodeIn - $sharedNameIn"
        } else {
            button_input.text = getString(R.string.coin_input)
        }

        if (!sharedCodeOut.equals("defaultcode") && !sharedNameOut.equals("defaultname")) {
            button_output.text = "$sharedCodeOut - $sharedNameOut"
        } else {
            button_output.text = getString(R.string.coin_output)
        }

        label_date_of_values.text = getText(R.string.data_do_valor)
        getDataTime()
    }

    @SuppressLint("SimpleDateFormat")
    private fun getDataTime() {
        try {
            val format = SimpleDateFormat("dd/MM/yyyy hh:mm:ss")
            val netDate = Date(intent.getStringExtra(EXTRA_TIMESTAMP)?.toLong()!!.times(1000))
            label_date_of_values.text = format.format(netDate)
        } catch (e: Exception) {
            e.toString()
        }
    }


    fun EditText.myCustomTextWatcher() {
        this.addTextChangedListener(object : NumberTextWatcher(this) {
            override fun validate(editText: EditText, text: String) {
                if (text.isEmpty()) {
                    textCurrency = "1"
                    edit_text_value.getBackground().mutate().setColorFilter(resources.getColor(R.color.colorAccent), PorterDuff.Mode.SRC_ATOP)
                } else {
                    textCurrency = text.replace("[$,,]".toRegex(), "")
                    edit_text_value.getBackground().mutate().setColorFilter(resources.getColor(R.color.colorPrimaryDark), PorterDuff.Mode.SRC_ATOP)

                    if (!sharedValueIn.equals("defaultvalue") || !sharedValueOut.equals("defaultvalue")) {

                        val valueOut = parseDouble(sharedValueIn)
                        val valueIn = parseDouble(sharedValueOut)
                        val currency = parseDouble(textCurrency)

                        val conversion = (currency * valueIn / valueOut)
                        val convertedValue: BigDecimal = BigDecimal.valueOf(conversion).setScale(2, RoundingMode.HALF_EVEN)

                        label_out_value.text = convertedValue.toString()

                    } else {
                        label_out_value.text = getString(R.string.zero)
                    }
                }
            }
        })
    }


    private fun setClickListeners() {
        button_input.setOnClickListener {
            val intent = Intent(this@ConversorActivity, SelectorActivity::class.java)
            intent.putExtra(STATE_CURRENCY,"input")
            startActivity(intent)
        }

        button_output.setOnClickListener {
            val intent = Intent(this@ConversorActivity, SelectorActivity::class.java)
            intent.putExtra(STATE_CURRENCY,"output")
            startActivity(intent)
        }
    }


    companion object {
        private const val STATE_CURRENCY = "STATE_CURRENCY"

        private const val EXTRA_CODE_INPUT = "EXTRA_CODE_INPUT"
        private const val EXTRA_NAME_INPUT = "EXTRA_NAME_INPUT"
        private const val EXTRA_VALUE_INPUT = "EXTRA_VALUE_INPUT"

        private const val EXTRA_CODE_OUTPUT = "EXTRA_CODE_OUTPUT"
        private const val EXTRA_NAME_OUTPUT = "EXTRA_NAME_OUTPUT"
        private const val EXTRA_VALUE_OUTPUT = "EXTRA_VALUE_OUTPUT"

        private const val EXTRA_TIMESTAMP = "EXTRA_TIMESTAMP"


        fun getStartIntent(context: Context, code: String, name: String?, value: BigDecimal?, state: String, timestamp: Int): Intent {

            val sharedPrefFile = "kotlinsharedpreference"
            var sharedPreferences: SharedPreferences = context.getSharedPreferences(sharedPrefFile, Context.MODE_PRIVATE)
            var editor: SharedPreferences.Editor = sharedPreferences.edit()

            return Intent(context, ConversorActivity::class.java).apply {
                putExtra(STATE_CURRENCY, state)

                if (state == "input") {
                    putExtra(EXTRA_CODE_INPUT, code)
                    putExtra(EXTRA_NAME_INPUT, name)
                    putExtra(EXTRA_VALUE_INPUT, value)
                    putExtra(EXTRA_TIMESTAMP, timestamp.toString())

                    editor.putString("EXTRA_CODE_INPUT", code)
                    editor.putString("EXTRA_NAME_INPUT", name)
                    editor.putString("EXTRA_VALUE_INPUT", value.toString())
                }

                if (state == "output") {
                    putExtra(EXTRA_CODE_OUTPUT, code)
                    putExtra(EXTRA_NAME_OUTPUT, name)
                    putExtra(EXTRA_VALUE_OUTPUT, value)
                    putExtra(EXTRA_TIMESTAMP, timestamp.toString())

                    editor.putString("EXTRA_CODE_OUTPUT", code)
                    editor.putString("EXTRA_NAME_OUTPUT", name)
                    editor.putString("EXTRA_VALUE_OUTPUT", value.toString())
                }

                editor.apply()
                editor.commit()
            }
        }
    }
}
