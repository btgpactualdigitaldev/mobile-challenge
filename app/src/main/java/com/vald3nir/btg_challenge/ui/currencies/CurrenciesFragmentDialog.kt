package com.vald3nir.btg_challenge.ui.currencies

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.view.isVisible
import androidx.core.widget.doOnTextChanged
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.vald3nir.btg_challenge.R
import com.vald3nir.btg_challenge.core.base.BaseActivity
import kotlinx.android.synthetic.main.fragment_currency.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrenciesFragmentDialog(val listener: ICurrenciesFragmentDialog) : DialogFragment() {

    companion object {

        fun showDialog(activity: BaseActivity, listener: ICurrenciesFragmentDialog) {
            val fm: FragmentManager = activity.supportFragmentManager
            val alertDialog = CurrenciesFragmentDialog(listener)
            alertDialog.show(fm, "current_fragment_dialog")
        }
    }

    private val viewModel by viewModel<CurrenciesViewModel>()

    private val adapter: CurrenciesAdapter by lazy {
        CurrenciesAdapter(object : CurrenciesAdapter.ICurrenciesAdapter {
            override fun onClickCurrency(code: String?) {
                listener.onClickCurrency(code)
                dismiss()
            }
        })
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_currency, container)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        rcvCurrencies?.adapter = adapter

        initObservers()

        viewModel.loadCurrencies()
    }

    override fun onStart() {
        dialog?.setTitle(getString(R.string.select_a_currency))
        dialog?.window?.setLayout(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        )
        super.onStart()
    }

    private fun initObservers() {

        tilFilterInput.editText?.doOnTextChanged { text, _, _, _ ->
            viewModel.searchCurrencies(text.toString().trim())
        }

        tilFilterInput.setEndIconOnClickListener {
            tilFilterInput.editText?.setText("")
        }

        viewModel.error.observe(this, {
            hideList()
        })

        viewModel.list.observe(this, {
            showList()
            adapter.list = it
        })

        viewModel.listFiltered.observe(this, {
            showList()
            adapter.list = it
        })
    }

    private fun hideList() {
        prbLoading?.isVisible = false
        rcvCurrencies?.isVisible = false
        txvNoCurrencyToShow?.isVisible = true
    }

    private fun showList() {
        prbLoading?.isVisible = false
        rcvCurrencies?.isVisible = true
        txvNoCurrencyToShow?.isVisible = false
    }

    interface ICurrenciesFragmentDialog {
        fun onClickCurrency(code: String?)
    }
}