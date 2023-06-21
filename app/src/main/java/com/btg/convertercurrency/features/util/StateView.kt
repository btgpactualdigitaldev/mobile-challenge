package com.btg.convertercurrency.features.util


import android.animation.ObjectAnimator
import android.content.Context
import android.content.res.TypedArray
import android.graphics.Point
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.ContextCompat.getColor
import androidx.core.content.ContextCompat.getDrawable
import androidx.databinding.BindingAdapter
import com.btg.convertercurrency.R
import com.btg.convertercurrency.R.*
import kotlinx.android.synthetic.main.custom_state_view.view.*


class StateView : ConstraintLayout {

    private enum class AnimDeslocament(val porpertName: String) {
        TRANSLATION_Y("translationY")
    }

    private val timeViewDeslocament = 400L

    private var attributes: TypedArray

    var retryFun: () -> Unit = {}
    var backFun: () -> Unit = {}

    private var imageError = 0
    private var loadingRes = 0
    private lateinit var titleText: String
    private lateinit var subTitleText: String
    private lateinit var buttonText: String
    private var excludedViews = 0
    private var animBackButton = false
    private var visibilityBackButton = View.VISIBLE


    private val screamSize by lazy {
        val point = Point()
        (context.getSystemService(Context.WINDOW_SERVICE) as WindowManager).defaultDisplay.getSize(
            point
        )
        point
    }

    constructor(context: Context) : this(context, null)
    constructor(context: Context, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    ) {
        LayoutInflater.from(context).inflate(layout.custom_state_view, this)

        attributes = context.theme.obtainStyledAttributes(
            attrs,
            styleable.custom_state_view,
            0, 0
        )
        init()
    }

    private fun init() {

        stateViewButton.setOnClickListener {
            showStateLoading()
            retryFun.invoke()
        }

        with(attributes) {

//            loadingRes =
//                getResourceId(styleable.custom_state_view_image_error, raw.truck_login)

            imageError =
                getResourceId(
                    styleable.custom_state_view_image_error,
                    drawable.ic_server_error
                )

            titleText = getString(styleable.custom_state_view_title_text)
                ?: context.getString(string.state_error_title)

            subTitleText = getString(styleable.custom_state_view_sub_title_text)
                ?: context.getString(string.state_error_subtitle)

            buttonText = getString(styleable.custom_state_view_button_text)
                ?: context.getString(string.state_button_text)

            excludedViews = getInt(styleable.custom_state_view_exclude_views, 0)


        }

        mountView()
    }

    private fun mountView() {
        setTitleText(titleText)
        setButtonText(buttonText)
        setErrorImage(imageError)
//        setEmptyStateImage(imageEmptyState)
        setSubTitleText(subTitleText)
    }

    fun showStateByStatusCodeWithAnin(
        statusCode: Int,
        animBack: Boolean = false,
        visibilitBack: Int = View.VISIBLE
    ) {

        //Remove o load
        stateViewLoading.visibility = GONE

        visibilityBackButton = visibilitBack
        mountStateByStatusCode(statusCode)

        visibility = View.VISIBLE
        animBackButton = animBack

        svBackground.setBackgroundColor(getColor( context , color.background_view_state))

        if (animBack) {
            y = screamSize.y.toFloat()
            aninView(AnimDeslocament.TRANSLATION_Y, y, 0f)
        }
    }

    private fun aninView(
        animViewDeslocament: AnimDeslocament,
        startPosition: Float,
        endPosition: Float,
        timeDeslocament: Long = timeViewDeslocament
    ) {
        ObjectAnimator.ofFloat(this, animViewDeslocament.porpertName, startPosition, endPosition)
            .apply {
                duration = timeDeslocament
                start()
            }
    }

    private fun mountStateByStatusCode(statusCode: Int) {
        when (statusCode) {
            //User has reached or exceeded his subscription plan's monthly API request allowance.
            104-> mountApiError()
            //    The user's account is not active. User will be prompted to get in touch with Customer Support.
            102	-> mountApiError()

            404 ->mountUpdateError()

            303 ->mountRefreshQuotesError()

            500 -> mountDefaultError()
        }
    }

    private fun mountDefaultError() {

        stateViewTitle.apply {
            text = context.getString(string.state_error_title)
            visibility = View.VISIBLE
        }

        stateViewSubTitle.apply {
            text = context.getString(string.state_error_subtitle)
            visibility = View.VISIBLE
        }

        stateViewImage.apply {
            setImageDrawable(
                getDrawable(context, R.drawable.ic_server_error)
            )
            visibility = View.VISIBLE
        }

        stateViewButton.visibility = View.GONE

        with(ibBack) {
            visibility = visibilityBackButton
            ibBack.setOnClickListener {
                if (animBackButton)
                    aninView(AnimDeslocament.TRANSLATION_Y, 0f, screamSize.y.toFloat())
                backFun.invoke()
            }
        }
    }

