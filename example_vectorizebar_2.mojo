from time import sleep
from mopro import progress_bar, vectorize_bar
from sys.info import simdwidthof

alias NUM = 100000 * 16 + 15
alias type = DType.float64
alias simd_width = 4 * simdwidthof[type]()


fn main():
    var vec = UnsafePointer[Scalar[type]].alloc(NUM)
    for i in range(NUM):
        vec[i] = i / (i * 1.7 + 4)

    var sum: Scalar[type] = 0

    @parameter
    fn one_step(i: Int):
        sum += vec[i]

    print("Progress Bar:")
    progress_bar[one_step](total=NUM, bar_size=20)
    print("\nSum: ", sum)

    sum = 0

    @parameter
    fn vectorized_step[width: Int](iv: Int):
        sum += vec.load[width=width](iv).reduce_add()

    print("\nVectorize Bar:")
    vectorize_bar[vectorized_step, simd_width](total=NUM, bar_size=20)
    print("\nSum: ", sum)

    vec.free()
