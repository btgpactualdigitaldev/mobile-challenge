package com.br.btg.ui.fragments

import android.content.Context
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.navigation.fragment.NavHostFragment
import com.br.btg.R
import com.br.btg.databinding.FragmentConversorBinding
import com.br.btg.ui.viewmodels.ConversorViewModel
import com.br.btg.utils.*
import kotlinx.android.synthetic.main.fragment_conversor.*
import org.koin.android.viewmodel.ext.android.sharedViewModel
import java.math.RoundingMode


class ConversorFragment : Fragment() {

    private lateinit var fragmentConversorBinding: FragmentConversorBinding

    private val viewModel: ConversorViewModel by sharedViewModel<ConversorViewModel>()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        fragmentConversorBinding = FragmentConversorBinding.inflate(inflater, container, false)
        return fragmentConversorBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)


        fragmentConversorBinding.lifecycleOwner = this

        fragmentConversorBinding.buttonCoinOrigem.text = viewModel.getCurrencyOrigem().value ?: "USD"
        fragmentConversorBinding.buttonCoinDestination.text = viewModel.getCurrencyDestination().value ?: "BRL"
        fragmentConversorBinding.textviewCoinOrigem.text = "USD"
        fragmentConversorBinding.textviewCoinDestiny.text = viewModel.getCurrencyDestination().value ?: "BRL"

        fragmentConversorBinding.buttonCoinOrigem.setOnClickListener(){
            viewModel.setNavigationId(ID_ORIGEM)
            NavHostFragment.findNavController(this).navigate(R.id.action_conversorFragment_to_listCoinsFragment)
        }

        fragmentConversorBinding.buttonCoinDestination.setOnClickListener() {
            viewModel.setNavigationId(ID_DESTINATION)
            NavHostFragment.findNavController(this).navigate(R.id.action_conversorFragment_to_listCoinsFragment)
        }

        fragmentConversorBinding.edittextValorConverter.addTextChangedListener(object :TextWatcher {
            override fun afterTextChanged(text: Editable?) {
                if(text.toString().isNotEmpty()) {
                    callConverter()
                }
                else
                    fragmentConversorBinding.textviewValue.text = "0.0"
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
        })

    }


    private fun converter(origem: String, destiny: String, ammount: String) {

        viewModel.converterPrice(origem, destiny, ammount).observe(viewLifecycleOwner, Observer { resource ->
            resource.data?.let {
                it?.quotes?.map { result ->  calculeFinal(result.value.toDouble()) }
            }
            resource.error?.let { showError(it) }
        })
    }

    private fun calculeFinal(value : Double) {
        val product = value *  fragmentConversorBinding.edittextValorConverter.text.toString().toDouble()
        fragmentConversorBinding.textviewValue.text = DecimalFormat(product)
    }

    private fun DecimalFormat(number : Double) : String {
        var formated = Math.round(number * 100) / 100.0
        return formated.toString().replace('.',',')
    }


    private fun callConverter() {
        if(textview_coin_destiny.text.isNotEmpty() && textview_coin_origem.text.isNotEmpty() && edittext_valor_converter.text.isNotEmpty()) {
            converter (
                fragmentConversorBinding.textviewCoinOrigem.text.toString(),
                fragmentConversorBinding.textviewCoinDestiny.text.toString(),
                fragmentConversorBinding.edittextValorConverter.text.toString()
            )
        }
    }

    object Utils {

        fun hideSoftKeyBoard(context: Context, view: View) {
            try {
                val imm = context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm?.hideSoftInputFromWindow(view.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)
            } catch (e: Exception) {
                // TODO: handle exception
                e.printStackTrace()
            }

        }
    }

    override fun onStart() {
        super.onStart()
        if(!verifyNetwork()) showError(NO_NETWORK)
    }

    override fun onResume() {
        super.onResume()
        if(!verifyNetwork()) showError(NO_NETWORK)
    }



}
