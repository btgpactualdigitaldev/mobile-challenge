package br.com.leandrospidalieri.btgpactualconversion.ui.converter

import android.opengl.Visibility
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.findNavController
import br.com.leandrospidalieri.btgpactualconversion.databinding.FragmentConverterBinding
import br.com.leandrospidalieri.btgpactualconversion.viewmodel.ConverterViewModel
import kotlinx.android.synthetic.main.fragment_converter.*

class ConverterFragment : Fragment() {

    private val viewModel by lazy {
        ViewModelProvider(requireActivity()).get(ConverterViewModel::class.java)
    }
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val binding = FragmentConverterBinding.inflate(inflater)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel

        viewModel.selectedCurrencies.observe(viewLifecycleOwner, Observer{ currencyList->
            if(currencyList != null && currencyList.size == 2){
                first_currency_text.text = currencyList[0].code
                second_currency_text.text = currencyList[1].code
                first_currency_layout.visibility = View.VISIBLE
                converted_to_text.visibility = View.VISIBLE
                second_currency_layout.visibility = View.VISIBLE
            }
            else{
                first_currency_layout.visibility = View.GONE
                converted_to_text.visibility = View.GONE
                second_currency_layout.visibility = View.GONE
            }
        })

        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        choose_currency_button.setOnClickListener{ view:View ->
            viewModel.clearSelectedCurrencies()
            view.findNavController().navigate(
                ConverterFragmentDirections.actionConverterFragmentToCurrenciesfragment())
        }

        currency_value.addTextChangedListener(object :TextWatcher{
            override fun afterTextChanged(p0: Editable?) {
                val toConvert = p0.toString()
                if(!toConvert.isEmpty())
                    viewModel.setValueToConvert(toConvert.toDouble())
                else
                    viewModel.setValueToConvert(0.00)
            }
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
        })
    }
}