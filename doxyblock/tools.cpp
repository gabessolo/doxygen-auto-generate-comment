#include "doxyblock.h"
#include <stdio.h>
#include <string.h>

int readline(FILE* id,char* line) 
{
  char* pScan=line;
  if (id==NULL ) return -1;
  memset(line,'\0',MAX_LINE);  
  while(fread(pScan,sizeof(char),1,id)!=0 && *pScan!='\n'  && (pScan-line)<MAX_LINE)
  {
  	pScan++;
  }

  if ((pScan-line)==MAX_LINE) 
  {
     return -1;
  }

  if (*pScan=='\n')
  {
    return 0;
  }

  return -1;
}
