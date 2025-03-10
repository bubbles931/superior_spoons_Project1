function [winner] = spoons(n_players)

% initializing deck of cards
card_deck = [1:52];
shuffle_card_deck = randperm(52);

%can assign each row a specific suit (hearts, spades, etc)
card_deck_2d_array = reshape(card_deck, 13, 4).';

%a 2d array to help keep track of all the cards each player has
player_array = zeros(n_players, 4);
       
indices = 1:4;
%for loop to deal each player 4 cards
for player = 1:n_players
    player_hand = shuffle_card_deck(indices);
    player_array(player, :) = player_hand;
    indices = indices + 4;
end

disp(card_deck_2d_array)
disp(player_array)

suit = '';
num = '';
%for loop to determine what each player was dealt
for each_player = 1:size(player_array, 1)
       disp(['Player ', num2str(each_player)]);
    for player_array_col = 1:size(player_array, 2)
        one_card = player_array(each_player, player_array_col);
        [row, col] = find(card_deck_2d_array == one_card);
        if col == 1 
            num = 'Ace';
        elseif col == 11 
            num = 'Jack';
        elseif col == 12
            num = 'Queen';
        elseif col == 13
            num = 'King';
        else
            num = num2str(col);
        end
        if row == 1
            suit = 'Hearts';
        elseif row == 2
            suit = 'Diamonds';
        elseif row == 3
            suit = 'Spades';
        elseif row == 4
           suit = 'Clubs';
        end
        specific_cards = strcat(num, " of ",suit);
        disp(specific_cards)
    end
end

%next time: 
%find numbers remaining in 1:52 not dealt
%name each remaining card
%start passing cards in each round
%checking each card 
%a card to either pass or keep using a boolean

remaining_card = [];
index = 1;
for num = 1:length(card_deck) 
    for each_player = 1:size(player_array, 1)
        for player_array_col = 1:size(player_array, 2)
            one_card = player_array(each_player, player_array_col);
            if ~(one_card == num)
                remaining_card(end+1) = num;
                index = index + 1;
            end
        end
    end
end
disp(remaining_card)
end