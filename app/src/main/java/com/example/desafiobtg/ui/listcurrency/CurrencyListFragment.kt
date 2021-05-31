package com.example.desafiobtg.ui.listcurrency

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedDispatcher
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.desafiobtg.R
import com.example.desafiobtg.databinding.FragmentCurrencyListBinding
import com.example.desafiobtg.ui.convert.ConvertFragment
import com.example.desafiobtg.ui.convert.ConvertViewModel
import com.example.desafiobtg.ui.mainactivity.ConvertActivity.Companion.fm
import org.koin.androidx.viewmodel.ext.android.sharedViewModel

class CurrencyListFragment : Fragment() {

    private var currencyListBinding: FragmentCurrencyListBinding? = null
    private val currentListViewModel: ConvertViewModel by sharedViewModel()
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        currencyListBinding = FragmentCurrencyListBinding.inflate(inflater, container, false)
        return currencyListBinding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        currentListViewModel.getList()
        observerList()

        requireActivity().onBackPressedDispatcher.addCallback(viewLifecycleOwner) {
            returnToMainFragment()
        }
    }

    private fun returnToMainFragment() {

        fm.beginTransaction().replace(R.id.fragment_container, ConvertFragment.newInstance())
                .commit()
    }

    private fun observerList() {
        currentListViewModel.onResultListOfCurrency.observe(this.viewLifecycleOwner, {
            val values = it.currencyList?.values
            val codes = it.currencyList?.keys
            val adapter = CurrencyListAdapter(values, codes)
            setupRecyclerView(adapter)
        })
    }

    private fun setupRecyclerView(adapterCurerncy: CurrencyListAdapter) {
        currencyListBinding?.recyclerView?.apply {
            layoutManager = LinearLayoutManager(this.context)
            adapter = adapterCurerncy
        }
    }

    companion object {
        fun newInstance(): Fragment {
            return CurrencyListFragment()
        }
    }

    private fun OnBackPressedDispatcher.addCallback(viewLifecycleOwner: LifecycleOwner, function: () -> Unit) {

    }
}