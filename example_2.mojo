from time import sleep
from mopro import progress_bar

fn main():
    @parameter
    fn one_step(i: Int):
        sleep(0.01)
        
    progress_bar[one_step](
        total=256,
        prefix="Epoch:", 
        bar_size=20,
        bar_fill = "🔥",
        bar_empty = "  "
    )