package br.com.albertomagalhaes.btgcurrencies.extension

import android.widget.Toast
import androidx.annotation.StringRes
import androidx.fragment.app.Fragment

fun Fragment.showSimpleMessage(@StringRes messageRes: Int){
    Toast.makeText(requireContext(), getString(messageRes), Toast.LENGTH_SHORT).show()
}

