# progressbar.🔥

A lightweight and customizable progress bar for Mojo, meant for tracking the progress of long-running operations in loops.

## Usage

In its simplest use case, you specify the total number of iterations and provide a callback function as parameter that will be called for each iteration:

```python
from time import sleep
from mopro import progress_bar

fn main():

    @parameter
    fn one_step(i: Int) -> Bool:
        # your operations here
        sleep(0.01)
        return True

    progress_bar[one_step](
        total=256
    )
```

![example1.mojo](./imgs/example1.png)

### Terminating the loop

When the callback function returns `False`, the loop will terminate.

```python
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
```

### Customizations

Some basic customization options are availabe right now.

```python
from time import sleep
from mopro import progress_bar

fn main():

    @parameter
    fn one_step(i: Int) -> Bool:
        sleep(0.01)
        return True
        
    progress_bar[one_step](
        total=256,
        prefix="Epoch:", 
        bar_size=20,
        bar_fill = "🔥",
        bar_empty = "  "
    )
```

![example2.mojo](./imgs/example2.png)

## Vectorize Bar

The use of the Progress Bar is in a way quite similar to Mojo's [vectorize](https://docs.modular.com/mojo/stdlib/algorithm/functional/vectorize) function, making it straightforward to combine the two functionalities. To achieve this, we added the `vectorize_bar` function to our repository.

In the following example, the one_step method will be called nine times with a width parameter of 16, where the argument i increases by 16 with each call. This is followed by 15 additional calls with a width parameter of 1, with i increasing by 1 each time. We adjusted the sleep time based on the width value to better visualize the process.

```python
from mopro import vectorize_bar

alias simd_width=16

fn main():
    @parameter
    fn vectorized_step[width:Int](i: Int) -> Bool:
        sleep(0.1 * width)
        return True
       
    vectorize_bar[vectorized_step,simd_width](
        total=9*16+15
    )
```


## Remarks

- __Looking for More Advanced Features?__ Check out [Are We Done Yet](https://github.com/Ryul0rd/awdy) for a more advanced progress bar implementation in Mojo. Hillarious name - love it 🔥
- __Callback as Closure:__ For the sake of flexibility, we decided to define the callback function as closure. If this approach poses any limitations for you, please let us know.
- __Contribute and Improve!__ Feel free to modify and use the source code as you like. If you have enhancements that could benefit others, your pull requests are highly encouraged.

## Changelog

- 2024.05.28
  - Added `vectorize_bar`
- 2024.05.27
  - Initial repository setup and commit.

## License

MIT
