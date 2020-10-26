package com.helano.shared.view

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import android.widget.LinearLayout
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import com.helano.shared.R
import com.helano.shared.util.network.ConnectivityStateHolder
import com.helano.shared.util.network.NetworkEvents

class ErrorMessageView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) :
    LinearLayout(context, attrs, defStyleAttr) {

    private lateinit var viewContainer: ViewGroup

    constructor(container: ViewGroup, owner: LifecycleOwner) : this(container.context) {
        viewContainer = container
        NetworkEvents.observe(owner, Observer {
            checkConnectionState(true)
        })
        checkConnectionState()
    }

    init {
        LayoutInflater.from(context).inflate(R.layout.view_error_message, this, true)
        layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT)
    }

    private fun show(animate: Boolean = false) {
        viewContainer.addView(this)
        visibility = View.VISIBLE
        if (animate) {
            startAnimation(AnimationUtils.loadAnimation(context, R.anim.slide_message_down))
        }
    }

    private fun hide(animate: Boolean = false) {
        if (animate) {
            startAnimation(AnimationUtils.loadAnimation(context, R.anim.slide_message_up))
        }
        visibility = View.GONE
        viewContainer.removeView(this)
    }

    private fun checkConnectionState(animate: Boolean = false) {
        if (ConnectivityStateHolder.isConnected) {
            hide(animate)
        } else {
            show(animate)
        }
    }
}