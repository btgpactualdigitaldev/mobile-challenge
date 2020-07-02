package com.gui.antonio.testebtg.view

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.gui.antonio.testebtg.R
import com.gui.antonio.testebtg.databinding.FragmentCoinsBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class CoinsFragment : Fragment() {

    lateinit var binding: FragmentCoinsBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_coins, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val strings = ArrayList<String>()
        val data = MutableLiveData<List<String>>()

        CoroutineScope(Dispatchers.IO).launch {
            (activity as MainActivity).appDatabase.appDao().getCurrencies()
                .forEach {
                    Log.v("TAG", "${it.symbol} - ${it.name}")
                    strings.add("${it.symbol} - ${it.name}")
                }
            data.postValue(strings)
        }

        data.observe(this, Observer {
            binding.lv.adapter = ArrayAdapter(
                context!!,
                android.R.layout.activity_list_item,
                android.R.id.text1,
                strings
            )
        })
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment CoinsFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            CoinsFragment().apply {
//                arguments = Bundle().apply {
//                    putString(ARG_PARAM1, param1)
//                    putString(ARG_PARAM2, param2)
//                }
            }
    }
}