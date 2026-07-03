/- Chapter 5 — solutions: each goal, its one right tool. -/
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Data.Nat.Prime.Basic

namespace Ch05

-- G1: linear bounds → omega.
example (a b : Nat) (h1 : a < 2^51) (h2 : b < 2^51) : a + b < 2^52 := by
  omega

-- G2: truncated subtraction → omega (it models Nat subtraction natively).
example (a b : Nat) (h : a ≤ b) : a + (b - a) = b := by
  omega

-- G3: commutative-ring identity → ring.
example (a b : Int) : (a + b) * (a - b) = a * a - b * b := by
  ring

-- G4: concrete numerals → norm_num.
example : (2:Int)^255 - 19 > 2^254 := by
  norm_num

-- G5: small finite check → decide.
example : Nat.Prime 97 := by
  decide

-- G6: linear (constant coefficient) → omega.
example (x : Nat) (h : 3 * x + 7 ≤ 100) : x ≤ 31 := by
  omega

-- G7: numerals → norm_num.
example : 2^51 + 2^51 = 2^52 := by
  norm_num

-- G8: ring.
example (x y : Int) : (x + y)^3 = x^3 + 3*x^2*y + 3*x*y^2 + y^3 := by
  ring

-- G9: the two-step pattern — bound the nonlinear atom, then omega.
example (a b : Nat) (ha : a < 100) (hb : b < 100) : a * b < 10000 := by
  have hab : a * b < 100 * 100 := Nat.mul_lt_mul'' ha hb
  omega

-- G10: multiplication by the CONSTANT 19 is linear → omega.
example (a : Nat) (h : a < 2^51) : a * 19 < 2^56 := by
  omega

end Ch05
