
% inputs: queryimage -- the filename of an input query image. databaseDirectory -- the pathname to the image database, queryDirectory -- the pathname to the queries
% outputs: closestmatches -- a cell array with the filenames of the 10 most similar images to the query

% example usage -- [closestMatches] = imageRetrieval_freestyle('img_bags_clutch_1.jpg','/Users/tlberg/Desktop/teaching/Fall_12/hw/hw1/images/','/Users/tlberg/Desktop/teaching/Fall_12/hw/hw1/queryimages/');

function [closestMatches] = imageRetrieval_freestyle(queryimage, databaseDirectory,queryDirectory)


img = [];
image_names = [databaseDirectory, '*.jpg'];
db_images = dir(image_names);


stopwords = {'a' 'an' 'A' 'An' 'The' 'the' 'able'	'about'	'above'	'abroad'	'Style' 'Details' 'according'	'accordingly'	'across'	'actually'	'adj'	'after'	'afterwards'	'again'	'against'	'ago'	'ahead'	'all'	'allow'	'allows'	'almost'	'alone'	'along'	'alongside'	'already'	'also'	'although'	'always'	'am'	'amid'	'amidst'	'among'	'amongst'	'an'	'and'	'another'	'any'	'anybody'	'anyhow'	'anyone'	'anything'	'anyway'	'anyways'	'anywhere'	'apart'	'appear'	'appreciate'	'appropriate'	'are'	'around'	'as'	'aside'	'ask'	'asking'	'associated'	'at'	'available'	'away'	'awfully'	'back'	'backward'	'backwards'	'be'	'became'	'because'	'become'	'becomes'	'becoming'	'been'	'before'	'beforehand'	'begin'	'behind'	'being'	'believe'	'below'	'beside'	'besides'	'best'	'better'	'between'	'beyond'	'both'	'brief'	'but'	'by'	'came'	'can'	'cannot'	'cant'	'caption'	'cause'	'causes'	'certain'	'certainly'	'changes'	'clearly'	'co'	'co.'	'com'	'come'	'comes'	'concerning'	'consequently'	'consider'	'considering'	'contain'	'containing'	'contains'	'corresponding'	'could'	'course'	'currently'	'dare'	'definitely'	'described'	'despite'	'did'	'different'	'directly'	'do'	'does'	'doing'	'done'	'down'	'downwards'	'during'	'each'	'edu'	'eg'	'eight'	'eighty'	'either'	'else'	'elsewhere'	'end'	'ending'	'enough'	'entirely'	'especially'	'et'	'etc'	'even'	'ever'	'evermore'	'every'	'everybody'	'everyone'	'everything'	'everywhere'	'ex'	'exactly'	'example'	'except'	'fairly'	'far'	'farther'	'few'	'fewer'	'fifth'	'first'	'five'	'followed'	'following'	'follows'	'for'	'forever'	'former'	'formerly'	'forth'	'forward'	'found'	'four'	'from'	'further'	'furthermore'	'get'	'gets'	'getting'	'given'	'gives'	'go'	'goes'	'going'	'gone'	'got'	'gotten'	'greetings'	'had'	'half'	'happens'	'hardly'	'has'	'have'	'having'	'he'	'hello'	'help'	'hence'	'her'	'here'	'hereafter'	'hereby'	'herein'	'hereupon'	'hers'	'herself'	'hi'	'him'	'himself'	'his'	'hither'	'hopefully'	'how'	'howbeit'	'however'	'hundred'	'ie'	'if'	'ignored'	'immediate'	'in'	'inasmuch'	'inc'	'inc.'	'indeed'	'indicate'	'indicated'	'indicates'	'inner'	'inside'	'insofar'	'instead'	'into'	'inward'	'is'	'it'	'its'	'itself'	'just'	'k'	'keep'	'keeps'	'kept'	'know'	'known'	'knows'	'last'	'lately'	'later'	'latter'	'latterly'	'least'	'less'	'lest'	'let' 'like'	'liked'	'likely'	'likewise'	'little'	'look'	'looking'	'looks'	'low'	'lower'	'ltd'	'made'	'mainly'	'make'	'makes'	'many'	'may'	'maybe'	'me'	'mean'	'meantime'	'meanwhile'	'merely'	'might'	'mine'	'minus'	'miss'	'more'	'moreover'	'most'	'mostly'	'mr'	'mrs'	'much'	'must'	'my'	'myself'	'name'	'namely'	'nd'	'near'	'nearly'	'necessary'	'need'	'needs'	'neither'	'never'	'neverf'	'neverless'	'nevertheless'	'new'	'next'	'nine'	'ninety'	'no'	'nobody'	'non'	'none'	'nonetheless'	'noone'	'no-one'	'nor'	'normally'	'not'	'nothing'	'notwithstanding'	'novel'	'now'	'nowhere'	'obviously'	'of'	'off'	'often'	'oh'	'ok'	'okay'	'old'	'on'	'once'	'one'	'ones'	'only'	'onto'	'opposite'	'or'	'other'	'others'	'otherwise'	'ought'	'our'	'ours'	'ourselves'	'out'	'outside'	'over'	'overall'	'own'	'particular'	'particularly'	'past'	'per'	'perhaps'	'placed'	'please'	'plus'	'possible'	'presumably'	'probably'	'provided'	'provides'	'que'	'quite'	'qv'	'rather'	'rd'	're'	'really'	'reasonably'	'recent'	'recently'	'regarding'	'regardless'	'regards'	'relatively'	'respectively'	'right'	'round'	'said'	'same'	'saw'	'say'	'saying'	'says'	'second'	'secondly'	'see'	'seeing'	'seem'	'seemed'	'seeming'	'seems'	'seen'	'self'	'selves'	'sensible'	'sent'	'serious'	'seriously'	'seven'	'several'	'shall'	'she'	'should'	'since'	'six'	'so'	'some'	'somebody'	'someday'	'somehow'	'someone'	'something'	'sometime'	'sometimes'	'somewhat'	'somewhere'	'soon'	'sorry'	'specified'	'specify'	'specifying'	'still'	'sub'	'such'	'sup'	'sure'	'take'	'taken'	'taking'	'tell'	'tends'	'th'	'than'	'thank'	'thanks'	'thanx'	'that'	'thats'	'the'	'their'	'theirs'	'them'	'themselves'	'then'	'thence'	'there'	'thereafter'	'thereby'	'therefore'	'therein'	'theres'	'thereupon'	'these'	'they'	'thing'	'things'	'think'	'third'	'thirty'	'this'	'thorough'	'thoroughly'	'those'	'though'	'three'	'through'	'throughout'	'thru'	'thus'	'till'	'to'	'together'	'too'	'took'	'toward'	'towards'	'tried'	'tries'	'truly'	'try'	'trying'	'twice'	'two'	'un'	'under'	'underneath'	'undoing'	'unfortunately'	'unless'	'unlike'	'unlikely'	'until'	'unto'	'up'	'upon'	'upwards'	'us'	'use'	'used'	'useful'	'uses'	'using'	'usually'	'v'	'value'	'various'	'versus'	'very'	'via'	'viz'	'vs'	'want'	'wants'	'was'	'way'	'we'	'welcome'	'well'	'went'	'were'	'what'	'whatever'	'when'	'whence'	'whenever'	'where'	'whereafter'	'whereas'	'whereby'	'wherein'	'whereupon'	'wherever'	'whether'	'which'	'whichever'	'while'	'whilst'	'whither'	'who'	'whoever'	'whole'	'whom'	'whomever'	'whose'	'why'	'will'	'willing'	'wish'	'with'	'within'	'without'	'wonder'	'would'	'yes'	'yet'	'you'	'your'	'yours'	'yourself'	'yourselves'	'zero'};

