from time.time import sleep, now
from mopro.utils import (
    format_float,
    format_seconds,
    int_to_padded_string,
    mult_string,
)

fn vectorize_bar[callback: fn[Int](Int,/) capturing -> Bool,nelts:Int](
    total: Int,
    prefix: String = "",
    bar_size: Int = 50,
    bar_fill: String = "█",
    bar_empty: String = "░",
):
    """
    A simple progress bar.

    Parameters:
        callback: Function to call in each iteration.
        nelts: Numder of elements for the vectorized operations.
        
    Args:
        total: The number of iterations.
        prefix: Prefix string to display before the progress bar. (default: '')
        bar_size: The size of the progress bar. (default: 50)
        bar_fill: Bar fill character.  (default: "█")
        bar_empty: Bar empty character. (default: "░")
    """

    var total_size = len(str(total))
    var space = " " if len(prefix) > 0 else ""

    var start = now()

    @parameter
    fn show(step: Int):
        var bar: String = "|"
        for j in range(bar_size):
            if j < int((step * bar_size) / total):
                bar += bar_fill
            else:
                bar += bar_empty
        bar += "|"
        var percent_str = int_to_padded_string(100 * step // total, 3) + "%"
        var step_str = int_to_padded_string(step, total_size)

        var elapsed_time = (now() - start) / 1e9
        var elapsed_str = format_seconds(int(elapsed_time))

        var rate = (step + 1) / elapsed_time if elapsed_time > 0 else 0
        var rate_str = format_float(rate) + " it/s"

        var remaining_time = (total - step) / rate if rate > 0 else 0
        var remaining_str = format_seconds(int(remaining_time))

        var time_str = "[" + elapsed_str + "<" + remaining_str + ", " + rate_str + "]"

        print(
            "\r"
            + prefix
            + space
            + percent_str
            + " "
            + bar
            + " "
            + step_str
            + "/"
            + total
            + " "
            + time_str,
            end="   ",
            flush=True,
        )

    show(0)
    for step in range(total//nelts):
        if not callback[nelts](step*nelts):
            break
        show(step*nelts + 1)
    
    for i in range(total%nelts):
        var step = (total//nelts)*nelts + i
        if not callback[1](step):
            break
        show(step + 1)


