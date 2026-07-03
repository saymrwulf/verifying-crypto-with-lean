/- Chapter 2 — solutions. Every definition compiles with no sorry. -/

namespace Ch02

def p : Nat := 2 ^ 255 - 19

def double (n : Nat) : Nat := 2 * n

-- Exercise A: multiplication bootstrapped from addition.
def mul : Nat → Nat → Nat
  | _, Nat.zero   => 0
  | m, Nat.succ n => mul m n + m

#eval mul 6 7      -- 42
#eval mul 0 9      -- 0

-- Exercise 2.1
def pow : Nat → Nat → Nat
  | _, Nat.zero   => 1
  | b, Nat.succ e => pow b e * b

#eval pow 2 10     -- 1024

-- Exercise 2.2
def fib : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fib (n + 1) + fib n

#eval fib 10       -- 55

/- Exercise 2.3. The type cannot enforce `den ≠ 0`: a value ⟨1, 0⟩ is
   perfectly constructible. Chapter 3's dependent structures fix this by
   storing a proof `den ≠ 0` inside the value. -/
structure Rational where
  num : Int
  den : Nat

def Rational.add (x y : Rational) : Rational :=
  ⟨x.num * y.den + y.num * x.den, x.den * y.den⟩

#eval (Rational.add ⟨1, 2⟩ ⟨1, 3⟩).num   -- 5
#eval (Rational.add ⟨1, 2⟩ ⟨1, 3⟩).den   -- 6

end Ch02
