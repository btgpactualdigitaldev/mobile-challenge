package com.btgpactual.currencyconverter.util

import android.text.TextWatcher
import android.util.TypedValue
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.CurrencyEntity
import com.btgpactual.currencyconverter.data.model.CurrencyModel
import com.btgpactual.currencyconverter.ui.fragment.CurrencyConversionFragment
import com.google.android.material.textfield.TextInputEditText
import kotlinx.android.synthetic.main.fragment_currency_conversion.*
import java.io.IOException

const val TEXT_SIZE_BIG = 16
const val TEXT_SIZE_MEDIUM = 13
const val TEXT_SIZE_SMALL = 10

fun String.removeInvalidCharacters(): String {
    return with(this){
        this.replace(".", "").replace(",", ".")
    }
}

fun TextInputEditText.clearTextWithNoTextWatcher(textWatcher: TextWatcher){
    return with(this){
        removeTextChangedListener(textWatcher)
        text?.clear()
        addTextChangedListener(textWatcher)
    }
}

fun TextInputEditText.setTextWithNoTextWatcher(text:String, textWatcher: TextWatcher){
    return with(this){
        removeTextChangedListener(textWatcher)
        setText(text)
        addTextChangedListener(textWatcher)
    }
}

fun TextInputEditText.setAdequateTextSize(){
    return with(this){
        val size = if(text.isNullOrBlank()) 0 else {text?.length?:0}

        if(size>15){
            setTextSize(
                TypedValue.COMPLEX_UNIT_DIP, (TEXT_SIZE_SMALL).toFloat()
            )
        }else if(size>10){
            setTextSize(
                TypedValue.COMPLEX_UNIT_DIP, (TEXT_SIZE_MEDIUM).toFloat()
            )
        }else{
            setTextSize(
                TypedValue.COMPLEX_UNIT_DIP, (TEXT_SIZE_BIG).toFloat()
            )
        }
    }
}

fun TextInputEditText.setSelectionToEnd(){
    return with(this){
        setSelection(text.toString().length)
    }
}
