from time import sleep
from mopro import progress_bar,vectorize_bar

alias NUM = 100000*16+15
alias dtype = DType.float64
alias simd_width=4*simdwidthof[dtype]()

fn main():

    var vec = DTypePointer[dtype].alloc(NUM)
    for i in range(NUM):
        vec[i] = i/(i*1.7+4)
   
    var sum:Scalar[dtype] = 0
    @parameter
    fn one_step(i: Int):
        sum+= vec[i]
    print("Progress Bar:")
    progress_bar[one_step](total=NUM,bar_size=20)
    print("\nSum: ", sum)

    sum = 0
    @parameter
    fn vectorized_step[width:Int](iv: Int):
        sum+= vec.load[width=width](iv).reduce_add()

    print("\nVectorized Bar:")
    vectorize_bar[vectorized_step,simd_width](total=NUM,bar_size=20)
    print("\nSum: ", sum)