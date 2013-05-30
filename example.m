
% simple matlab code to create a webpage showing images

pics = dir('queryimages/*.jpg');

fid = fopen('webpage.html','w');
fprintf(fid,'<html><body>\n');
for i=1:length(pics)
	picname = pics(i).name;
	fprintf(fid,['<img src="queryimages/' picname '">\n']);
	if mod(i,3)==0
		fprintf(fid,'<br>');
	end
end
fprintf(fid,'</html>');
fclose(fid);
	

