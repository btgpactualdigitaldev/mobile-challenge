package com.renderson.currency_converter.ui.result

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import androidx.navigation.fragment.navArgs
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.renderson.currency_converter.R
import com.renderson.currency_converter.databinding.FragmentConversionResultBinding
import com.renderson.currency_converter.models.ConversionResult

class ConversionResultFragment : BottomSheetDialogFragment() {

    private var _binding: FragmentConversionResultBinding? = null
    private val binding get() = _binding!!

    private lateinit var result: ConversionResult
    private val args: ConversionResultFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentConversionResultBinding.inflate(inflater, container, false)
        result = args.conversionResult
        return binding.root
    }

    private fun initView() {
        binding.run {
            amountResult.text =
                String.format(
                    getString(R.string.result),
                    result.amount,
                    result.originFormatter(),
                    result.result,
                    result.destinationFormatter()
                )
        }
    }

    override fun onStart() {
        super.onStart()
        dialog?.window?.setLayout(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT
        )
    }

    override fun onResume() {
        super.onResume()
        initView()
    }

    override fun onDestroy() {
        super.onDestroy()
        _binding = null
    }
}