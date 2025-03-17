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

suit = '';
num = '';

player_array_card_names = string(0);
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
        specific_cards = strcat(num, " of ",suit);
        player_array_card_names(end+1) = specific_cards;
        display_specific_cards = strcat(card_num, ". ", num, " of ",suit);
        disp(display_specific_cards)
        
    end
end
disp (player_array_card_names)
index = 2;
player_array_card_names_cell = cell(n_players, 4);
for itr = 1:size(player_array, 1)
    for i = 1:size(player_array, 2)
        player_array_card_names_cell{itr, i} = player_array_card_names(index);
        index = index + 1;
    end
end
disp(player_array_card_names_cell)
%player_array_card_names = (reshape(player_array_card_names, size(player_array, 1), size(player_array, 2)));
%disp(player_array_card_names)

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

%individualizing players using while loop

current_player = 1;
loose_cards = strings(0);
discard_pile = strings(0);
while current_player <= n_players
    while current_player == 1
        if isempty(stored_names)
            stored_names = discard_pile;
        end
        curr_player = strcat("Player ", num2str(current_player), "'s Turn");
        disp(curr_player)
        disp("Current Hand");
        disp(strcat(player_array_card_names_cell(current_player,:)));
%displaying a card to player 1
        index_stored_names = randi([1 length(stored_names)]);
        current_card = stored_names(index_stored_names);
        disp(current_card)
        stored_names(index_stored_names) = [];
            %remove current card from stored names
        %user input either pass or keep
        prompt = "pass or keep?";
        txt = input(prompt, 's');
       %conditional statement,if keep, then which card to remove
        if strcmp(txt, 'pass')
           loose_cards(end+1) = current_card;
           index_stored_names = randi([1 length(stored_names)]);
           current_card = stored_names(index_stored_names);
           disp(current_card)
        elseif strcmp(txt, 'keep')
            prompt = 'Which card would you like to discard: 1, 2, 3, or 4?';
            x = input(prompt);
            discard_card = player_array_card_names_cell{current_player, x};
            loose_cards(end+1) = discard_card;
            player_array_card_names_cell{current_player, x} = current_card;
                %swap current card to loose card, loose card goes into
                %loose_card; update player_array
        elseif strcmp(txt, 'exit')
            return;
        else
           prompt = "Ensure that you type the command specificially: again, pass or keep?";
           txt = input(prompt, 's');
        end
       current_player = current_player + 1;
       disp(current_player)
       disp(loose_cards)
    end
    while current_player ~= 1 && current_player < n_players
        disp(strcat("Player ", num2str(current_player), "'s Turn"))
        disp("Current Hand");
        disp(strcat(player_array_card_names_cell(current_player, :)));
        for indx = 1:length(loose_cards)
            current_card = loose_cards(indx);
            disp(current_card);
            loose_cards(indx) = [];
            %remove current card from stored names
            %user input either pass or keep
            prompt = "pass or keep?";
            txt = input(prompt, 's');
           %conditional statement,if keep, then which card to remove
            if strcmp(txt, 'pass')
                loose_cards(end+1) = current_card;

                %while strcmp(txt, 'pass')
                 %  index_stored_names = randi([1 length(stored_names)]);
                  % current_card = stored_names(index_stored_names);
                  % disp(current_card);
                  % prompt = "pass or keep?";
                  % txt = input(prompt, 's');
                  % loose_cards(end+1) = current_card;
                %end
            elseif strcmp(txt, 'keep')
                prompt = 'Which card would you like to discard: 1, 2, 3, or 4?';
                x = input(prompt);
                discard_card = player_array_card_names_cell{current_player, x};
                loose_cards(end+1) = discard_card;
                player_array_card_names_cell{current_player, x} = current_card;
                    %swap current card to loose card, loose card goes into
                    %loose_card; update player_array
                disp(player_array_card_names_cell)
            elseif strcmp(txt, 'exit')
                return;
            else
               prompt = "Ensure that you type the command specificially: again, pass or keep?";
               txt = input(prompt, 's');
            end
        end
       current_player = current_player +1; 
    end
    while current_player == n_players
        disp(strcat("Player ", num2str(current_player), "'s Turn"))
        disp("Current Hand");
        disp(strcat(player_array_card_names_cell(current_player, :)));
        for indx = 1:length(loose_cards)
            current_card = loose_cards(indx);
            disp(current_card);
            loose_cards(indx) = [];
            %remove current card from stored names
            %user input either pass or keep
            prompt = "pass or keep?";
            txt = input(prompt, 's');
           %conditional statement,if keep, then which card to remove
            if strcmp(txt, 'pass')
                discard_pile(end+1) = current_card;

                %while strcmp(txt, 'pass')
                 %  index_stored_names = randi([1 length(stored_names)]);
                  % current_card = stored_names(index_stored_names);
                  % disp(current_card);
                  % prompt = "pass or keep?";
                  % txt = input(prompt, 's');
                  % loose_cards(end+1) = current_card;
                %end
            elseif strcmp(txt, 'keep')
                prompt = 'Which card would you like to discard: 1, 2, 3, or 4?';
                x = input(prompt);
                discard_card = player_array_card_names_cell{current_player, x};
                discard(end+1) = discard_card;
                current_card = player_array_card_names_cell{current_player, x};
                    %swap current card to loose card, loose card goes into
                    %loose_card; update player_array
               disp(player_array_card_names_cell)
            elseif strcmp(txt, 'exit')
                return;
            else
               prompt = "Ensure that you type the command specificially: again, pass or keep?";
               txt = input(prompt, 's');
            end
        end
        current_player = 1;
    end
    if size(index_stored_names) == 0
        index_stored_names = discard_pile;
        discard_pile = strings(0);
    end
end
end

% make new array with cards in play


% update player array and stored names if kept 
% go through the indices of this new array for the rest of the players to use
% once the player array and stored names is empty, make feeder use new array

%next time
%fix pass or keep so every time a card is drawn we update the stored_names
%finish the feeder code, worry about trash and intermediate layer
%list
%finish keep and pass

%display players hand each turn to compare if they should keep or pass card
% have to test if player array or player array names gets updated 