% compute your lexicon here
query_text = strrep(queryimage,'.jpg','.txt');
query_text = strrep(query_text,'img_','descr_');
query_text = [queryDirectory, query_text];
query_lines = [];
file_id = fopen(query_text,'r');
while 1
    line = fgetl(file_id);
    if ~ischar(line)
        break;
    end
    query_lines{end+1} = line;
end
fclose(file_id);

r = query_lines{1};
query_words = [];
while ~isempty(r)
    [t,r] = strtok(r);
    query_words{end + 1} = strip_punctuation(t);
end

[uniq_words] = unique(query_words);
uni_sans_stop = [];
stop_cnt=1;
for i=1:length(uniq_words)
    present=0;
    for j=1:length(stopwords)
        if(strcmp(uniq_words{i},stopwords{j}))
            present = 1;
            break;
        end
    end
    if(present == 0)
       uni_sans_stop{stop_cnt} = uniq_words{i};
       stop_cnt= stop_cnt+1;
    end
end


% compute word vector descriptors for all database image descriptions here
text_names = [databaseDirectory, 'descr*.txt'];
db_text = dir(text_names);
db_count = rand(length(db_text), length(uni_sans_stop));
db_count = db_count .* 0;
for i = 1:length(db_text)
    text_path = [databaseDirectory, db_text(i).name];   
    file_id = fopen(text_path,'r');
    db_lines = [];
    while 1
        line = fgetl(file_id);
        if ~ischar(line)
            break;
        end
        db_lines{end+1} = line;
    end 
    fclose(file_id);
    r = db_lines{1};
    db_words = [];
    while ~isempty(r)
        [t,r] = strtok(r);
        db_words{end + 1} = strip_punctuation(t);
    end 
    for j = 1:length(uni_sans_stop)
        for k = 1:length(db_words)
            if strcmp(db_words{k},uni_sans_stop{j})
                db_count(i,j) = db_count(i,j) + 1;
            end
            
        end
    end
    
end 


% compute word vector descriptor for the query image description here
query_count = rand(1, length(uni_sans_stop));
query_count = query_count .* 0;
for j = 1:length(uni_sans_stop)
    for k = 1:length(query_words)
        if strcmp(query_words{k}, uni_sans_stop{j})
            query_count(1,j) = query_count(1,j) + 1;
        end
    end
end


% calculate the magnitude for query image
query_mag = 0;
for j = 1:length(uni_sans_stop)
    query_mag = query_mag + query_count(1,j) * query_count(1,j);
end


% calculate the magnitude and cosine of all the database images
for i = 1:length(db_text)
    sum(i) = 0;
    db_mag(i) = 0;
    for j = 1:length(uni_sans_stop)
        sum(i) = sum(i) + (query_count(1,j) * db_count(i,j));
        db_mag(i) = db_mag(i) + (db_count(i,j) * db_count(i,j));
    end
    if (db_mag(i) == 0)
        cos_txt(i) = 0;
    else
        cos_txt(i) = sum(i) / (sqrt(query_mag) * sqrt(db_mag(i)));
    end   
end


% return the 10 closest images to the query here using cosine values
[Y,I] = sort(cos_txt,'descend');
for i = 1:10
   result{i} =  db_images(I(i)).name;
end

closestMatches = result;


% create a webpage of the returned images
fid = fopen('imageRetrieval_freestyle.html','w');
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