    private fun mountApiError() {

        stateViewTitle.apply {
            text = context.getString(string.state_error_api_title)
            visibility = View.VISIBLE
        }

        stateViewSubTitle.apply {
            text = context.getString(string.state_error_api_subtitle)
            visibility = View.VISIBLE
        }

        stateViewImage.apply {
            setImageDrawable(
                getDrawable(context, R.drawable.ic_server_error)
            )
            visibility = View.VISIBLE
        }

        stateViewButton.visibility = View.GONE

        with(ibBack) {
            visibility = visibilityBackButton
            ibBack.setOnClickListener {
                if (animBackButton)
                    aninView(AnimDeslocament.TRANSLATION_Y, 0f, screamSize.y.toFloat())
                backFun.invoke()
            }
        }
    }

    private fun mountUpdateError() {

        stateViewTitle.apply {
            text = context.getString(string.state_error_update_title)
            visibility = View.VISIBLE
        }

        stateViewSubTitle.apply {
            text = context.getString(string.state_error_update_subtitle)
            visibility = View.VISIBLE
        }

        stateViewImage.apply {
            setImageDrawable(
                getDrawable(context, R.drawable.ic_server_error)
            )
            visibility = View.VISIBLE
        }

        stateViewButton.visibility = View.GONE

        with(ibBack) {
            visibility = visibilityBackButton
            ibBack.setOnClickListener {
                if (animBackButton)
                    aninView(AnimDeslocament.TRANSLATION_Y, 0f, screamSize.y.toFloat())
                backFun.invoke()
            }
        }
    }

    private fun mountRefreshQuotesError() {

        stateViewTitle.apply {
            text = context.getString(string.state_error_refresh_quotes_title)
            visibility = View.VISIBLE
        }

        stateViewSubTitle.apply {
            text = context.getString(string.state_error_refresh_quotes_subtitle)
            visibility = View.VISIBLE
        }

        stateViewImage.apply {
            setImageDrawable(
                getDrawable(context, R.drawable.ic_server_error)
            )
            visibility = View.VISIBLE
        }

        stateViewButton.visibility = View.GONE

        with(ibBack) {
            visibility = visibilityBackButton
            ibBack.setOnClickListener {
                if (animBackButton)
                    aninView(AnimDeslocament.TRANSLATION_Y, 0f, screamSize.y.toFloat())
                backFun.invoke()
            }
        }
    }

    fun showStateLoading() {
        visibility = VISIBLE

        y = screamSize.y.toFloat()
        aninView(AnimDeslocament.TRANSLATION_Y, y, 0f, 0)

        stateViewTitle.visibility = GONE
        stateViewSubTitle.visibility = GONE
        stateViewButton.visibility = GONE
        stateViewImage.visibility = GONE
        ibBack.visibility = View.GONE
        svBackground.setBackgroundColor(getColor( context , color.background_view_state_load))


        stateViewLoading.visibility = VISIBLE
        stateViewLoading.playAnimation()
    }

    fun hideStateLoading() {
        aninView(AnimDeslocament.TRANSLATION_Y, 0f, screamSize.y.toFloat())
    }

    object SetViewStateBinding {
        @JvmStatic
        @BindingAdapter(value = ["app:setLoadViewState"])
        fun setViewStateLoad(stateView: StateView, setLoadViewState: Event<Boolean>) {
            if(setLoadViewState.hasBeenHandled) {
                if (setLoadViewState.peekContent()) {
                    stateView.showStateLoading()
                }else {
                    stateView.hideStateLoading()
                }
                setLoadViewState.hasBeenHandled = false
            }
        }

        @JvmStatic
        @BindingAdapter(value = ["app:setViewStateStatusCode", "app:setVisibilityBackBt"], requireAll = false)
        fun setViewStateStatusCode(stateView: StateView, statusCode: Event<Int>, setActionBackBt:Boolean ) {
            if(statusCode.hasBeenHandled) {
                stateView.showStateByStatusCodeWithAnin(statusCode.peekContent(),true)
                statusCode.hasBeenHandled = false
            }
        }
    }

    fun setButtonText(buttonText: String) {
        stateViewButton?.text = buttonText
    }

    fun setSubTitleText(subtitle: String) {
        stateViewSubTitle?.text = subtitle
    }

    fun setTitleText(title: String) {
        stateViewTitle.text = title
    }

    fun setErrorImage(resourceId: Int) {
        stateViewImage.setImageDrawable(getDrawable(context, resourceId))
    }

}