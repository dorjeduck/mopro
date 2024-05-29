from time import sleep
from mopro import progress_bar,BarSettings

fn main():
    var total = 256

    @parameter
    fn one_step(i: Int,inout bs:BarSettings):
        sleep(0.06)
        bs.postfix = str(total-i-1) + " steps to go" 
        
    progress_bar[one_step](
        total=total,
        bar_size=20
    )