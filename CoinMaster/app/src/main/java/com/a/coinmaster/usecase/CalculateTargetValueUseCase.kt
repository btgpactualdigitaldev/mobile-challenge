package com.a.coinmaster.usecase

import io.reactivex.Single

class CalculateTargetValueUseCase : UseCase<CalculateTargetValueUseCase.Params, Single<Double>> {

    override fun execute(param: Params): Single<Double> =
        Single.just(
            param.sourceValue * param.sourceRate / param.targetRate
        )

    class Params(
        val sourceValue: Double,
        val targetRate: Double,
        val sourceRate: Double
    )
}