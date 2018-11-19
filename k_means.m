function [] = k_means( data )
        
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
    
    [rows,cols] = size(data);
    
    %initialize distance, clusters & centroid array
    for i = 1:k
        value = randi(rows);%(randomly picked)
        centroid(i,:) = data(value,:); 
    end
    distance = zeros(1,k);
    placeholder = zeros(size(centroid));
    
    while isequal(centroid,placeholder) == 0
        clusters = zeros(rows,k);
        %measure euclidean distance of data point from each centroid
        for j = 1:rows
            for n = 1:k
                distance(j,n) = norm(data(j,:)-centroid(n,:));
            end
        end
        
        %evaluate nearness then assigns nearest to cluster
        for j = 1:rows
            minimum = min(distance(j,:));
            for n = 1:k
                if isequal(minimum,distance(j,n))
                    clusters(j,n) = j;
                end
            end
        end
        
        placeholder = centroid;
        
        %compute new centroid
        for n = 1:k
            value = 0;
            for i=1:rows
                if isequal(clusters(i,n),0)
                    continue
                else
                    index = clusters(i,n);
                    for j = 1:cols
                        centroid(n,j) = centroid(n,j) + data(index,j);
                    end
                end
            end
            centroid(n,:) = centroid(n,:)/nnz(clusters(:,n)); %mean for new centroid
        end
    
    
    end
    %scatter plot
    for n = 1:k
        for i=1:rows
            if isequal(clusters(i,n),0)
                continue
            else
                data(i,cols+1) = n;
            end
        end
    end
    figure;
    gscatter(data(:,1),data(:,2),data(:,cols+1),...
        [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
    hold on;
    legend('Location','SouthEast')
    hold off;
end

