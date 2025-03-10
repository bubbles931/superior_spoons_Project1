function [winner] = spoons(n_players)

% initializing deck of cards
card_deck = [1:52];
shuffle_card_deck = randperm(52);

%can assign each row a specific suit (hearts, spades, etc)
card_deck_2d_array = reshape(card_deck, 13, 4).';

%a 2d array to help keep track of all the cards each player has
player_array = zeros(n_players, 4);
       
indices = 1:4;

%nitializing empty vector for stored card names
stored_names = strings(0);

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
        card_num = num2str(player_array_col);
        specific_cards = strcat(card_num, ". ", num, " of ",suit);
        disp(specific_cards)
    end
end

%FIND NUMBERS REMAINING IN 1:52 NOT DEALT 
remaining_card = card_deck;
for num = 1:length(card_deck) %1:52 
    for each_player = 1:size(player_array, 1) %
        for player_array_col = 1:size(player_array, 2)
            one_card = player_array(each_player, player_array_col);
            if (one_card == num)
                remaining_card(num) = 0;
            end
        end
    end
end
disp(remaining_card)

%NAME EACH REMAINING CARD
remaining_deck_array = reshape(remaining_card, 13, 4);
    for remaining_deck_row = 1:size(remaining_deck_array, 1)
       for remaining_deck_col = 1:size(remaining_deck_array, 2)
           one_card = remaining_deck_array(remaining_deck_row, remaining_deck_col);
           if ~(one_card == 0)
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
            remaining_card_name = strcat(num, " of ",suit);
            stored_names(end+1) = (remaining_card_name);
            
           end
       end
       
    end
disp(stored_names)


%individualizing players using while loop
current_player = 1;

while current_player ~= n_players
%displaying a card to player 1
    index_stored_names = randi([1 length(stored_names)]);
    current_card = stored_names(index_stored_names);
    disp(current_card);
    %user input either pass or keep
    prompt = "pass or keep?";
    txt = input(prompt, 's');
   %conditional statement,if keep, then which card to remove
    if strcmp(txt, 'pass')
        while strcmp(txt, 'pass')
           index_stored_names = randi([1 length(stored_names)]);
           current_card = stored_names(index_stored_names);
           disp(current_card);
           prompt = "pass or keep?";
           txt = input(prompt, 's');
        end
    elseif strcmp(txt, 'keep')
        prompt = 'Which card would you like to discard? (';
        txt = input(prompt, 's');
    else

    end
    current_player = current_player + 1;
end


end

%next time
%fix pass or keep so every time a card is drawn we update the stored_names
%list
%finish keep and pass

