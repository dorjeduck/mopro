from time import sleep
from mopro import vectorize_bar

alias simd_width=16

fn main():
   
    @parameter
    fn vectorized_step[width:Int](iv: Int):

        
        sleep(0.1 * width)
       
    vectorize_bar[vectorized_step,simd_width](
        total=9*16+15
    )