
% inputs: queryimage -- the filename of an input query image. databaseDirectory -- the pathname to the image database, queryDirectory -- the pathname to the queries
% outputs: closestmatches -- a cell array with the filenames of the 10 most similar images to the query

% example usage -- [closestMatches] = imageRetrieval_text('img_bags_clutch_1.jpg','/Users/tlberg/Desktop/teaching/Fall_12/hw/hw1/images/','/Users/tlberg/Desktop/teaching/Fall_12/hw/hw1/queryimages/');

function [closestMatches] = imageRetrieval_text(queryimage, databaseDirectory, queryDirectory)


% declare the stopwords
stopwords = {'a' 'an' 'A' 'An' 'The' 'the' 'able'	'about'	'above'	'abroad' 'Style' 'Detail' 'according'	'accordingly'	'across'	'actually'	'adj'	'after'	'afterwards'	'again'	'against'	'ago'	'ahead'	'all'	'allow'	'allows'	'almost'	'alone'	'along'	'alongside'	'already'	'also'	'although'	'always'	'am'	'amid'	'amidst'	'among'	'amongst'	'an'	'and'	'another'	'any'	'anybody'	'anyhow'	'anyone'	'anything'	'anyway'	'anyways'	'anywhere'	'apart'	'appear'	'appreciate'	'appropriate'	'are'	'around'	'as'	'aside'	'ask'	'asking'	'associated'	'at'	'available'	'away'	'awfully'	'back'	'backward'	'backwards'	'be'	'became'	'because'	'become'	'becomes'	'becoming'	'been'	'before'	'beforehand'	'begin'	'behind'	'being'	'believe'	'below'	'beside'	'besides'	'best'	'better'	'between'	'beyond'	'both'	'brief'	'but'	'by'	'came'	'can'	'cannot'	'cant'	'caption'	'cause'	'causes'	'certain'	'certainly'	'changes'	'clearly'	'co'	'co.'	'com'	'come'	'comes'	'concerning'	'consequently'	'consider'	'considering'	'contain'	'containing'	'contains'	'corresponding'	'could'	'course'	'currently'	'dare'	'definitely'	'described'	'despite'	'did'	'different'	'directly'	'do'	'does'	'doing'	'done'	'down'	'downwards'	'during'	'each'	'edu'	'eg'	'eight'	'eighty'	'either'	'else'	'elsewhere'	'end'	'ending'	'enough'	'entirely'	'especially'	'et'	'etc'	'even'	'ever'	'evermore'	'every'	'everybody'	'everyone'	'everything'	'everywhere'	'ex'	'exactly'	'example'	'except'	'fairly'	'far'	'farther'	'few'	'fewer'	'fifth'	'first'	'five'	'followed'	'following'	'follows'	'for'	'forever'	'former'	'formerly'	'forth'	'forward'	'found'	'four'	'from'	'further'	'furthermore'	'get'	'gets'	'getting'	'given'	'gives'	'go'	'goes'	'going'	'gone'	'got'	'gotten'	'greetings'	'had'	'half'	'happens'	'hardly'	'has'	'have'	'having'	'he'	'hello'	'help'	'hence'	'her'	'here'	'hereafter'	'hereby'	'herein'	'hereupon'	'hers'	'herself'	'hi'	'him'	'himself'	'his'	'hither'	'hopefully'	'how'	'howbeit'	'however'	'hundred'	'ie'	'if'	'ignored'	'immediate'	'in'	'inasmuch'	'inc'	'inc.'	'indeed'	'indicate'	'indicated'	'indicates'	'inner'	'inside'	'insofar'	'instead'	'into'	'inward'	'is'	'it'	'its'	'itself'	'just'	'k'	'keep'	'keeps'	'kept'	'know'	'known'	'knows'	'last'	'lately'	'later'	'latter'	'latterly'	'least'	'less'	'lest'	'let' 'like'	'liked'	'likely'	'likewise'	'little'	'look'	'looking'	'looks'	'low'	'lower'	'ltd'	'made'	'mainly'	'make'	'makes'	'many'	'may'	'maybe'	'me'	'mean'	'meantime'	'meanwhile'	'merely'	'might'	'mine'	'minus'	'miss'	'more'	'moreover'	'most'	'mostly'	'mr'	'mrs'	'much'	'must'	'my'	'myself'	'name'	'namely'	'nd'	'near'	'nearly'	'necessary'	'need'	'needs'	'neither'	'never'	'neverf'	'neverless'	'nevertheless'	'new'	'next'	'nine'	'ninety'	'no'	'nobody'	'non'	'none'	'nonetheless'	'noone'	'no-one'	'nor'	'normally'	'not'	'nothing'	'notwithstanding'	'novel'	'now'	'nowhere'	'obviously'	'of'	'off'	'often'	'oh'	'ok'	'okay'	'old'	'on'	'once'	'one'	'ones'	'only'	'onto'	'opposite'	'or'	'other'	'others'	'otherwise'	'ought'	'our'	'ours'	'ourselves'	'out'	'outside'	'over'	'overall'	'own'	'particular'	'particularly'	'past'	'per'	'perhaps'	'placed'	'please'	'plus'	'possible'	'presumably'	'probably'	'provided'	'provides'	'que'	'quite'	'qv'	'rather'	'rd'	're'	'really'	'reasonably'	'recent'	'recently'	'regarding'	'regardless'	'regards'	'relatively'	'respectively'	'right'	'round'	'said'	'same'	'saw'	'say'	'saying'	'says'	'second'	'secondly'	'see'	'seeing'	'seem'	'seemed'	'seeming'	'seems'	'seen'	'self'	'selves'	'sensible'	'sent'	'serious'	'seriously'	'seven'	'several'	'shall'	'she'	'should'	'since'	'six'	'so'	'some'	'somebody'	'someday'	'somehow'	'someone'	'something'	'sometime'	'sometimes'	'somewhat'	'somewhere'	'soon'	'sorry'	'specified'	'specify'	'specifying'	'still'	'sub'	'such'	'sup'	'sure'	'take'	'taken'	'taking'	'tell'	'tends'	'th'	'than'	'thank'	'thanks'	'thanx'	'that'	'thats'	'the'	'their'	'theirs'	'them'	'themselves'	'then'	'thence'	'there'	'thereafter'	'thereby'	'therefore'	'therein'	'theres'	'thereupon'	'these'	'they'	'thing'	'things'	'think'	'third'	'thirty'	'this'	'thorough'	'thoroughly'	'those'	'though'	'three'	'through'	'throughout'	'thru'	'thus'	'till'	'to'	'together'	'too'	'took'	'toward'	'towards'	'tried'	'tries'	'truly'	'try'	'trying'	'twice'	'two'	'un'	'under'	'underneath'	'undoing'	'unfortunately'	'unless'	'unlike'	'unlikely'	'until'	'unto'	'up'	'upon'	'upwards'	'us'	'use'	'used'	'useful'	'uses'	'using'	'usually'	'v'	'value'	'various'	'versus'	'very'	'via'	'viz'	'vs'	'want'	'wants'	'was'	'way'	'we'	'welcome'	'well'	'went'	'were'	'what'	'whatever'	'when'	'whence'	'whenever'	'where'	'whereafter'	'whereas'	'whereby'	'wherein'	'whereupon'	'wherever'	'whether'	'which'	'whichever'	'while'	'whilst'	'whither'	'who'	'whoever'	'whole'	'whom'	'whomever'	'whose'	'why'	'will'	'willing'	'wish'	'with'	'within'	'without'	'wonder'	'would'	'yes'	'yet'	'you'	'your'	'yours'	'yourself'	'yourselves'	'zero'};


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
[uniq_with_stop] = unique(query_words); 


