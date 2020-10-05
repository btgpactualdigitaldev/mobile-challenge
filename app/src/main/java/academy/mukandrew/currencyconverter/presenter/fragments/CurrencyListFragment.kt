package academy.mukandrew.currencyconverter.presenter.fragments

import academy.mukandrew.currencyconverter.R
import academy.mukandrew.currencyconverter.commons.extensions.showBackButton
import academy.mukandrew.currencyconverter.presenter.models.CurrencyMethodType
import academy.mukandrew.currencyconverter.presenter.models.CurrencyMethodType.FROM
import academy.mukandrew.currencyconverter.presenter.models.CurrencyMethodType.TO
import academy.mukandrew.currencyconverter.presenter.models.CurrencyUI
import academy.mukandrew.currencyconverter.presenter.recycler.CurrencyAdapter
import academy.mukandrew.currencyconverter.presenter.recycler.CurrencyItemDecorator
import academy.mukandrew.currencyconverter.presenter.viewmodel.CurrencyViewModel
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.DividerItemDecoration
import kotlinx.android.synthetic.main.fragment_currency_list.*

class CurrencyListFragment(private val methodType: CurrencyMethodType) : Fragment() {

    private val viewModel: CurrencyViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_currency_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        showBackButton(true)
        initViews()
        initData()
    }

    private fun initViews() {
        currencyList.adapter = CurrencyAdapter(::onItemAdapterClicked)
        currencyList.addItemDecoration(
            CurrencyItemDecorator(
                requireContext(),
                DividerItemDecoration.VERTICAL
            )
        )
    }

    private fun initData() {
        val list = viewModel.getCurrencyList()
        (currencyList.adapter as? CurrencyAdapter)?.submitList(list)
    }

    private fun onItemAdapterClicked(currencyUI: CurrencyUI) {
        when (methodType) {
            FROM -> viewModel.fromCurrency = currencyUI
            TO -> viewModel.toCurrency = currencyUI
        }
        requireActivity().onBackPressed()
    }

}