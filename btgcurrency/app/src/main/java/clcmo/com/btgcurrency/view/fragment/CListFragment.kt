package clcmo.com.btgcurrency.view.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import clcmo.com.btgcurrency.R
import clcmo.com.btgcurrency.util.constants.Constants
import clcmo.com.btgcurrency.util.extension.backButtonView
import clcmo.com.btgcurrency.view.holder.CAdapter
import clcmo.com.btgcurrency.view.holder.CItemDecorator
import clcmo.com.btgcurrency.view.model.CurrencyUI
import clcmo.com.btgcurrency.viewmodel.CViewModel
import kotlinx.android.synthetic.main.c_list_fragment.*

class CListFragment(private val methodType: Constants.CMethodType) : Fragment() {

    private val cViewModel: CViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = inflater.inflate(R.layout.c_list_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        backButtonView(true)
        createAdapter()
        initData()
    }

    private fun createAdapter() {
        cList.layoutManager = LinearLayoutManager(context)
        cList.adapter = CAdapter(::onItemAdapterClicked)
        cList.addItemDecoration(
            CItemDecorator(requireContext(), DividerItemDecoration.VERTICAL)
        )
    }

    private fun initData() {
        val list = cViewModel.getListOfCurrencies()
        (cList.adapter as? CAdapter)?.submitList(list)
    }

    private fun onItemAdapterClicked(currencyUI: CurrencyUI) {
        when (methodType) {
            Constants.CMethodType.FROM -> cViewModel.fromCurrency = currencyUI
            Constants.CMethodType.TO -> cViewModel.toCurrency = currencyUI
        }
        requireActivity().onBackPressed()
    }
}