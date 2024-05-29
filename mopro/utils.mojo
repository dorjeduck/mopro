fn format_float(f: Float32, digits: Int = 2) -> String:
    
    if f == 0:
        return "0"
    var ff = str(int(f * 10**digits))
    var l = len(ff)
    return ff[: l - digits] + "." + ff[l - digits :]

fn mult_string(s:String,mul:Int)->String:
    var res: String = s
    for _ in range(mul-1):
        res += str(s)
    return res 

fn int_to_padded_string(n: Int, width: Int, pad_str: String = " ") -> String:
    var res: String = ""
    for _ in range(width - len(str(n))):
        res += pad_str
    return res + str(n)


fn format_seconds(seconds: Int) -> String:
    var hours = seconds // 3600
    var minutes = (seconds % 3600) // 60
    var secs = seconds % 60

    var minutes_str = int_to_padded_string(minutes, 2, "0")
    var seconds_str = int_to_padded_string(secs, 2, "0")

    if hours > 0:
        return str(hours) + ":" + minutes_str + ":" + seconds_str

    return minutes_str + ":" + seconds_str


# ANSI Operations
alias csi = chr(27)  + "["  # Control Sequence Introducer
alias delete_line_seq = "%dM"

fn replace(input_string: String, old: String, new: String, count: Int = -1) -> String:
    if count == 0:
        return input_string

    var output: String = ""
    var start = 0
    var split_count = 0

    for end in range(len(input_string) - len(old) + 1):
        if input_string[end : end + len(old)] == old:
            output += input_string[start:end] + new
            start = end + len(old)
            split_count += 1

            if count >= 0 and split_count >= count and count >= 0:
                break

    output += input_string[start:]
    return output

fn sprintf(text: String, *ints: UInt16) -> String:
    var output: String = text
    for i in range(len(ints)):
        output = replace(output, "%d", String(ints[i]), 1)

    return output

fn delete_line():
    print(sprintf(csi + delete_line_seq, 1), end="")