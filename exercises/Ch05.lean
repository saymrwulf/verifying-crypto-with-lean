/- Chapter 5 — Numbers and Automation: exercises.
   Ten goals; each is solved by exactly ONE of
       omega / ring / norm_num / decide
   in one shot. Your task is to close each with the RIGHT tool —
   overkill is rejected by design (and by your conscience).
   Requires Mathlib (see README for setup). -/
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Data.Nat.Prime.Basic

namespace Ch05

-- G1: bounds bookkeeping — the everyday goal of verified arithmetic.
example (a b : Nat) (h1 : a < 2^51) (h2 : b < 2^51) : a + b < 2^52 := by
  sorry

-- G2: truncated Nat subtraction, handled honestly.
example (a b : Nat) (h : a ≤ b) : a + (b - a) = b := by
  sorry

-- G3: a polynomial identity in any commutative ring.
example (a b : Int) : (a + b) * (a - b) = a * a - b * b := by
  sorry

-- G4: a concrete numeric fact with big numbers.
example : (2:Int)^255 - 19 > 2^254 := by
  sorry

-- G5: a finite check.
example : Nat.Prime 97 := by
  sorry

-- G6: linear again — with a twist of multiplication BY A CONSTANT.
example (x : Nat) (h : 3 * x + 7 ≤ 100) : x ≤ 31 := by
  sorry

-- G7: pure numeral arithmetic.
example : 2^51 + 2^51 = 2^52 := by
  sorry

-- G8: binomial cube.
example (x y : Int) : (x + y)^3 = x^3 + 3*x^2*y + 3*x*y^2 + y^3 := by
  sorry

-- G9 (exercise 5.2, the two-step pattern): nonlinear, so omega alone
-- fails. First BOUND the product with mul-monotonicity, then release
-- the linear solver. Useful: Nat.mul_lt_mul'' or Nat.mul_le_mul.
example (a b : Nat) (ha : a < 100) (hb : b < 100) : a * b < 10000 := by
  sorry

-- G10: the Chapter 4 cliffhanger. Multiplication by 19 is linear!
example (a : Nat) (h : a < 2^51) : a * 19 < 2^56 := by
  sorry

end Ch05
