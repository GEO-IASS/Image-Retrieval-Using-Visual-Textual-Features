
% inputs: queryimage -- the filename of an input query image. databaseDirectory -- the pathname to the image database, queryDirectory -- the pathname to the queries
% outputs: closestMatches -- a cell array with the filenames of the 10 most similar images to the query

% example usage -- [closestMatches] = imageRetrieval_image('img_bags_clutch_1.jpg','/Users/tlberg/Desktop/teaching/Fall_12/hw/hw1/images/','/Users/tlberg/Desktop/teaching/Fall_12/hw/hw1/queryimages/');

function [closestMatches] = imageRetrieval_image(queryimage, databaseDirectory, queryDirectory)


% compute tiny-image descriptors for all database images here
img = [];
image_names = [databaseDirectory, '*.jpg'];
db_images = dir(image_names);
for i = 1:length(db_images)
    img_path = [databaseDirectory, db_images(i).name];
    img{i} = im2double(imread(img_path));
    if(size(img{i},3) == 3)
        img{i} = rgb2gray(img{i});
    end
    img{i} = imresize(img{i}, [32,32]);
end 


% compute tiny-image descriptor for the query image here
query_image = [queryDirectory, queryimage];
query_img = im2double(imread(query_image));
if(size(query_img,3) == 3)
    query_img = rgb2gray(query_img);
end
query_img = imresize(query_img,[32,32]);


% compute SSD between the query image descriptor and each image descriptor in the database here
for i = 1:length(db_images)
    ssd(i) = sum(sum((query_img-img{i}).^2));
end


% return the 10 closest images to the query here
[Y,I] = sort(ssd);
for i = 1:10
   result{i} = db_images(I(i)).name;
end

closestMatches = result;


% create a webpage of the returned images
fid = fopen('imageRetrieval_image.html','w');
fprintf(fid,'<html><body>\n');
for i=1:length(result)
	picname = db_images(I(i)).name;
	fprintf(fid,['<img src="images/' picname  '">\n']);
	if mod(i,3)==0
		fprintf(fid,'<br>');
	end
end
fprintf(fid,'</html>');
fclose(fid);