package com.example.exchange.fragment

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.View
import android.widget.ArrayAdapter
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.ViewModelProviders
import com.example.exchange.R
import com.example.exchange.databinding.FragmentConverterBinding
import com.example.exchange.viewmodel.ConverterViewModel

open class ConverterFragment : Fragment(R.layout.fragment_converter) {

    private lateinit var viewModel: ConverterViewModel
    private lateinit var binding: FragmentConverterBinding

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = FragmentConverterBinding.bind(view)

        viewModel = ViewModelProviders.of(this).get(ConverterViewModel::class.java)

        initObservers()
        initListeners()

        viewModel.requestData()
    }

    private fun initObservers() {
        viewModel.getData().observe(viewLifecycleOwner, {
            val listSpinner = ArrayAdapter(requireContext(), R.layout.spinner_item, it)

            with(binding) {
                spinnerCoinOne.adapter = listSpinner
                spinnerCoinTwo.adapter = listSpinner
            }
        })

        viewModel.getLoading().observe(viewLifecycleOwner, {
            binding.progressbarConverter.visibility = it
        })

        viewModel.getError().observe(viewLifecycleOwner, {
            AlertDialog.Builder(requireContext())
                .setTitle(R.string.title_dialog)
                .setMessage(R.string.message_dialog)
                .setCancelable(true)
                .show()
        })
    }

    private fun initListeners() {
        with(binding) {
            with(edittextInputValue) {
                addTextChangedListener(object : TextWatcher {

                    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

                    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}

                    override fun afterTextChanged(s: Editable?) {
                        setSelection(text.toString().length)

                        viewModel.conversionBetweenValues(spinnerCoinOne.selectedItem.toString(), spinnerCoinTwo.selectedItem.toString(), text.toString())

                        viewModel.getResult().observe(viewLifecycleOwner, {
                            textviewResult.text = it
                        })
                    }
                })
            }
        }
    }
}