% remove the stop words from the lexicon
uniq_words = [];
stop_cnt=1;
for i=1:length(uniq_with_stop)
    present=0;
    for j=1:length(stopwords)
        if(strcmp(uniq_with_stop{i},stopwords{j}))
            present = 1;
            break;
        end
    end
    if(present == 0)
       uniq_words{stop_cnt} = uniq_with_stop{i};
       stop_cnt= stop_cnt+1;
    end
end


% compute word vector descriptors for all database image descriptions here
text_names = [databaseDirectory, 'descr*.txt'];
db_text = dir(text_names);
db_count = rand(length(db_text), length(uniq_words));
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
    sum(i) = 0;
    while ~isempty(r)
        [t,r] = strtok(r);
        db_words{end + 1} = strip_punctuation(t);
    end    
    for j = 1:length(uniq_words)
        for k = 1:length(db_words)
            if strcmp(db_words{k},uniq_words{j})
                db_count(i,j) = db_count(i,j) + 1;
                sum(i) = sum(i) + 1;
            end            
        end
    end    
end


% normalize the word vector for the db texts
for i = 1:length(db_text)
    for j = 1:length(uniq_words)
        if (sum(i) ~= 0)
            db_count(i,j) = db_count(i,j) / sum(i);
        end
    end
end


% compute word vector descriptor for the query image description here
query_count = rand(1, length(uniq_words));
query_count = query_count .* 0;
sum = 0;
for j = 1:length(uniq_words)
    for k = 1:length(query_words)
        if strcmp(query_words{k}, uniq_words{j})
            query_count(1,j) = query_count(1,j) + 1;
            sum = sum + 1;
        end
    end
end


% normalize the word vector for the lexicon
for j = 1:length(query_count)
    query_count(1,j) = query_count(1,j) / sum;
end


% compute SSD between the query descriptor and each database image descriptor here
for i = 1:length(db_text)
    ssd(i)=0;
    for j = 1:length(uniq_words)
        ssd(i) = ssd(i) + ((query_count(1,j) - db_count(i,j)) * (query_count(1,j) - db_count(i,j)));
    end
end

 
% return the 10 closest images to the query here
[Y,I] = sort(ssd);
for i = 1:10
   result{i} = strrep(strrep(db_text(I(i)).name,'.txt','.jpg'),'descr_','img_');
end

closestMatches = result;


% create a webpage showing the results
fid = fopen('imageRetrieval_text.html','w');
fprintf(fid,'<html><body>\n');
for i=1:length(result)
	picname = result{i};
	fprintf(fid,['<img src="images/' picname  '">\n']);
	if mod(i,3)==0
		fprintf(fid,'<br>');
	end
end
fprintf(fid,'</html>');
fclose(fid);



