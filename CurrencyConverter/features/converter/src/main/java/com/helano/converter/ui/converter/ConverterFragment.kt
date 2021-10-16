package com.helano.converter.ui.converter

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.Navigation.findNavController
import androidx.navigation.fragment.navArgs
import com.helano.converter.R
import com.helano.converter.databinding.FragmentConverterBinding
import com.helano.converter.ext.afterTextChanged
import com.helano.shared.enums.Info
import com.helano.shared.view.ErrorMessageView
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class ConverterFragment : Fragment() {

    private lateinit var binding: FragmentConverterBinding
    private val viewModel by viewModels<ConverterViewModel>()
    private val args: ConverterFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            inflater, R.layout.fragment_converter, container, false
        )
        binding.viewModel = viewModel
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        binding.lifecycleOwner = viewLifecycleOwner
        viewModel.start()
        setBindings()
        handleNavArgs()
        ErrorMessageView(binding.container, viewLifecycleOwner)
    }

    private fun setBindings() {
        binding.fromView.setOnClickListener {
            findNavController(it).navigate(
                ConverterFragmentDirections.actionSearchCurrency(
                    Info.FROM
                )
            )
        }

        binding.toView.setOnClickListener {
            findNavController(it).navigate(
                ConverterFragmentDirections.actionSearchCurrency(
                    Info.TO
                )
            )
        }

        binding.swapButton.setOnClickListener {
            viewModel.onSwapClicked(binding.currencyValue.text.toString())
        }

        binding.currencyValue.afterTextChanged { viewModel.onValueChanged(it) }
    }

    private fun handleNavArgs() {
        if (args.code.isNotEmpty()) {
            viewModel.updateCurrencyInfo(args.code, args.info, true)
        }
    }
}