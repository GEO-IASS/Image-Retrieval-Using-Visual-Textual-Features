
************************************************************************** 

Submitter:

	108771077 : SAGARDEEP MAHAPATRA
	108800494 : BISWARANJAN PANDA	

This file is divided into three parts describing the following:

	PART A: SETUP
	PART B: HOW TO RUN CODE
	PART C: HOW TO VIEW THE RESULTS

**************************************************************************



************ PART A : SETUP *************

Database of images: 'images' folder

Database of query images: 'queryimages' folder

Following are the 4 matlab source files in the shopping folder.

1) imageRetrieval_image	- this retrieves images based on grayscale tiny-image descriptors

2) imageRetrieval_text - this retrieves images based on word vector descriptors

3) imageRetrieval_combined - this retrieves images based on both grayscale tiny image descriptor and word vector descriptor

4) imageRetrieval_freestyle -- this retrieves images based on the cosine values of the word vectors




************ PART B : HOW TO RUN CODE **********


Each of the matlab files mentioned above in the setup has a function defined with the same name as the file. These functions  can be called from the matlab command window in the following manner: 

result = function_name(queryimage, databaseDirectory, queryDirectory)


Examples:

result = imageRetrieval_image('img_bags_clutch_1.jpg','D:\CS595 WP\WPAssignment\shopping\images\','D:\CS595 WP\WPAssignment\shopping\queryimages\')

result = imageRetrieval_text('img_womens_pumps_600.jpg','D:\CS595 WP\WPAssignment\shopping\images\','D:\CS595 WP\WPAssignment\shopping\queryimages\') 

result = imageRetrieval_combined('img_womens_flats_300.jpg','D:\CS595 WP\WPAssignment\shopping\images\','D:\CS595 WP\WPAssignment\shopping\queryimages\') 

result = imageRetrieval_freestyle('img_womens_pumps_600.jpg','D:\CS595 WP\WPAssignment\shopping\images\','D:\CS595 WP\WPAssignment\shopping\queryimages\')


Note: Please make sure to correctly mention the databaseDirectory and queryDirectory while calling the function.




******** PART C : HOW TO VIEW THE RESULTS *******


Following webpages are created in the working directory displaying the results:


'imageRetrieval_image' function creates a webpage 'imageRetrieval_image.html'

'imageRetrieval_text' function creates a webpage 'imageRetrieval_text.html'

'imageRetrieval_combined' function creates a webpage 'imageRetrieval_combined.html'

'imageRetrieval_freestyle' function creates a webpage 'imageRetrieval_freestyle.html'


Note: The webpages currently existing in the shopping folder are the results that we received for the four example cases mentioned above in PART B.