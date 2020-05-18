package com.btg.teste.moneyConvert

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import com.btg.teste.R
import com.btg.teste.databinding.FragmentMoneyConvertBinding
import com.btg.teste.viewmodel.MoneyConvertViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject


class MoneyConvertFragment : Fragment(), MoneyConvertContracts.MoneyConvertPresenterOutput,
    MoneyConvertContracts.MoneyConvertClick {

    @Inject
    lateinit var iMoneyConvertPresenterInput: MoneyConvertContracts.MoneyConvertPresenterInput

    private lateinit var moneyConvertViewModel: MoneyConvertViewModel
    private lateinit var binding: FragmentMoneyConvertBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentMoneyConvertBinding.inflate(layoutInflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        DaggerMoneyConvertComponents
            .builder()
            .moneyConvertModule(
                MoneyConvertModule(
                    requireActivity(),
                    binding.root,
                    moneyConvertFragment = this
                )
            )
            .build()
            .inject(this)

        lifecycleScope.launch {

            binding.imgLogo.setImageDrawable(
                ContextCompat.getDrawable(
                    requireContext(),
                    R.mipmap.ic_launcher
                )
            )

            moneyConvertViewModel =
                activity?.run {
                    ViewModelProvider(requireActivity()).get(MoneyConvertViewModel::class.java)
                } ?: MoneyConvertViewModel()

            binding.moneyConvert = moneyConvertViewModel.moneyConvert
            binding.click = this@MoneyConvertFragment
        }
    }

    override fun returnErrorMessage(value: Int) {
        moneyConvertViewModel.moneyConvert.errorMessage = requireActivity().getString(value)
    }

    override fun returnValueFinal(value: String) {
        moneyConvertViewModel.moneyConvert.valueFinal = value
    }

    override fun returnValue(value: String) {
        moneyConvertViewModel.moneyConvert.value = value
    }

    override fun origin(view: View?) {
        hideKeyboard(requireContext(), binding.editStepOne)
        iMoneyConvertPresenterInput.startOrigin()
    }

    override fun recipient(view: View?) {
        hideKeyboard(requireContext(), binding.editStepOne)
        iMoneyConvertPresenterInput.startRecipient()
    }

    override fun calculate(editable: android.text.Editable) {
        returnValue(editable.toString())
        moneyConvertViewModel.moneyConvert.errorMessage = ""
        iMoneyConvertPresenterInput.startCalculate(moneyConvertViewModel.moneyConvert)
    }

    override fun onResume() {
        super.onResume()
        moneyConvertViewModel.moneyConvert.errorMessage = ""
        iMoneyConvertPresenterInput.startCalculate(moneyConvertViewModel.moneyConvert)
    }

    fun hideKeyboard(context: Context, editText: View) {
        val imm: InputMethodManager =
            context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(editText.windowToken, 0)
    }
}
