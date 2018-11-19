function [ class, neighbors ] = k_nn( training_data, training_species, test_data )

    %user input for k value
    % if no input or cancelled, k = 2 by default
    title = 'Input K';
    k = inputdlg('Enter k value',title, [1, length(title)+25]);
    check = str2double(cell2mat(k));
    k = str2double(cell2mat(k));
    if isnan(check) || isempty(k)
        k = 2; %default k
        message = sprintf('Value needs to be placed.\nI will use k = %f for kmeans.', k);
        uiwait(warndlg(message));
    end
    
    [rows,cols] = size(training_data);
    
    %euclidean distance of test_data from training data
    for i = 1:rows
        distance(i,1) = i; %index
        distance(i,2) = norm(test_data(1,:)-training_data(i,:));
    end
    
    %sort distances 
    sorted_distance = sortrows(distance,2);
    
    %choose k amount of nearest neighbor
    counter = 1;
    for i = 1:k
       neighbors(counter,:) = sorted_distance(i,:); 
       counter = counter + 1;
    end
    
    %check the most classes in the neighbors
    vote=zeros(k,2);
    for i = 1:k
        index = neighbors(i,1);
        take = training_species(index,1);
        vote(i,1) = index;
        %compare loop
        for j = k:-1:1
            if isequal(take, training_species((neighbors(j,1)),1))
                vote(i,2) = vote(i,2)+1;
            end
        end   
    end
    sorted_vote = sortrows(vote,2)
    class = training_species(sorted_vote(k,1),1);
    
end

