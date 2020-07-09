package com.carlos.silva.desafiobtg.ui.fragments

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AlertDialog
import androidx.constraintlayout.motion.widget.MotionLayout
import androidx.core.app.ActivityOptionsCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import androidx.navigation.ActivityNavigator
import androidx.navigation.findNavController
import androidx.transition.TransitionInflater
import com.carlos.silva.desafiobtg.R
import com.carlos.silva.desafiobtg.ui.MainViewModel
import kotlinx.android.synthetic.main.fragment_content.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class ContentFragment : Fragment() {

    private var isToogle = false
    private var isConnected = false
    private val mMainViewModel: MainViewModel by activityViewModels()
    private val mHandler = Handler()

    private val mConnectivityManagerCallback = object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            super.onAvailable(network)
            mHandler.post {
                mMainViewModel.isConnectedLiveData.value = true
            }
        }

        override fun onUnavailable() {
            super.onUnavailable()
            mHandler.post {
                mMainViewModel.isConnectedLiveData.value = false
            }
        }

        override fun onLost(network: Network) {
            super.onLost(network)
            mHandler.post {
                mMainViewModel.isConnectedLiveData.value = false
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val explode = TransitionInflater.from(context)
            .inflateTransition(android.R.transition.explode)

        enterTransition = explode
        exitTransition = explode

        val connectivityManager =
            context?.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        connectivityManager.registerDefaultNetworkCallback(mConnectivityManagerCallback)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(
            R.layout.fragment_content,
            container,
            false
        )
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initViews()

        mMainViewModel.selectdOriginLiveData.observe(viewLifecycleOwner, Observer {
            button_start_value.text = "${it.first} | ${it.second}"
        })

        mMainViewModel.selectedDestinyLiveData.observe(viewLifecycleOwner, Observer {
            button_end_value.text = "${it.first} | ${it.second}"
        })

        mMainViewModel.formattedResultInfoLiveData.observe(viewLifecycleOwner, Observer {
            input_result_info.text = it
        })

        mMainViewModel.formatResultLiveData.observe(viewLifecycleOwner, Observer {
            input_result.text = it
        })
    }

    private fun initViews() {

        motion_layout.setOnClickListener {
            resetFocus()
        }

        input_value.setOnEditorActionListener { v, actionId, event ->
            v.clearFocus()
            return@setOnEditorActionListener false
        }

        fab_result.setOnClickListener(this::actionButton)

        button_start_value.setOnClickListener {
            it.findNavController().navigate(
                R.id.currenciesFragment,
                Bundle().apply {
                    putInt("id", ORIGIN_ID)
                },
                null,
                ActivityNavigator.Extras.Builder()
                    .setActivityOptions(
                        ActivityOptionsCompat.makeSceneTransitionAnimation(
                            requireActivity()
                        )
                    )
                    .build()
            )
        }


        button_end_value.setOnClickListener {
            it.findNavController().navigate(
                R.id.currenciesFragment,
                Bundle().apply {
                    putInt("id", DESTINY_ID)
                },
                null,
                ActivityNavigator.Extras.Builder()
                    .setActivityOptions(
                        ActivityOptionsCompat.makeSceneTransitionAnimation(
                            requireActivity()
                        )
                    )
                    .build()
            )
        }
    }

    private fun actionButton(view: View) {

        if (!mMainViewModel.isValidate()) {
            showDialog()
            return
        }

        val input = input_value.text.toString()
        mMainViewModel.valueToFormat.value = if (input.isEmpty()) {
            0.toDouble()
        } else {
            input.toDouble()
        }

        mMainViewModel.getResult()

        if (isToogle) {
            motion_layout.transitionToStart()
        } else {
            motion_layout.transitionToEnd()
        }

        isToogle = !isToogle
        input_value.isEnabled = !isToogle
    }

    private fun showDialog() {
        AlertDialog.Builder(requireActivity())
            .setMessage(getString(R.string.message_alert))
            .setNeutralButton(getString(android.R.string.ok), null)
            .show()
    }

    private fun resetFocus() {
        input_value.clearFocus()
    }

    override fun onResume() {
        super.onResume()
        resetFocus()
    }

    companion object {
        const val ORIGIN_ID = 0
        const val DESTINY_ID = 1
    }
}