from time import now
from mopro.utils import (
    format_float,
    format_seconds,
    int_to_padded_string,
    mult_string,
)

@value
struct BarPrinter:
    var total:Int
    var prefix: String
    var postfix: String
    var bar_size: Int
    var bar_fill: String
    var bar_empty: String
    var total_size:Int

    var start:Int

    fn __init__(inout self,total:Int,prefix:String,postfix:String,
    bar_size:Int,bar_fill:String,bar_empty:String):
        self.total = total
        self.prefix = prefix
        self.postfix = postfix
        self.bar_size = bar_size
        self.bar_fill = bar_fill
        self.bar_empty = bar_empty 
        self.total_size = len(str(total))

        self.start = 0

    fn print(inout self,step:Int):
        if step == 0:
            self.start = now()
        var bar: String = "|"
        for j in range(self.bar_size):
            if j < int((step * self.bar_size) / self.total):
                bar += self.bar_fill
            else:
                bar += self.bar_empty
        
        var prefix_space = " " if len(self.prefix) > 0 else ""
        
        bar += "|"
        var percent_str = int_to_padded_string(100 * step // self.total, 3) + "%"
        var step_str = int_to_padded_string(step, self.total_size)

        var elapsed_time = (now() - self.start) / 1e9
        var elapsed_str = format_seconds(int(elapsed_time))

        var rate = (step + 1) / elapsed_time if elapsed_time > 0 and step> 0 else 0
        var rate_str = format_float(rate) + " it/s"

        var remaining_time = (self.total - step) / rate if rate > 0 else 0
        var remaining_str = format_seconds(int(remaining_time))

        var postfix_str = "" if len(self.postfix) == 0  else ", " + self.postfix 

        var info_str = "[" + elapsed_str + "<" + remaining_str + ", " + rate_str + postfix_str + "]"

        print(
            "\r"
            + self.prefix
            + prefix_space
            + percent_str
            + " "
            + bar
            + " "
            + step_str
            + "/"
            + self.total
            + " "
            + info_str,
            
            end="   ",
            flush=True,
        )




    fn __str__(self)->String:
       var res:String = ""
       res += "prefix: " + self.prefix + "\n"
       res += "postfix: " + self.postfix + "\n"
       res += "bar_size: " + str(self.bar_size) + "\n"
       res += "bar_fill: " + self.bar_fill + "\n"
       res += "bar_empty: " + self.bar_empty 

       return res
