package br.com.btg.test.feature.currency.ui.fragments

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.btg.test.base.BaseFragment
import br.com.btg.test.data.Status
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import br.com.btg.test.feature.currency.ui.adapter.CurrenciesListAdapter
import br.com.btg.test.feature.currency.viewmodel.CurrenciesListViewModel
import br.com.btg.test.util.argument
import br.com.btg.test.R
import kotlinx.android.synthetic.main.fragment_currencies_list.*
import org.koin.android.viewmodel.ext.android.viewModel

class CurrenciesListFragment : BaseFragment() {

    companion object {
        const val REQUEST_CODE_ARGUMENT = "REQUEST_CODE_ARGUMENT"
        const val CURRENCY_EXTRA_RESULT = "CURRENCY_EXTRA_RESULT"

        fun newInstance() =
            CurrenciesListFragment()
    }

    private val viewModel by viewModel<CurrenciesListViewModel>()
    private val requestCode by argument<Int>(REQUEST_CODE_ARGUMENT)

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return inflater.inflate(R.layout.fragment_currencies_list, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        configureObservers()
        configureCurrenciesList()

        viewModel.retrieveCurrencies()
    }

    private fun configureObservers() {
        viewModel.listResult.observe(requireActivity(), Observer { data ->
            when (data.status) {
                Status.SUCCESS -> populateList(data.data)
                Status.ERROR -> showError(data.message, snack_bar)
            }
        })
    }

    private fun returnResult(currencyEntity: CurrencyEntity) {
        var activity = requireActivity()
        activity.setResult(1, Intent().apply {
            putExtra(CURRENCY_EXTRA_RESULT, currencyEntity)
        })
        activity.finish()
    }


    private fun configureCurrenciesList() {
        rvCurrencies.apply {
            layoutManager = LinearLayoutManager(requireContext(), RecyclerView.VERTICAL, false)
            adapter =
                CurrenciesListAdapter(
                    mutableListOf(),
                    this@CurrenciesListFragment::returnResult
                )
        }
    }


    private fun populateList(list: List<CurrencyEntity>?) {
        list?.let {
            (rvCurrencies.adapter as CurrenciesListAdapter).apply {
                this.list.addAll(list)
                this.notifyDataSetChanged()
            }
        }
    }

}