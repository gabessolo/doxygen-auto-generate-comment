  
#include <stdio.h>  
#include <unistd.h>  
#include "doxyblock.h"

node  LIST_NODE[NB_NODE_MAX];
int main(int argc, char *argv[])  
{ 
    int opt; 
    char* value;

    while((opt = getopt(argc, argv, "f:a:i:")) != -1)  
    {  
        switch(opt)  
        {  
            case 'a':  
            case 'i':  
	        value=optarg;
	        addblock(value);	
                break;  
            case 'f':  
	        value=optarg;
	        fixblock(value);	
                break;
	    case '?':
        	if (opt == 'a' || opt=='i' || opt=='f')
          		printf ("Option -%c requires an argument.\n", opt);
	    default: usage();	
                break;  
        }  
    }  
      
      
    return 0; 
} 

void usage()  
{ 
     printf("doxyblock [-f filename] : make a diff file [diff filename filename.002] diff compliant \n");  
     printf("doxyblock [-i filename] : add block  doxygen compliant\n");  
     printf("doxyblock [-a filename] : add block  doxygen compliant\n");  
}

