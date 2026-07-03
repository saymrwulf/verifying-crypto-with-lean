/- Chapter 4 — Tactics: exercises.
   Now the game flips: TACTIC MODE. Place your cursor after each `by`
   and watch the goal state as you work.
   We define our own addition so the standard library can't spoil the fun. -/

namespace Ch04

/-- Our own Nat addition, recursion on the SECOND argument —
    so `n + 0 = n`-style facts about `myAdd m 0` need REAL proofs. -/
def myAdd : Nat → Nat → Nat
  | m, Nat.zero   => m
  | m, Nat.succ n => Nat.succ (myAdd m n)

/- Warm-up (worked in the chapter): and_swap in tactic mode.
   Tactics: intro, constructor, exact. Goal state drawn for you:

     P Q : Prop
     ⊢ P ∧ Q → Q ∧ P                                                  -/
theorem and_swap (P Q : Prop) : P ∧ Q → Q ∧ P := by
  sorry

/- 4.1a: the definitional direction is free... but this one is not.
   `myAdd 0 n = n` needs induction on n.
   Cases will be:  zero: ⊢ myAdd 0 0 = 0        (computes: rfl)
                   succ: ih : myAdd 0 k = k
                         ⊢ myAdd 0 (k+1) = k+1  (unfold one step, use ih)
   Useful: `simp only [myAdd]` unfolds one layer of the definition,
   or `rw [myAdd]`; then `rw [ih]`. -/
theorem zero_myAdd (n : Nat) : myAdd 0 n = n := by
  sorry

/- 4.1b: the mirror image of the second defining equation. -/
theorem succ_myAdd (m n : Nat) : myAdd (Nat.succ m) n = Nat.succ (myAdd m n) := by
  sorry

/- 4.2: commutativity, by induction on n, using 4.1a and 4.1b.
   Write ONE prose sentence per case in a comment when you're done. -/
theorem myAdd_comm (m n : Nat) : myAdd m n = myAdd n m := by
  sorry

/- 4.3: repair the broken calc chain. Exactly ONE step below is wrong.
   Find it (read the goal state where the error appears!), fix it, done.
   This is the most realistic job training in this book.

theorem calc_repair (a b : Nat) (h : a = 2 * b) : a + a + b = 5 * b := by
  calc a + a + b = 2 * a + b       := by omega
       _         = 2 * (2 * b) + b := by rw [h]
       _         = 4 * b + b       := by omega
       _         = 6 * b           := by omega     -- ← suspicious…
-/

end Ch04
