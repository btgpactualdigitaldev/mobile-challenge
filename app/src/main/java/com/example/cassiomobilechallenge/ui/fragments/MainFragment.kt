package com.example.cassiomobilechallenge.ui.fragments

import android.content.Context
import androidx.lifecycle.ViewModelProviders
import android.os.Bundle
import android.text.Editable
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.Observer
import com.example.cassiomobilechallenge.R
import com.example.cassiomobilechallenge.models.Currency
import com.example.cassiomobilechallenge.viewmodels.MainViewModel
import kotlinx.android.synthetic.main.fragment_currency.*

class MainFragment : Fragment() {

    companion object {
        fun newInstance() = MainFragment()
    }

    private lateinit var viewModel: MainViewModel

    private lateinit var buttomFrom: Button
    private lateinit var buttomTo: Button
    private lateinit var resultTextView: TextView
    private lateinit var valueEntry: EditText

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View {

        var view: View = inflater.inflate(R.layout.main_fragment, container, false)

        buttomFrom = view.findViewById(R.id.buttonFrom)
        buttomTo = view.findViewById(R.id.buttonTo)
        resultTextView = view.findViewById(R.id.resultTextView)
        valueEntry = view.findViewById(R.id.valueEntry)

        return view
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProviders.of(requireActivity()).get(MainViewModel::class.java)

        setupUI()
        setupAmount()
        setupListeners()
        setupButtons()
        caseError()
    }

    fun setupUI() {

        if (viewModel.currencyFrom.value != null) {
            buttomFrom.text = viewModel.currencyFrom.value!!.currencyCode
        }

        if (viewModel.currencyTo.value != null) {
            buttomTo.text = viewModel.currencyTo.value!!.currencyCode
        }

        if (viewModel.valueEntry.value != null) {
            valueEntry.setText(viewModel.valueEntry.value!!.toString())
        } else {
            buttomFrom.isEnabled = false
            buttomTo.isEnabled = false
        }

    }

    fun setupAmount() {
        valueEntry.addTextChangedListener { text: Editable? ->
            if (text != null && !text.trim().isEmpty()) {
                buttomFrom.isEnabled = !text.trim().isEmpty()
                try {
                    viewModel.valueEntry.postValue(text.toString().toDouble())
                } catch (e: NumberFormatException) {
                    Toast.makeText(context, "Erro ao converter: " + e.message, Toast.LENGTH_LONG).show()
                }
            }
        }

        valueEntry.setOnEditorActionListener { _, actionId, _ ->
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                if (viewModel.currencyFrom.value != null && viewModel.currencyTo.value != null) {
                    viewModel.getConversion(viewModel.currencyTo.value!!.currencyCode)
                    getConversion()
                }
                true
            }
            false
        }
    }

    fun setupListeners() {
        buttomFrom.setOnClickListener {
            changeFragment(CurrencyFragment.newInstance(1, "FROM"))
        }
        buttomTo.setOnClickListener {
            changeFragment(CurrencyFragment.newInstance(1, "TO"))
        }
    }

    fun setupButtons() {
        viewModel.currencyFrom.observe(this.viewLifecycleOwner, Observer { currency ->
            if (currency != null) {
                viewModel.currencyFrom.removeObservers(this.viewLifecycleOwner)
                buttomFrom.setText(currency.currencyCode)
                if (viewModel.currencyTo.value != null) {
                    viewModel.getConversion(viewModel.currencyTo.value!!.currencyCode)
                    getConversion()
                }
                buttomTo.isEnabled = true
            }
        })

        viewModel.currencyTo.observe(this.viewLifecycleOwner, Observer { currency ->
            if (currency != null) {
                viewModel.currencyTo.removeObservers(this.viewLifecycleOwner)
                buttomTo.setText(currency.currencyCode)
                viewModel.getConversion(currency.currencyCode)
                getConversion()
            }
        })
    }

    fun getConversion() {
        resultTextView.setText("Calculando...")
        viewModel.conversion.observe(this.viewLifecycleOwner, Observer { conversion ->
            if (conversion != null) {
                viewModel.conversion.removeObservers(this)
                var text: String = "Resultado de " + buttomFrom.text + " -> " + buttomTo.text + " : "
                var result = text + viewModel.calculateConversion().toString()
                resultTextView.setText(result)
            }
        })
    }

    fun caseError() {
        viewModel.errorMessage.observe(this.viewLifecycleOwner, Observer { error ->
            if (error != null) {
                viewModel.errorMessage.removeObservers(this.viewLifecycleOwner)
                Toast.makeText(context, error, Toast.LENGTH_LONG).show()
            }
        })
    }

    fun changeFragment(fragment: Fragment) {
        activity?.supportFragmentManager?.beginTransaction()?.replace(R.id.container, fragment)
            ?.commitNow()
    }

}