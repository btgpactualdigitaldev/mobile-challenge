package academy.mukandrew.currencyconverter.presenter.recycler

import academy.mukandrew.currencyconverter.R
import android.content.Context
import android.graphics.Rect
import android.view.View
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.RecyclerView

class CurrencyItemDecorator(
    context: Context,
    orientation: Int
) : DividerItemDecoration(context, orientation) {

    override fun getItemOffsets(
        outRect: Rect,
        view: View,
        parent: RecyclerView,
        state: RecyclerView.State
    ) {
        super.getItemOffsets(outRect, view, parent, state)

        val betweenSize = view.resources.getDimensionPixelSize(R.dimen.currency_list_view_holder_between)

        val top = if (parent.getChildAdapterPosition(view) == 0) {
            view.resources.getDimensionPixelSize(R.dimen.currency_list_first_view_holder_top)
        } else {
            betweenSize
        }

        val bottom = if (parent.getChildAdapterPosition(view) == (state.itemCount - 1)) {
            view.resources.getDimensionPixelSize(R.dimen.currency_list_last_view_holder_bottom)
        } else {
            betweenSize
        }

        outRect.set(
            view.resources.getDimensionPixelSize(R.dimen.currency_list_view_holder_st_end_margin),
            top,
            view.resources.getDimensionPixelSize(R.dimen.currency_list_view_holder_st_end_margin),
            bottom
        )
    }
}