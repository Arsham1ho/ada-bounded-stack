# bounded_stack — a first Ada package

A generic bounded stack, written to learn how Ada expresses safety conditions
in the interface rather than leaving them to the caller to remember.

The point of the exercise is `src/bounded_stack.ads`. The contract lives in the
spec:

```ada
procedure Push (S : in out Stack; Value : Item)
  with Pre  => not Is_Full (S),
       Post => Size (S) = Size (S'Old) + 1 and then not Is_Empty (S);
```

Depth is a constrained subtype, so an out-of-range value is a type error rather
than a runtime surprise. `Push` cannot be called on a full stack and `Pop`
cannot be called on an empty one — and both state what must be true afterwards.
Built with assertions enabled, a caller that breaks one of those fails at the
call site, not three frames deeper once something has already been corrupted.

Coming from Rust and C++, the difference that stood out is where the obligation
sits. In C++ this would be a comment above the function and a hope. Here it is
part of the interface, checkable by the compiler and the runtime, and readable
by someone deciding whether this code can be trusted.

## Build and run

```sh
alr build
./bin/stack_demo
```

```
Pushing 1 .. 5
Depth after pushes: 5
Top of stack: 5
Popping everything back off:
  popped 5
  ...
Empty again: TRUE
Popping an empty stack, to show the precondition firing:
  caught: precondition violated, as intended
```

Built with [Alire](https://alire.ada.dev) and GNAT.
