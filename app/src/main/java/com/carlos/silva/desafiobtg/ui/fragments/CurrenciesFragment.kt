package com.carlos.silva.desafiobtg.ui.fragments

import android.os.Bundle
import android.view.*
import androidx.appcompat.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import androidx.navigation.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.transition.TransitionInflater
import com.carlos.silva.desafiobtg.MainActivity
import com.carlos.silva.desafiobtg.R
import com.carlos.silva.desafiobtg.interfaces.CurrencieClickListener
import com.carlos.silva.desafiobtg.ui.MainViewModel
import com.carlos.silva.desafiobtg.ui.adapters.CurrencieAdapter
import kotlinx.android.synthetic.main.fragment_currencies.*

class CurrenciesFragment : Fragment(), SearchView.OnQueryTextListener {

    private val mMainViewModel: MainViewModel by activityViewModels()
    private lateinit var mAdapter: CurrencieAdapter
    private val mObserverList = Observer<MutableList<Pair<String, String>>> {
        with(recyclerview) {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(requireContext())
            adapter = CurrencieAdapter(it).apply {
                mAdapter = this
                setOnClickListener(object : CurrencieClickListener {
                    override fun onClick(pair: Pair<String, String>, view: View?) {
                        arguments?.let { bundle ->
                            if (bundle.getInt("id") == ContentFragment.ORIGIN_ID) {
                                mMainViewModel.selectdOriginLiveData.value = pair
                            } else {
                                mMainViewModel.selectedDestinyLiveData.value = pair
                            }

                            view?.findNavController()?.popBackStack()
                        }
                    }
                })
            }
        }
    }

    private val mObserverConnection = Observer<Boolean> { connection ->
        if (connection) {
            mMainViewModel.getCurrencies(requireContext())
            mMainViewModel.getQuotes(requireContext())
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val explode = TransitionInflater.from(context)
            .inflateTransition(android.R.transition.explode)

        enterTransition = explode
        exitTransition = explode


        setHasOptionsMenu(true)

    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(
            R.layout.fragment_currencies,
            container,
            false
        )
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        (activity as MainActivity?)?.let {

            arguments?.let { bundle ->
                if (bundle.getInt("id") == ContentFragment.ORIGIN_ID) {
                    toolbar.title = getString(R.string.start_value)
                } else {
                    toolbar.title = getString(R.string.end_value)
                }
            }

            it.setSupportActionBar(toolbar)
            it.supportActionBar?.setDisplayHomeAsUpEnabled(true)
        }

        mMainViewModel.isConnectedLiveData.observe(viewLifecycleOwner, mObserverConnection)
        mMainViewModel.currenciesLiveData.observe(viewLifecycleOwner, mObserverList)

        mMainViewModel.getCurrencies(requireActivity())
        mMainViewModel.getQuotes(requireActivity())
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.search_menu, menu)

        menu.findItem(R.id.menu_search)?.let {
            val searchView = it.actionView as SearchView
            searchView.maxWidth = Int.MAX_VALUE
            searchView.setOnQueryTextListener(this)
        }

        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onDetach() {
        mMainViewModel.currenciesLiveData.removeObserver(mObserverList)
        mMainViewModel.isConnectedLiveData.removeObserver(mObserverConnection)
        super.onDetach()
    }

    override fun onQueryTextSubmit(query: String?): Boolean {
        return true
    }

    override fun onQueryTextChange(newText: String?): Boolean {
        newText?.let {
            mAdapter.filter(it)
        }
        return false
    }

}