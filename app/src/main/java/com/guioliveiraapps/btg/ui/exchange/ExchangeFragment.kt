package com.guioliveiraapps.btg.ui.exchange

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Spinner
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.guioliveiraapps.btg.MainActivityViewModel
import com.guioliveiraapps.btg.R
import com.guioliveiraapps.btg.room.Currency
import com.guioliveiraapps.btg.util.Util
import kotlinx.android.synthetic.main.fragment_exchange.*
import kotlinx.android.synthetic.main.include_internet_error.*
import kotlinx.android.synthetic.main.include_server_error.*


class ExchangeFragment : Fragment() {

    private lateinit var viewModel: MainActivityViewModel

    private lateinit var spFirst: Spinner
    private lateinit var spSecond: Spinner

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        return inflater.inflate(R.layout.fragment_exchange, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        try {
            viewModel =
                ViewModelProviders.of(requireActivity()).get(MainActivityViewModel::class.java)

            spFirst = view.findViewById(R.id.sp_first)
            spSecond = view.findViewById(R.id.sp_second)

            setupViewModelObservers()
            setupListeners()
        } catch (e: Exception) {
            Util.showErrorSnackBar(root_view)
        }
    }

    private fun setupListeners() {
        btn_try_again_internet.setOnClickListener {
            viewModel.getCurrencies(requireContext())
            viewModel.getQuotes(requireContext())
        }

        btn_try_again_server.setOnClickListener {
            viewModel.getCurrencies(requireContext())
            viewModel.getQuotes(requireContext())
        }

        et_valor?.addTextChangedListener {
            if (!it.isNullOrEmpty()) {
                updateFinalValue()
            } else {
                viewModel.finalValue.value = 0.0
            }
        }

        spFirst.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onNothingSelected(parent: AdapterView<*>?) {

            }

            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {
                updateFinalValue()
            }
        }

        spSecond.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onNothingSelected(parent: AdapterView<*>?) {

            }

            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {
                updateFinalValue()
            }
        }

    }

    private fun setupViewModelObservers() {
        viewModel.loading.observe(viewLifecycleOwner, Observer {
            if (it) {
                loading.visibility = View.VISIBLE
            } else {
                loading.visibility = View.GONE
            }
        })

        viewModel.internetError.observe(viewLifecycleOwner, Observer {
            if (it) {
                include_internet_error.visibility = View.VISIBLE

                include_server_error.visibility = View.GONE
                loading.visibility = View.GONE
                body.visibility = View.GONE
            } else {
                include_internet_error.visibility = View.GONE
            }
        })

        viewModel.serverError.observe(viewLifecycleOwner, Observer {
            if (it) {
                include_server_error.visibility = View.VISIBLE

                include_internet_error.visibility = View.GONE
                loading.visibility = View.GONE
                body.visibility = View.GONE
            } else {
                include_internet_error.visibility = View.GONE
            }
        })

        viewModel.updateError.observe(viewLifecycleOwner, Observer {
            update_error.visibility = it
        })

        viewModel.showFragments.observe(viewLifecycleOwner, Observer {
            if (it) {
                setupFirstSpinner(viewModel.currencies.value!!)
                setupSecondSpinner(viewModel.currencies.value!!)

                viewModel.loading.postValue(false)
                body.visibility = View.VISIBLE
            }
        })

        viewModel.finalValue.observe(viewLifecycleOwner, Observer {
            txt_final_value.text = it.toString()
        })
    }

    private fun updateFinalValue() {
        if (!et_valor.text.isNullOrEmpty()) {
            viewModel.updateFinalValue(
                spFirst.selectedItem as Currency,
                spSecond.selectedItem as Currency,
                et_valor.text.toString().toDouble()
            )
        }
    }

    private fun setupFirstSpinner(currencies: List<Currency>) {
        val adapter: ArrayAdapter<Currency> = ArrayAdapter(
            requireContext(),
            R.layout.support_simple_spinner_dropdown_item,
            currencies
        )

        adapter.setDropDownViewResource(R.layout.spinner_text)
        spFirst.adapter = adapter
    }

    private fun setupSecondSpinner(currencies: List<Currency>) {
        val adapter: ArrayAdapter<Currency> = ArrayAdapter(
            requireContext(),
            R.layout.support_simple_spinner_dropdown_item,
            currencies
        )

        adapter.setDropDownViewResource(R.layout.spinner_text)
        spSecond.adapter = adapter
    }

}
