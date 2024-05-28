from time.time import sleep, now
from mopro.utils import (
    format_float,
    format_seconds,
    int_to_padded_string,
    mult_string,
)

fn progress_bar[callback: fn(Int,/) capturing -> None](
    total: Int,
    prefix: String = "",
    postfix: String = "",
    bar_size: Int = 50,
    bar_fill: String = "█",
    bar_empty: String = "░",
):
    fn _f(i:Int,/) capturing -> Bool:
        callback(i)
        return True
    
    progress_bar[_f](
        total,
        prefix,
        postfix,
        bar_size,
        bar_fill,
        bar_empty
    )


fn progress_bar[callback: fn(Int,/) capturing -> Bool](
    total: Int,
    prefix: String = "",
    postfix: String = "",
    bar_size: Int = 50,
    bar_fill: String = "█",
    bar_empty: String = "░",
):
    """
    A simple progress bar.

    Parameters:
        callback: Function to call in each iteration.
        
    Args:
        total: The number of iterations.
        prefix: Prefix string to display before the progress bar. (default: '')
        postfix: Postfix string to display after the progress bar. (default: '')
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

        var rate = (step + 1) / elapsed_time if elapsed_time > 0 and step> 0 else 0
        var rate_str = format_float(rate) + " it/s"

        var remaining_time = (total - step) / rate if rate > 0 else 0
        var remaining_str = format_seconds(int(remaining_time))

        var postfix_str = "" if len(postfix) == 0  else ", " + postfix 

        var info_str = "[" + elapsed_str + "<" + remaining_str + ", " + rate_str + postfix_str + "]"

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
            + info_str,
            
            end="   ",
            flush=True,
        )

    show(0)
    for step in range(total):
        if not callback(step):
            break
        show(step + 1)
