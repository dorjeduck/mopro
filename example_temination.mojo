from time import sleep
from mopro import progress_bar

fn main():

    var stop = 197
    
    @parameter
    fn one_step(i: Int) -> Bool:
        sleep(0.01)
        return i<stop

    progress_bar[one_step](
        total=256
    )