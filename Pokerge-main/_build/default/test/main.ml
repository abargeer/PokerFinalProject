open OUnit2
open Poker.Card
open Poker.Player 
open Poker.Bot 
open Poker.State

let check_hand_test (name : string) (func : Card.card list -> bool)
    (input : Card.card list) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (func input)

(*"Spade" | 1 -> "Clubs" | 2 -> "Hearts" | 3 -> "Diamond"*)

let bot_check_tests =
  [
    (let twoSpades = Card.create_card ("Two", "Spade") in
     let twoHearts = Card.create_card ("Two", "Hearts") in
     let fiveHearts = Card.create_card ("Five", "Hearts") in
     let sixHearts = Card.create_card ("Six", "Hearts") in
     let sevenHearts = Card.create_card ("Seven", "Hearts") in
     let eightHearts = Card.create_card ("Eight", "Hearts") in
     let nineHearts = Card.create_card ("Nine", "Hearts") in
     let jackHearts = Card.create_card ("Jack", "Hearts") in
     let kingHearts = Card.create_card ("King", "Hearts") in
     let aceHearts = Card.create_card ("Ace", "Hearts") in
     let sevenClubs = Card.create_card ("Seven", "Clubs") in
     let eightDiamonds = Card.create_card ("Eight", "Diamond") in
     let fourClubs = Card.create_card ("Four", "Clubs") in
     let twoDiamonds = Card.create_card ("Two", "Diamond") in
     let twoClubs = Card.create_card ("Two", "Clubs") in
     let fiveClubs = Card.create_card ("Five", "Clubs") in
     let fiveSpades = Card.create_card ("Five", "Spade") in

     check_hand_test "noPairTest false" Bot.check_pair
       [ twoClubs; fiveHearts; sevenClubs; fourClubs; eightDiamonds ]
       false;
     check_hand_test "OnePairTest true" Bot.check_pair
       [ twoClubs; fiveHearts; sevenClubs; twoDiamonds; eightDiamonds ]
       true;
     check_hand_test "noTwoPairTest false" Bot.check_2pair
       [ twoClubs; fiveHearts; sevenClubs; fourClubs; eightDiamonds ]
       false;
     check_hand_test "noTwoPairTest w/ only 1 pair false" Bot.check_2pair
       [ twoClubs; fiveHearts; sevenClubs; twoClubs; eightDiamonds ]
       false;
     check_hand_test "TwoPairTest true" Bot.check_2pair
       [ twoClubs; fiveHearts; sevenClubs; twoDiamonds; fiveClubs ]
       true;
     check_hand_test "noThreeKindTest false" Bot.check_3kind
       [ twoClubs; fiveHearts; sevenClubs; twoDiamonds; fiveClubs ]
       false;
     check_hand_test "ThreeKindTest true" Bot.check_3kind
       [ twoClubs; fiveHearts; sevenClubs; twoDiamonds; twoHearts ]
       true;
     check_hand_test "straightTest false" Bot.check_straight
       [ twoClubs; fiveHearts; sevenClubs; twoDiamonds; fiveClubs ]
       false;
     check_hand_test "straightTest true" Bot.check_straight
       [ fourClubs; fiveHearts; sixHearts; sevenClubs; eightDiamonds ]
       true;
     check_hand_test "straightTest different order true" Bot.check_straight
       [ sixHearts; fiveClubs; sevenClubs; eightDiamonds; fourClubs ]
       true;
     check_hand_test "flushTest false" Bot.check_flush
       [ twoClubs; fiveHearts; sevenClubs; twoDiamonds; fiveClubs ]
       false;
     check_hand_test "almostFlushTest false" Bot.check_flush
       [ twoHearts; fiveHearts; sevenClubs; kingHearts; aceHearts ]
       false;
     check_hand_test "flushTest true" Bot.check_flush
       [ twoHearts; fiveHearts; jackHearts; kingHearts; aceHearts ]
       true;
     check_hand_test "flushTest2 true" Bot.check_flush
       [ twoHearts; fiveHearts; jackHearts; sixHearts; aceHearts ]
       true;
     check_hand_test "fullHouseTest false" Bot.check_full_house
       [ twoHearts; fiveHearts; jackHearts; kingHearts; aceHearts ]
       false;
     check_hand_test "fullHouseTestTwosFives true" Bot.check_full_house
       [ twoHearts; twoSpades; twoDiamonds; fiveClubs; fiveHearts ]
       true;
     check_hand_test "fullHouseTestFivesTwos true" Bot.check_full_house
       [ twoHearts; fiveSpades; twoHearts; fiveClubs; fiveHearts ]
       true;
     check_hand_test "fourKindTest false" Bot.check_4kind
       [ twoHearts; twoSpades; fiveHearts; fiveClubs; twoClubs ]
       false;
     check_hand_test "fourKindTest true" Bot.check_4kind
       [ twoHearts; twoSpades; fiveHearts; twoDiamonds; twoClubs ]
       true;
     check_hand_test "straightFlush true" Bot.check_straight_flush
       [ fiveHearts; sixHearts; sevenHearts; eightHearts; nineHearts ]
       true;
     check_hand_test "straightFlushUnordered true" Bot.check_straight_flush
       [ eightHearts; sixHearts; nineHearts; sevenHearts; fiveHearts ]
       true);
  ]
