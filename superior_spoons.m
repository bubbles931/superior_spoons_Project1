function [winner] = spoons(n_players)

% initializing deck of cards
card_deck = [1:52];

%can assign each row a specific suit (hearts, spades, etc)
card_deck_2d_array = reshape(card_deck, 13, 4).';

%a 2d array to help keep track of all the cards each player has
player_array = zeros(n_players, 4);

        

%for loop to deal each player 4 cards
for player = 1:n_players
    indices = randperm(52,4);
    player_hand = card_deck(indices);
    player_array(player, :) = player_hand;
end

disp(card_deck_2d_array)
disp(player_array)
end

%for loop to determine what each player was dealt
for each_player = 1:size(player_array, 1)
    for each_card = 1:size(player_array, 2)
        card = player_array(each_player, each_card);
        find(card_deck_ed_array, card)
