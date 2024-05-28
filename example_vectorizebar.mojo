from time import sleep
from mopro import vectorize_bar

alias simd_width=16

fn main():
   
    @parameter
    fn one_step[width:Int](iv: Int) -> Bool:
        sleep(0.1 * width)
        return True
       
    vectorize_bar[one_step,simd_width](
        total=144+15
    )