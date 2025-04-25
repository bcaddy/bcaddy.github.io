---
title:      Type Hinting for PrincetonPy                 # Title
author:     Robert Caddy               # Author Name
date:       2025-04-25 09:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Python, Type Hinting, Guides]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

*Disclaimer: This document is intended to serve as the base for a discussion on Python type hinting I led for the Princeton University Python User Group (i.e. PrincetonPy) on May 1st, 2025. I am not an expert in type hinting and this document is not a true introduction to type hinting in Python. For a more in depth introduction to to type hinting I recommend the [static type checking](https://learn.scientific-python.org/development/guides/mypy/) section of the [Scientific Python Development Guide](https://learn.scientific-python.org/development/) or the [typing](https://henryiii.github.io/se-for-sci/content/week08/typing.html) section of [SE for Sci](https://henryiii.github.io/se-for-sci/content/intro.html).*

## What is Type Hinting in Python?

Type hinting in Python is the current supported way of adding static strong(ish) typing to Python. It only operates statically, i.e. not at run time, with the help of tools like [mypy](https://mypy.readthedocs.io/en/stable/), [pyright](https://github.com/microsoft/pyright), [pytype](https://github.com/google/pytype), [pyre](https://pyre-check.org), and whatever [Astral](https://astral.sh) comes up with when they finish their type checker. I've only used mypy so I will discuss typing in that context. Mypy, and the other type checkers to various degrees, support gradual typing, only enforcing typing on typed code and ignoring untyped code. You can force it to do typing on all code with the `--strict` flag, or more granularly with other flags.

Currently you have, broadly speaking, three options on dealing with types in Python and function/class boundaries when you don't know what types your users might pass in:

1. Lean into duck typing hope for the best, accepting that it might introduce bugs or just crash if the user passes the wrong type
2. Put `is instance(var, type)` everywhere
3. Try to account for every reasonable type the user might pass in, i.e. they might pass in a `str` instead of a `pathlib.Path`

None of these options are particularly good and type hinting hopes to solve, or at least minimize, them.

## Language Support

Python 2 is not well supported since it's been sunsetted for 5 years. The type hinting syntax I'm discussing here was introduced in Python 3.5 and has been expanded and improved upon in most releases since then. I'm currently using Python 3.13 and will assume you are too. I recommend Python 3.10 at a minimum since it significantly improves the union syntax. Python 3.7+ can get Python 3.13 typing with `from __future__ import annotations`.

## Syntax

Anything in `<>` is a placeholder.

```py
# Functions
def f1(x: int,
       y: int | float,
       z: int = 12) -> int:
    return x**2 + y**2 + z**2

# Variables, usually these types can be inferred by the type checker
var: float = 1.2

# Collections
collection: list[int | float] = [1, 2.2]
tup : tuple[int, float, str] = (1, 2.2, "hello")
tup2 : tuple[int, ...] = (1, 2, 3)
d: dict[str, int] = {"one": 1, "two": 2}
d2: dict[str, int | float] = {"one": 1, "two": 2.2}

# Iterables
def f2(it: Iterable[str]): # other generics like `Iterable` exist
    for element in it:
        do something

# Support any type
from typing import Any
var: Any = <whatever you want>

# Typed Dict (example from https://peps.python.org/pep-0589/)
from typing import TypedDict

# Syntax option 1, total is optional
class Movie(TypedDict, total=<bool>):
#   Key   type of the value
    name: str
    year: int

# Syntax option 2, total is optional
Movie = TypedDict('Movie', {'name': str, 'year': int}, total=<bool>)

# Usage
movie: Movie = {'name': 'Blade Runner',
                'year': 1982}
```

## Type Narrowing

Type narrowing tracks if an initial declaration was a union (like `int | None`) and reduces it to a known, specific, type. Especially useful for optional parameters.

```py
def f(x: str | None = None):
    if x is None:
        return ""
    return x

# Other ways to type narrow
assert x is not None
assert isinstance(x, str)
```

## Stub Files

Stub files (`.pyi`) can be used to add typing to untyped code. Could be used to add typing a third party library that doesn't support it.

## `Final` Keyword

The `Final` keyword is equivalent to `const` in C++. When a variables is declared as `Final` it cannot be changed, note that the static type checker enforces this, not the runtime, so that in practice it can be changed but mypy will warn you about that when you run mypy.

```py
x: Final = 3 # infering the type
x: Final[int] = 3 # explicitely stating the type
```

## Checking Types

```py
# Don't use the built in type() function. Instead use:
import typing

x = <some function> # Type is inferred but you don't know what it is

print(typing.reveal_type(x))
```

## Literals

```py
from typing import Literal

# "type" definition for something that can only have a few specific values
def run(action: Literal["start", "stop"]) -> bool:
    if action == "start":
        return True
    return False
```

## Protocols

```py
# Enforce that a more generic type has a specific method. Basically static
#duck typing rather than runtime
from typing import Protocol

class DoesSomething(Protocol):
    def do_something(self) -> None: ...

def f(x: DoesSomething) -> None:
    x.do_something()
```

There's a lot more you can do with protocols, see [here](https://henryiii.github.io/se-for-sci/content/week08/typing.html#structural-subtyping) for a discussion.

## Third Party Libraries

Support for types in third partly libraries is all over the place. I'll just highlight a few libraries that I've used.

- The Python Standard Library: Support is good, generally it just works
- Numpy: Has typing support. [Typing numpy objects](https://numpy.org/devdocs/reference/typing.html#numpy.typing.NBitBase) is incredibly confusing but seems to generally work.
- h5py: No typing support at all
- matplotlib: Seems to work, I haven't written much typed matplotlib code
