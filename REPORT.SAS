/* creating a new powerpoint*/

ods powerpoint file="/folders/myfolders/iSAS/project.pptx";

proc odstext;
   p "Imparting Insights from the analysis of Online Course" / style=PresentationTitle;
   p "SAS Project"/ style=PresentationTitle2;
   p ' ';
   p ' ';
   p ' ';
   list;
   end;
run;

proc odstext;
   p "OUTLINE" / style=PresentationTitle;
   p " "/ style=PresentationTitle2;
   list;
   	item 'Data Collection';
   	item 'Data Cleaning & Processing';
   	item 'Statistical Inferences';
   	item 'Conclusion';
	end;
run;

proc odstext;
   p "DATA COLLECTION" / style=PresentationTitle;
   p " "/ style=PresentationTitle2;
   P "4 different tables have been collected from different sources";
   p "Table Definitions";
   list;
   	item 'Harvard Online Courses Entries';
   	item 'MIT Online Courses Entries';
   	item 'Harvard Courses Description Details';
   	item 'MIT Courses Description Details';
	end;
run;


proc odstext;
   p "DATA CLEANING AND PROCESSING" / style=PresentationTitle;
   p " "/ style=PresentationTitle2;
   P 'Both Harvad & MIT Datasets are combined Together and created Permanent Dataset PRJ.MOOC';
	
   p "Key Data Cleaning Steps";
   list;
   	item 'NAs and Missing Values are removed';
   	item 'Anamolies in Gender & Age removed';
   	item 'Anamolies in Countries removed';
   end;
   p "Key Data Processing Steps";
   list;
   	item 'Harvard & MIT Courses Description are combined together';
   	item 'The new dataset is merged column-wise with PRJ.MOOC (Left Join is used)';
   	item "A New dataset PRJ.STUDENT with unique student entires is created";
	end;
run;


proc odstext;
	
	p 'Statistical Inferences'  / style=PresentationTitle;

run;


PROC SGPLOT DATA=PRJ.STUDENT;
	HISTOGRAM AGE /BINWIDTH=5 FILLATTRS=GRAPHDATA2;
	Title 'AGE DISTRIBUTION OF STUDENTS WHO TOOK ONLINE COURSES';
	YAXIS LABEL='% OF STUDENTS';
RUN;	


PROC SGPLOT DATA=PRJ.STUDENT;
	HBAR LOE_DI /FILLATTRS=graphdata5;
	YAXIS LABEL='LEVEL OF EDUCATION';
	XAXIS LABEL = 'NO. OF STUDENTS';
	TITLE 'EDUCATION LEVEL OF STUDENTS IN ONLINE COURSES';
RUN;	

/* TO READ THE USER DEFINED FORMAT */

OPTIONS FMTSEARCH=(PRJ);
PROC SGPLOT DATA=PRJ.STUDENT;
	VBAR GENDER /FILLATTRS=graphdata6;
	FORMAT GENDER $GENDER.;
	YAXIS LABEL='NO. OF STUDENTS';
	XAXIS LABEL = 'GENDER';
	TITLE 'GENDER DISTRIBUTION OF STUDENTS IN ONLINE COURSES';
RUN;	


PROC SGPLOT DATA=PRJ.STUDENT;
	HBAR final_cc_cname_DI  /FILLATTRS=graphdata8 BARWIDTH=.98;
	XAXIS LABEL='COUNTRIES';
	YAXIS LABEL = 'NO. OF STUDENTS';
	TITLE 'COUNTRIES THAT THE STUDENTS BELONG TO';
RUN;	


ODS GRAPHICS /  width=6in;
PROC SGPLOT DATA=PRJ.MOOC;
	HBAR FULL_TITLE /GROUP=UNIV_NAME;
	
	XAXIS LABEL='COURSES' FITPOLICY=THIN SPLITCHAR=':-/';
	YAXIS LABEL = 'NO. OF REGISTERED STUDENTS' FITPOLICY=split SPLITCHAR=':-/';
	TITLE 'COURSE ENTROLLMENT';
RUN;	
ODS GRAPHICS  / reset=width;

/* TO DRAW 100% STACKED BAR PLOT */

PROC FREQ DATA=PRJ.MOOC noprint;
    TABLE GENDER*STATUS/out=FREQ OUTPCT;
quit;


PROC SGPLOT DATA=FREQ;
	VBAR GENDER /GROUP=STATUS RESPONSE=PCT_ROW GROUPDISPLAY=STACK;
	YAXIS LABEL='NO. OF REGISTERED STUDENTS';
	XAXIS LABEL = 'GENDER' ;
	TITLE 'COURSE STATUS BY GENDER';
RUN;	

/* TO DISPLAY THE FREQUENCY IN PERCENTAGE */

PROC FREQ DATA=PRJ.MOOC noprint;
    TABLE FULL_TITLE*STATUS/out=FREQ OUTPCT;
quit;
 

PROC SGPLOT DATA=FREQ;
	HBAR FULL_TITLE /GROUP=status response=pct_row;
	
	XAXIS LABEL='COURSES' FITPOLICY=THIN SPLITCHAR=':-/';
	YAXIS LABEL = 'NO. OF REGISTERED STUDENTS' FITPOLICY=split SPLITCHAR=':-/';
	TITLE 'COURSE ENTROLLMENT';
RUN;	

PROC SGPLOT DATA=PRJ.INDIA;
	TITLE 'COURSE REGISTRATION BY INDIANS';
	HBAR FULL_TITLE/GROUP=GENDER;
	XAXIS LABEL='COURSES' FITPOLICY=THIN SPLITCHAR=':-/';
	YAXIS LABEL = 'NO. OF REGISTERED INDIAN STUDENTS' FITPOLICY=split SPLITCHAR=':-/';	
RUN;

ODS _ALL_ CLOSE;



