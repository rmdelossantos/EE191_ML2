%{
    EE191 Machine Learning Problem 2
    Russ M. Delos Santos

%}

[dataset,text] = xlsread('iris.csv');
petal = dataset(:,1:2); %data for test run
sepal = dataset(:,3:4); %data for test run
data_length(:,1) = dataset(:,1); %sepal length for test run
data_length(:,2) = dataset(:,3); %petal length for test run
text(1,:) = []; %remove table header
species = text(:,5); %species name

%{
    K-means -> doesn't handle empty clusters
    outputs scatter plot of clusters
    distance metric -> euclidean
    k = 2,3,4 -> user input   
%}

%test runs

k_means(sepal); %sepal length vs sepal width
k_means(petal); %petal length vs petal width
k_means(data_length); %sepal length vs petal length


%{
    K Nearest Neightbors -> 90% training 10% test from iris.csv
    k -> user input  
    outputs predicted species class and the k nearest neighbor(s)
%}

%code dividing the dataset by 90:10
%random
[rows,cols] = size(dataset);
training_data = dataset;
for i = 1:15
    [rows,cols] = size(training_data);
    index = randi(rows);
    test_data(i,:) = training_data(index,:);
    test_species(i,1) = species(index,1);
    training_data(index,:) = [];
    species(index,:) = [];
end
training_species = species;
%{
change index from test_data(index,:) - 1 to 15 to test
%outputs predicted class and neighbor distance values
%check from test_species(index,:), depending on test_data index if same
from predicted class
%}
[predicted_class, neighbor_values] = k_nn(training_data,training_species,test_data(1,:));
