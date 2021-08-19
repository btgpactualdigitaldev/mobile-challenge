package br.dev.infra.btgconversiontool.ui.calculator

import android.content.Context
import android.os.Bundle
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import br.dev.infra.btgconversiontool.R
import br.dev.infra.btgconversiontool.databinding.FragmentCalculatorBinding
import com.google.android.material.snackbar.Snackbar
import dagger.hilt.android.AndroidEntryPoint
import java.text.NumberFormat
import java.util.*

@AndroidEntryPoint
class CalculatorFragment : Fragment() {

    private lateinit var calculatorViewModel: CalculatorViewModel
    private var _binding: FragmentCalculatorBinding? = null

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        calculatorViewModel =
            ViewModelProvider(this).get(CalculatorViewModel::class.java)

        _binding = FragmentCalculatorBinding.inflate(inflater, container, false)

        binding.progressBar.visibility = View.VISIBLE
        binding.fieldAmount.visibility = View.INVISIBLE
        binding.spinnerTo.visibility = View.INVISIBLE
        binding.spinnerFrom.visibility = View.INVISIBLE
        binding.textConverted.visibility = View.INVISIBLE
        binding.splitter.visibility = View.INVISIBLE

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        //Update data from API
        calculatorViewModel.updateData()

        //Load Spinners
        calculatorViewModel.currencyList.observe(viewLifecycleOwner, { currencyList ->
            val spinnerDataFrom = ArrayAdapter<String>(
                requireContext(),
                R.layout.support_simple_spinner_dropdown_item
            )
            val spinnerDataTo = ArrayAdapter<String>(
                requireContext(),
                R.layout.support_simple_spinner_dropdown_item
            )
            currencyList?.forEach {
                if (spinnerDataFrom.getPosition(it.id.plus(" : ".plus(it.description))) == -1) {
                    spinnerDataFrom.add(it.id.plus(" : ".plus(it.description)))
                }
                if (spinnerDataTo.getPosition(it.id.plus(" : ".plus(it.description))) == -1) {
                    spinnerDataTo.add(it.id.plus(" : ".plus(it.description)))
                }
            }

            binding.spinnerFrom.adapter = spinnerDataFrom

            binding.spinnerFrom.onItemSelectedListener =
                object : AdapterView.OnItemSelectedListener {
                    override fun onItemSelected(
                        parent: AdapterView<*>?,
                        view: View?,
                        position: Int,
                        id: Long
                    ) {
                        var selectText = binding.spinnerFrom.selectedItem.toString()
                        selectText = selectText.substringBefore(" :")
                        calculatorViewModel.getQuote(selectText, "ORIGIN")
                    }

                    override fun onNothingSelected(parent: AdapterView<*>?) {
                    }
                }

            binding.spinnerTo.adapter = spinnerDataTo
            binding.spinnerTo.onItemSelectedListener =
                object : AdapterView.OnItemSelectedListener {
                    override fun onItemSelected(
                        parent: AdapterView<*>?,
                        view: View?,
                        position: Int,
                        id: Long
                    ) {
                        var selectText = binding.spinnerTo.selectedItem.toString()
                        selectText = selectText.substringBefore(" :")
                        calculatorViewModel.getQuote(selectText, "DESTINY")
                    }

                    override fun onNothingSelected(parent: AdapterView<*>?) {

                    }

                }
        })

        binding.fieldAmount.addTextChangedListener {
            calculatorViewModel.setAmount(it.toString())
        }

        binding.fieldAmount.setOnKeyListener { _, keyCode, event ->
            if (keyCode == KeyEvent.KEYCODE_ENTER && event.action == KeyEvent.ACTION_UP) {
                view.hideKeyboard()
                return@setOnKeyListener true
            }
            false
        }

        calculatorViewModel.status.observe(viewLifecycleOwner, {
            if (it != "") {
                val message = getString(R.string.offline).plus(it)
                Snackbar.make(view, message, Snackbar.LENGTH_SHORT).show()
            }
        })

        //Watch conversion
        calculatorViewModel.currency.observe(viewLifecycleOwner, {
            binding.progressBar.visibility = View.INVISIBLE
            binding.fieldAmount.visibility = View.VISIBLE
            binding.spinnerTo.visibility = View.VISIBLE
            binding.spinnerFrom.visibility = View.VISIBLE
            binding.textConverted.visibility = View.VISIBLE
            binding.splitter.visibility = View.VISIBLE

            val currFormat = NumberFormat.getCurrencyInstance(Locale.getDefault())
            currFormat.currency = Currency.getInstance(calculatorViewModel.destinyId)


            if (it != null) {
                binding.textConverted.text = currFormat.format(it).toString()
            } else {
                binding.textConverted.text = getString(R.string.not_found)
            }
        })
    }


    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun View.hideKeyboard() {
        val imm = context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(windowToken, 0)
    }
}