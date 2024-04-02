(** Abstract logic behind any bot at the table *)

type hand = {
  card1 : Card.card;
  card2 : Card.card;
}
(** abstract type representing the two cards *)

type decision =
  | No
  | Fold
  | CheckCall
  | Raise of int

val make_decision : hand -> Card.card list -> int -> decision

val create_hand : Card.card -> Card.card -> hand

val initial_hand_decision : hand -> int -> decision

val compareCards : Card.card -> Card.card -> int