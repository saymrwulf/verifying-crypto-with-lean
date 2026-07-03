/- Chapter 2 — Meet Lean: exercises.
   Replace each `sorry` and watch the warnings disappear.
   Check your work: every `#eval` line below a definition should print
   the value promised in its comment. -/

namespace Ch02

-- The constant that follows us through the whole book.
def p : Nat := 2 ^ 255 - 19

def double (n : Nat) : Nat := 2 * n

/- Exercise A (from the Try It box): multiplication by recursion.
   Define `mul` using `Nat.add` (or `+`), by recursion on the second
   argument — the same bootstrapping order (add, then mul) the real
   field proofs follow. Do NOT use `*`. -/
def mul : Nat → Nat → Nat
  | _, Nat.zero   => sorry
  | m, Nat.succ n => sorry

-- uncomment when your definition is in place:
-- #eval mul 6 7      -- expected: 42
-- #eval mul 0 9      -- expected: 0

/- Exercise 2.1: exponentiation by recursion on the exponent.
   Do NOT use `^`. You may use `*`. -/
def pow : Nat → Nat → Nat
  | _, Nat.zero   => sorry
  | b, Nat.succ e => sorry

-- #eval pow 2 10     -- expected: 1024

/- Exercise 2.2: the Fibonacci numbers, naive recursion.
   Then evaluate `fib 32` and notice the pause: your ALGORITHM is
   exponential even though #eval itself is fast. -/
def fib : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => sorry

-- #eval fib 10       -- expected: 55

/- Exercise 2.3: a structure with a smuggled weakness.
   Complete `Rational.add` (school formula: a/b + c/d = (ad+cb)/(bd)).
   Then answer in a comment: what property of `den` can this type NOT
   enforce yet? (Chapter 3 gives the tool to fix it.) -/
structure Rational where
  num : Int
  den : Nat

def Rational.add (x y : Rational) : Rational :=
  sorry

-- #eval (Rational.add ⟨1, 2⟩ ⟨1, 3⟩).num   -- expected: 5
-- #eval (Rational.add ⟨1, 2⟩ ⟨1, 3⟩).den   -- expected: 6

end Ch02
