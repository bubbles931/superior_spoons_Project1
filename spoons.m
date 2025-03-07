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


%for loop to determine what each player was dealt
for each_player = 1:size(player_array, 1)
       disp(['Player ', num2str(each_player)]);
    for each_card = 1:size(player_array, 2)
        card = player_array(each_player, each_card);
        [row, col] = find(card_deck_2d_array == card);
        if row == 1
            disp([num2str(col), ' of hearts'])
        elseif row == 2
           disp([num2str(col), ' of diamonds']) 
        elseif row == 3
            disp([num2str(col), ' of spades'])
        elseif row ==4
            disp([num2str(col), ' of clubs'])
        end
    end
end
end