*
  (* let winnerTests = [
    let twoSpades = Card.create_card ("Two", "Spade") in
     let twoHearts = Card.create_card ("Two", "Hearts") in
     let fiveHearts = Card.create_card ("Five", "Hearts") in
     let sixHearts = Card.create_card ("Six", "Hearts") in
     let sevenHearts = Card.create_card ("Seven", "Hearts") in
     let eightHearts = Card.create_card ("Eight", "Hearts") in
     let nineHearts = Card.create_card ("Nine", "Hearts") in
     let jackHearts = Card.create_card ("Jack", "Hearts") in
     let kingHearts = Card.create_card ("King", "Hearts") in
     let aceHearts = Card.create_card ("Ace", "Hearts") in
     let sevenClubs = Card.create_card ("Seven", "Clubs") in
     let eightDiamonds = Card.create_card ("Eight", "Diamond") in
     let fourClubs = Card.create_card ("Four", "Clubs") in
     let twoDiamonds = Card.create_card ("Two", "Diamond") in
     let twoClubs = Card.create_card ("Two", "Clubs") in
     let fiveClubs = Card.create_card ("Five", "Clubs") in
     let fiveSpades = Card.create_card ("Five", "Spade") in
     let pairRiver = [twoClubs; twoDiamonds; fiveHearts; fourClubs; kingHearts;] in
     let pairRiver2 = [twoClubs; twoDiamonds; fiveHearts; fourClubs; eightDiamonds;] in
     let twoPairRiver = [twoClubs; sevenHearts; fiveHearts; sevenClubs; twoSpades] in
     let allHeartsRiver = [eightHearts; nineHearts; fiveHearts; sixHearts; twoHearts] in
     let clubsFlushPossibleRiver = [twoClubs; fiveHearts; sevenClubs; fourClubs; fiveSpades] in
     let playerHand1 = Player.create_hand (twoHearts) (twoSpades) in
     let playerHand2 = Player.create_hand (jackHearts) (twoSpades) in
     let playerHand3 = Player.create_hand (fiveClubs) (aceHearts) in
     let botHand1 = Bot.create_hand (sevenClubs) (fiveClubs) in
     let botHand2 = Bot.create_hand (jackHearts) (fiveClubs) in
     let botHand3 = Bot.create_hand (twoHearts) (fiveClubs) in
     let botHand4 = Bot.create_hand (sevenClubs) (fiveClubs)
  ] *)

let suite = "test suite" >::: List.flatten [ bot_check_tests ]

let _ = run_test_tt_main suite