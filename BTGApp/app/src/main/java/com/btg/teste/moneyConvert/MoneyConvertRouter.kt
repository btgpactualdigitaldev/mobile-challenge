package com.btg.teste.moneyConvert

import android.os.Bundle
import android.view.View
import androidx.navigation.findNavController
import com.btg.teste.R

class MoneyConvertRouter(private val view: View) {

    fun navigationToConvertListOrigin() {
        val bundle = Bundle()
        bundle.putBoolean("origin", true)
        view.findNavController()
            .navigate(R.id.action_moneyConvertFragment_to_conversionFragment, bundle)
    }

    fun navigationToConvertListRecipient() {
        val bundle = Bundle()
        bundle.putBoolean("origin", false)
        view.findNavController()
            .navigate(R.id.action_moneyConvertFragment_to_conversionFragment, bundle)
    }

}