#include "doxyblock.h"
#include <sstream>
#include <fstream>
#include <stdlib.h>
#include <string.h>
#include <iostream>

using namespace std;
#define NB_NODE_MAX 1024

extern node  LIST_NODE[NB_NODE_MAX];
int no=0;
node* plist=&LIST_NODE[0];

void fixblock(char* filename)
{
  int count=0;
  ofstream output;
  stringstream ss;
  string nfm=new_filename(filename);
  int  hit_tag=0;
  FILE* id=fopen(filename,"r");
  if (id)
  {
    printf("fix %s to %s\n",filename,nfm.c_str());
    char line[MAX_LINE];	  
    while(readline(id,line)==0)
    {
	if (line[0]=='<')
	{
	    line[0]='>';
	    hit_tag++;
	}
	plist->line<<line;
	node* prev =plist;
	node* _node=&LIST_NODE[++no];
	_node->next=NULL;
	_node->prev=prev;
	plist->next=_node;
        // add the first node	
	if (plist==&LIST_NODE[0])
	{
	   plist->prev=NULL;
           plist=_node;
	}else
	// add a new node
	{
           plist=_node;
        }

        if (hit_tag==1 && plist->prev)
        {
	//delete the previous node
	//pointer plist is always one stage forward
        //jump twice back 
        node* next=plist->next;

	cout <<"[]" << plist->line.str(); // -> main
	plist=plist->prev;
        cout <<"[]" << plist->line.str(); // -> diff tag	
        plist=plist->prev;
        cout <<"[]" << plist->line.str(); // -> jump	
        plist=plist->prev;
        cout <<"[]" << plist->line.str(); // -> jump	

        plist->next=next;	
	}
    }
    plist=&LIST_NODE[0];
    while(plist!=NULL)
    {
      ss << plist->line.str(); 	
      //cout <<"[" <<count++<<"]" << plist->line.str();	
      plist=plist->next;
    }
    output.open((nfm.c_str()),ios::out);
    if (!output)
    {
	printf("error opening %s\n",nfm.c_str());
    	fclose(id);
	return;
    }
    output << ss.str();
    output.close();
    fclose(id);
    printf("fixblock done. \n");
  }
}
/* renomme .c ou .h en .003 */
string new_filename(char* filename)
{
   char  nfm[FILENAME_MAX];
   char* pScanNfm=nfm;
   char* pScan=filename;

   while(*pScan!='\0' && *pScan!='.')
   {
     *pScanNfm++=*pScan++;
   }
   *pScanNfm++=*pScan++;
   *pScanNfm++=*pScan++;
   *pScanNfm++='.';
   *pScanNfm++='0';
   *pScanNfm++='0';
   *pScanNfm++='3';
   *pScanNfm='\0';
   return string(nfm);
}
