package clcmo.com.btgcurrency.view.holder

import android.content.Context
import android.graphics.Rect
import android.view.View
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.RecyclerView
import clcmo.com.btgcurrency.R

class CItemDecorator(context: Context, int: Int) : DividerItemDecoration(context, int) {
    override fun getItemOffsets(
        outRect: Rect,
        view: View,
        parent: RecyclerView,
        state: RecyclerView.State
    ) {
        super.getItemOffsets(outRect, view, parent, state)

        val betweenSize = view.resources.getDimensionPixelSize(R.dimen.c_list_vh_between_size)

        val top = when {
            parent.getChildAdapterPosition(view) == 0 ->
                view.resources.getDimensionPixelSize(R.dimen.c_list_vh_top_size_first)
            else -> betweenSize
        }

        val bottom = when {
            parent.getChildAdapterPosition(view) == (state.itemCount - 1) ->
                view.resources.getDimensionPixelSize(R.dimen.c_list_vh_bottom_size_last)
            else -> betweenSize
        }

        outRect.set(
            view.resources.getDimensionPixelSize(R.dimen.c_list_vh_ste_margin),
            top,
            view.resources.getDimensionPixelSize(R.dimen.c_list_vh_ste_margin),
            bottom
        )
    }
}