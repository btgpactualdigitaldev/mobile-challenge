package com.example.coinconverter.presentation.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.coinconverter.R
import com.example.coinconverter.databinding.FragmentListBinding
import com.example.coinconverter.presentation.adapter.ListAdapter
import com.example.coinconverter.presentation.viewmodel.ListViewModel

class ListFragment : Fragment() {

    private lateinit var listViewModel: ListViewModel
    private lateinit var dataBinding: FragmentListBinding

    private val listAdapter by lazy {
        ListAdapter()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        listViewModel = ViewModelProvider(this).get(ListViewModel::class.java)
        listViewModel.loadCurriencesList()

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        dataBinding = DataBindingUtil.inflate(inflater,R.layout.fragment_list, container, false)
        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        dataBinding.recyclerList.layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
        dataBinding.recyclerList.adapter = listAdapter
        listViewModel.currencies.observe(viewLifecycleOwner, Observer {
            listAdapter.setData(it)
        })
    }

    companion object {

        @JvmStatic
        fun newInstance() = ListFragment()
    }
}