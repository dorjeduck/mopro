# progressbar.🔥

A lightweight and customizable progress bar for Mojo, ideal for tracking the progress of long-running operations in loops.

## Usage

In its simplest usage, you specify the total number of iterations and provide a callback function that will be called for each iteration:

```python
from time import sleep
from mopro import progress_bar

fn main():
    fn one_step(i: Int) -> Bool:
        sleep(0.01)
        return True

    progress_bar(
        total=256,
        callback=one_step
    )
```

![example1.mojo](./imgs/example1.png)

### Terminating the loop

When the callback function returns `False`, the loop will terminate.


```python
from time import sleep
from mopro import progress_bar

fn main():
    fn one_step(i: Int) -> Bool:
        sleep(0.01)
        # your operations ...
        return i<197

    progress_bar(
        total=256,
        callback=one_step
    )
```

### Customizations

```python
from time import sleep
from mopro import progress_bar

fn main():
    fn one_step(i: Int) -> Bool:
        sleep(0.01)
        return True
        
    progress_bar(
        total=256,
        callback=one_step, 
        prefix="Epoch:", 
        bar_size=20,
        bar_fill = "🔥",
        bar_empty = "  "
    )
```

![example2.mojo](./imgs/example2.png)

## Remarks

- __Looking for More Advanced Features?__ Check out [Are We Done Yet](https://github.com/Ryul0rd/awdy) for a more advanced progress bar implementation in Mojo. Hillarious name - love it 🔥


- __Contribute and Improve!__ Feel free to modify and use the source code as you like. If you have enhancements that could benefit others, your pull requests are highly encouraged.

## License

MIT
