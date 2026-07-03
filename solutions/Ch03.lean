/- Chapter 3 — solutions. Term mode only, as required. -/

namespace Ch03

variable (P Q R : Prop)

theorem const_imp : P → Q → P :=
  fun p _ => p

theorem and_to_or : P ∧ Q → P ∨ Q :=
  fun h => Or.inl h.1

theorem modus_ponens : P → (P → Q) → Q :=
  fun p f => f p

theorem and_assoc' : (P ∧ Q) ∧ R → P ∧ (Q ∧ R) :=
  fun h => And.intro h.1.1 (And.intro h.1.2 h.2)

theorem or_swap : P ∨ Q → Q ∨ P :=
  fun h => match h with
    | Or.inl p => Or.inr p
    | Or.inr q => Or.inl q

/- The program: "given evidence p for P and a refuter f of P, feed p to f."
   A proof of ¬¬P is a function that defeats any would-be refutation. -/
theorem not_not_intro : P → ¬¬P :=
  fun p f => f p

end Ch03
